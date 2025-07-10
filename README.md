# Spotless Uninstaller

Spotless Uninstaller is a post-uninstall cleanup utility designed for Windows. After a program is uninstalled, this tool searches for and removes any leftover files and folders—especially those in hidden and system directories—that may interfere with reinstalling updated versions.

## Features
- Monitors Windows uninstall activity
- Scans AppData, Program Files, ProgramData, and registry remnants
- Deletes residual folders and hidden files
- Prevents reinstall errors from incomplete uninstalls

## Usage
Ensure Python is installed and run the main script:

```bash
python src/spotless_uninstaller.py
```

## Requirements
- Python 3.7+
- psutil

## License
MIT License
