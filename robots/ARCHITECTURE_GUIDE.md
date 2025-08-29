# Robot Framework Architecture

## Overview

This architecture improves the robotFramework project by using **natural language keywords** to make the code more understandable for less technical people.

## Project Structure

```
robots/
├── tasks.robot                           # Main entry point
├── custom/
│   ├── SensorInstallationLibrary.py     # Library with natural keywords
│   ├── InstallerOperations.py           # Installation operations
│   └── unzipFiles/
│       ├── zipFileOperation.py          # ZIP operations
│       ├── directoryHandler.py          # Folder management
│       └── platformUtils.py             # Platform utilities
└── sensor/
    ├── install_sensor_improved.robot    # Improved installation keywords
    └── install_sensor.robot             # Original version
```

## Usage

### Main Execution

```bash
robot --report NONE --outputdir output --logtitle "Task log" tasks.robot
```

## Robocorp Configuration

The project uses:

- `conda.yaml` for Python dependencies
- `robot.yaml` for Robot Framework configuration
- Multi-platform support (Windows, macOS, Linux)

## Extensibility

The architecture allows easy addition of:

- New sensor types
- New platforms
- Custom keywords
- Advanced diagnostics
