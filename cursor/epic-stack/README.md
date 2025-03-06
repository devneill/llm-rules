# Project Scripts

This directory contains utility scripts for the DinnerNotOnYourOwn project.

## Update Project Structure

The `update-structure.sh` script automatically updates the Project Structure section in the PRD file (`.cursor/rules/prd.mdc`) with the current project structure.

### Usage

#### One-time update

To update the PRD once:

```bash
./scripts/update-structure.sh
```

#### Watch mode

To continuously watch for file changes and update the PRD automatically:

```bash
./scripts/update-structure.sh --watch
```

This requires `fswatch` to be installed on your system. If it's not installed, the script will provide instructions on how to install it.

#### Using npm script

We've added an npm script for convenience:

```bash
npm run update-prd
```

This will run the script in watch mode, automatically updating the PRD whenever files change in the project.

### How it works

The script uses the `tree` command to generate a visual representation of the project structure, excluding directories like `node_modules`, `.git`, and `build`. It then updates the "Project Structure" section in the PRD file with this information.

In watch mode, it uses `fswatch` to monitor file changes and trigger updates automatically. The script is optimized to only update the PRD when there are actual changes to the project structure, avoiding unnecessary updates and file writes.

### Requirements

- `tree`: Used to generate the project structure visualization
- `fswatch`: Required for watch mode to monitor file changes

#### Installing requirements

On macOS:
```bash
brew install tree fswatch
```

On Ubuntu/Debian:
```bash
sudo apt-get install tree fswatch
```

On Fedora/RHEL:
```bash
sudo dnf install tree fswatch
```
