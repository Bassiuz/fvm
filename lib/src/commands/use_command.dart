import 'package:args/command_runner.dart';
import 'package:io/io.dart';

import '../services/cache_service.dart';
import '../services/logger_service.dart';
import '../services/project_service.dart';
import '../services/releases_service/models/channels.model.dart';
import '../services/releases_service/releases_client.dart';
import '../utils/console_utils.dart';
import '../utils/helpers.dart';
import '../workflows/ensure_cache.workflow.dart';
import '../workflows/use_version.workflow.dart';
import 'base_command.dart';

/// Use an installed SDK version
class UseCommand extends BaseCommand {
  @override
  final name = 'use';

  @override
  String description =
      'Sets Flutter SDK Version you would like to use in a project';

  /// Constructor
  UseCommand() {
    argParser
      ..addFlag(
        'force',
        abbr: 'f',
        help: 'Skips command guards that does Flutter project checks.',
        negatable: false,
      )
      ..addFlag(
        'pin',
        abbr: 'p',
        help:
            '''If version provided is a channel. Will pin the latest release of the channel''',
        negatable: false,
      )
      ..addOption(
        'flavor',
        help: 'Sets version for a project flavor',
        defaultsTo: null,
        aliases: ['env'],
      )
      ..addFlag(
        'skip-setup',
        abbr: 's',
        help: 'Skips Flutter setup after install',
        negatable: false,
      );
  }
  @override
  Future<int> run() async {
    final forceOption = boolArg('force');
    final pinOption = boolArg('pin');
    final flavorOption = stringArg('flavor');
    final skipSetup = boolArg('skip-setup');

    String? version;

    final project = ProjectService.fromContext.findAncestor();

    // If no version was passed as argument check project config.
    if (argResults!.rest.isEmpty) {
      version = project.pinnedVersion?.name;
      final versions = await CacheService.fromContext.getAllVersions();
      // If no config found, ask which version to select.
      version ??= cacheVersionSelector(versions);
    }

    // Get version from first arg
    version ??= argResults!.rest[0];

    // Get valid flutter version. Force version if is to be pinned.
    if (pinOption) {
      if (!isFlutterChannel(version) || version == 'master') {
        throw UsageException(
          'Cannot pin a version that is not in dev, beta or stable channels.',
          usage,
        );
      }

      /// Pin release to channel
      final channel = FlutterChannel.fromName(version);

      final release = await FlutterReleases.getLatestReleaseOfChannel(channel);

      logger.info(
        'Pinning version ${release.version} from "$version" release channel...',
      );

      version = release.version;
    }

    // Gets flavor version
    final flavorVersion = project.flavors[version];

    if (flavorVersion != null) {
      if (flavorOption != null) {
        throw UsageException(
          'Cannot use the --flavor when using fvm use {flavor}',
          usage,
        );
      }

      logger.info(
        'Using Flutter SDK from flavor: "$version" which is "$flavorVersion"',
      );
      version = flavorVersion;
    }

    if (flavorOption != null) {
      // check if flavor option is not a channel name or semver
      if (isFlutterChannel(flavorOption)) {
        throw UsageException(
          'Cannot use a channel as a flavor, use a different name for flavor',
          usage,
        );
      }
    }

    final cacheVersion = await ensureCacheWorkflow(version, force: forceOption);

    /// Run use workflow
    await useVersionWorkflow(
      version: cacheVersion,
      project: project,
      force: forceOption,
      skipSetup: skipSetup,
      flavor: flavorOption,
    );

    return ExitCode.success.code;
  }

  @override
  String get invocation => 'fvm use {version}';
}
