import os
import subprocess
import platform

class InstallerOperations:
    # Platform constants
    SUPPORTED_PLATFORMS = ["Windows", "Darwin", "Linux"]
    
    # Platform-specific configurations
    DOWNLOADS_PATHS = {
        "Windows": "Downloads",
        "Darwin": "Downloads",
        "Linux": "Downloads"
    }
    
    INSTALLER_EXTENSIONS = {
        "Windows": ".exe",
        "Darwin": ".pkg",
        "Linux": ".deb"
    }
    
    INSTALL_COMMANDS = {
        "Windows": '{installer_path} /s /v"/l*v {log_path} /qn"',
        "Darwin": 'sudo installer -pkg {installer_path} -target /',
        "Linux": 'sudo dpkg -i {installer_path}'
    }
    
    def __init__(self):
        pass
    
    def _get_current_platform(self):
        platform_str = platform.system()
        
        if platform_str in self.SUPPORTED_PLATFORMS:
            return platform_str
        else:
            raise EnvironmentError(f"Unsupported platform: {platform_str}")
    
    def get_downloads_directory(self):
        home_dir = os.path.expanduser("~")
        current_platform = self._get_current_platform()
        downloads_folder = self.DOWNLOADS_PATHS[current_platform]
        return os.path.join(home_dir, downloads_folder)

    def get_installer_path(self, output_dir):
        current_platform = self._get_current_platform()
        extension = self.INSTALLER_EXTENSIONS[current_platform]
        installer_name = os.path.basename(output_dir) + extension
        installer_path = os.path.join(output_dir, installer_name)
        
        if not os.path.exists(installer_path):
            raise FileNotFoundError(f"Installer {installer_path} not found")
        
        return installer_path

    def execute_installer(self, installer_path):
        current_platform = self._get_current_platform()
        log_path = os.path.join(os.path.dirname(installer_path), "installer.log")
        
        command_template = self.INSTALL_COMMANDS[current_platform]
        command = command_template.format(installer_path=installer_path, log_path=log_path)
        
        subprocess.call(command, shell=True)
        print(f"Executed installer {installer_path} with log at {log_path}")