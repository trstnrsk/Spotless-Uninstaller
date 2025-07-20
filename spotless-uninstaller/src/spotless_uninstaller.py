import os
import psutil
import shutil
import time

def get_installed_programs():
    # Dummy placeholder for real uninstall monitoring
    return ["ExampleApp"]

def remove_leftovers(program_name):
    targets = [
        os.path.expandvars(f"%ProgramFiles%\\{program_name}"),
        os.path.expandvars(f"%ProgramFiles(x86)%\\{program_name}"),
        os.path.expandvars(f"%APPDATA%\\{program_name}"),
        os.path.expandvars(f"%LOCALAPPDATA%\\{program_name}"),
        os.path.expandvars(f"%PROGRAMDATA%\\{program_name}")
    ]

    for path in targets:
        path = os.path.normpath(path)
        if os.path.exists(path):
            try:
                shutil.rmtree(path)
                print(f"Removed: {path}")
            except Exception as e:
                print(f"Failed to remove {path}: {e}")

def main():
    print("Spotless Uninstaller started. Waiting for uninstall event...")
    time.sleep(10)  # Placeholder for hook or listener
    removed_programs = get_installed_programs()
    for prog in removed_programs:
        print(f"Cleaning leftovers from: {prog}")
        remove_leftovers(prog)

if __name__ == "__main__":
    main()
