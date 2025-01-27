---
id: basic_commands
title: Basic Commands
---

# Basic Commands

## Use

Sets a specific Flutter SDK version for a project, ensuring environment consistency or meeting project-specific SDK needs.

**Usage**

```bash
> fvm use [version] [options]
```

`version`: Desired Flutter SDK version (e.g., `2.2.3`) or channel (e.g., `stable`).

**Options**

- `-f, --force`:  Bypasses Flutter project checks, assuming version compatibility.

- `-p, --pin`: Pins the latest release of a specified channel.

- `--flavor`: Specifies the SDK version for a particular project flavor in multi-flavored projects.

- `-s,--skip-setup`:  Omits Flutter setup post-installation for expedited process.

**Examples**

**Setting a Specific Version**:  
To set your project to use Flutter version `2.2.3`, you would run:

```bash
fvm use 2.2.3
```

**Using a Channel**:  
To use the latest stable channel version, you can run:

```bash
fvm use stable
```

If you want to pin this channel to its current latest release, use the `--pin` flag:

```bash
fvm use stable -p
```

**Using a commit hash**:

You are able to install and bind a specific framework revision by providing the git commit or short hash.

```bash
# Short hash
fvm use fa345b1
# Long hash
fvm use 476ad8a917e64e345f05e4147e573e2a42b379f9
```

**Forcing a Version**:  
If you need to set a version without performing the usual project checks, use the `--force` flag:

```bash
fvm use 2.2.3 --force
```

**Setting a Version for a Specific Flavor**:  
For a project with multiple flavors, set a version for a specific flavor like this:

```bash
fvm use 2.2.3 --flavor production
```

**Using a Flavor**
To switch to a specific flavor, you can use the `use` command with the name of the flavor:

```bash
fvm use production
```

## Install

Installs a specified Flutter SDK version to your machine and caches it for future use. 

**Usage**

```bash
> fvm install [version]
```

Without `[version]`, installs the version specified in the project's FVM settings.

**Options**

- `-s, --setup`: Builds the SDK post-installation for immediate readiness.

**Examples**

**Installing a Specific Version**:  
To install Flutter SDK version `2.5.0`, you would use:

```bash
fvm install 2.5.0
```

**Installing with Automatic Setup**:  
If you want FVM to perform setup tasks after installation (like downloading dependencies), use the `--setup` flag:

```bash
fvm install 2.5.0 --setup
```

**Installing from Project Configuration**:  
If you run `fvm install` within a Flutter project that already has an FVM configuration, it will install the version specified in that configuration:

```bash
fvm install
```

## Destroy

The `destroy` command in FVM is a powerful tool used to completely remove the FVM cache, including all cached Flutter SDK versions. This command is useful for cleaning up space or resetting your FVM setup.

**Usage**

```bash
> fvm destroy
```

**Example**

**Destroying the FVM Cache**:  
To destroy the FVM cache and delete all cached Flutter SDK versions, simply run:

```bash
fvm destroy
```

## Exec

The `exec` command in FVM is designed to execute scripts or commands using the Flutter SDK version configured for your project. This command is particularly useful for ensuring that the correct version of the Flutter SDK is used for various scripts and operations in a project-specific context.

**Usage**

```bash
> fvm exec <command> [arguments]
```

`<command>`: The command or script you want to execute using the Flutter SDK.

`[arguments]`: Any additional arguments you want to pass to the command.


**Examples**

**Running a Flutter Command**:  
To run a Flutter command (like `melos bootstrap`) using the project's Flutter SDK version:

```bash
fvm exec melos bootstrap
```

**Running a Script**:  
If you have a script that should be run with the project's Flutter SDK, you can execute it like this:

```bash
fvm exec path/to/script.sh
```

## Global

The `global` command in FVM (Flutter Version Management) is used to set a specific Flutter SDK version as the global version on your machine. This command is essential for defining a default Flutter SDK version for use across all Flutter projects that do not have a project-specific version set through FVM.

**Usage**

```bash
> fvm global [version]
```

`[version]`: Flutter SDK version you want to set as the global version.


**Examples**

**Setting a Global Version**:  
To set Flutter SDK version `2.5.0` as your global version, you would run:

```bash
fvm global 2.5.0
```

**Unlinking the Global Version**:
To unlink the global version, you can run:

```bash
fvm global --unlink
```


## List

The `list` command in FVM (Flutter Version Management) is used to display a list of all Flutter SDK versions that have been installed via FVM on your machine. This command provides a quick and easy way to review the versions available for use in your projects.

**Usage**

```bash
> fvm list
```

or its alias:

```bash
> fvm ls
```

**Example**

**Listing Installed SDK Versions**:  
To see a list of all Flutter SDK versions installed via FVM, simply run:

```bash
fvm list
```


## Releases

The `releases` command in FVM (Flutter Version Management) allows you to view all available Flutter SDK releases, making it easier to choose which version to install or switch to. This command is particularly helpful for staying updated with the latest releases and understanding the Flutter release landscape.

**Usage**

```bash
> fvm releases [options]
```

**Options**

- `-c, --channel [channel_name]`: Filter the releases by a specific channel (e.g., `stable`, `beta`, `dev`). If no channel is specified, it defaults to showing releases from the `stable` channel.

**Examples**

**Viewing All Releases**:  
To view all available Flutter SDK releases:

```bash
fvm releases
```

**Filtering by Channel**:  
To view only the releases from the `beta` channel:

```bash
fvm releases --channel beta
```

## Remove

The `remove` command in FVM (Flutter Version Management) is used to remove a specific Flutter SDK version from your machine. 

**Usage**

```bash
> fvm remove [version]
```

`[version]`: The Flutter SDK version you want to remove.


**Examples**

**Removing a Specific Version**:  
To remove Flutter SDK version `2.2.3` from your machine, you would run:

```bash
fvm remove 2.2.3
```

## Spawn

The `spawn` command is used to execute Flutter commands using a specific Flutter SDK version.

This command is particularly useful when you need to run a Flutter command (such as `flutter build`) with a version of the SDK different from the one currently active or configured in your project.

**Usage**

```bash
> fvm spawn [version] [flutter_command] [flutter_command_args]
```

`[version]`: The Flutter SDK version you want to use for running the command.

`[flutter_command]`: The Flutter command you want to execute.

`[flutter_command_args]`: Any additional arguments you want to pass to the Flutter command.

**Examples**

**Running a Build with a Specific SDK Version**:  
To build your Flutter project using version `2.5.0` of the Flutter SDK:

```bash
fvm spawn 2.5.0 flutter build
```

**Running Tests with a Different SDK Version**:  
If you need to run tests using a particular Flutter SDK version:

```bash
fvm spawn 2.2.3 flutter test
```