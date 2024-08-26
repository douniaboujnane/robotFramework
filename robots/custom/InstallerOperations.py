import os
import subprocess
import platform

class InstallerOperations:
    def __init__(self):
        pass
    
    def get_downloads_directory(self, platform):
      home_dir = os.path.expanduser("~")
      if platform == "Windows":
          return os.path.join(home_dir, "Downloads")
      elif platform == "Darwin":
          return os.path.join(home_dir, "Downloads")
      else:
          raise EnvironmentError(f"Unsupported platform {platform.system()}")

    def get_installer_path(self, output_dir):
        if platform.system() == "Windows":
            installer_name = os.path.basename(output_dir) + ".exe"
        elif platform.system() == "Darwin":
            installer_name = os.path.basename(output_dir) + ".pkg"
        else:
            raise EnvironmentError(f"Unsupported platform {platform.system()}")
        
        installer_path = os.path.join(output_dir, installer_name)
        if not os.path.exists(installer_path):
            raise FileNotFoundError(f"Installer {installer_path} not found")
        
        return installer_path

    def execute_installer(self, installer_path):
        log_path = os.path.join(os.path.dirname(installer_path), "installer.log")
        if platform.system() == "Windows":
            command = f'{installer_path} /s /v"/l*v {log_path} /qn"'
        elif platform.system() == "Darwin":
            command = f'sudo installer -pkg {installer_path} -target /'
        else:
            raise EnvironmentError(f"Unsupported platform {platform.system()}")
        
        subprocess.call(command, shell=True)
        print(f"Executed installer {installer_path} with log at {log_path}")