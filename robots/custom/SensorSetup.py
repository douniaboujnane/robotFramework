import platform
import shutil
import zipfile
import os
import subprocess

class SensorSetup:
    def get_downloads_directory(self):
        home_dir = os.path.expanduser("~")
        if platform.system() == "Windows":
            return os.path.join(home_dir, "Downloads")
        elif platform.system() == "Darwin":
            return os.path.join(home_dir, "Downloads")
        else:
            raise EnvironmentError(f"Unsupported platform {platform.system()}")
    
    def unzip_file_in_directory(self, directory):
        if not os.path.exists(directory):
            raise FileNotFoundError(f"Directory {directory} not found")

        platform_zip_ext = "+macos.aarch64.zip" if platform.system() == "Darwin" else "+windows.amd64.zip"
        zip_files = [f for f in os.listdir(directory) if f.endswith(platform_zip_ext)]
        
        if not zip_files:
            zip_files = [f for f in os.listdir(directory) if f.endswith(".zip")]
        
        if not zip_files:
            raise FileNotFoundError(f"No zip files found in {directory}")

        zip_file = zip_files[0]
        print(f"Found zip file: {zip_file}")
        
        zip_file_path = os.path.join(directory, zip_file)
        output_dir = os.path.join(directory, os.path.splitext(zip_file)[0])

        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
        else:
            if os.listdir(output_dir):
                shutil.rmtree(output_dir)
                os.makedirs(output_dir)
                print(f"Directory {output_dir} cleaned up")
        
        with zipfile.ZipFile(zip_file_path, 'r') as zip_ref:
            zip_ref.extractall(output_dir)
        
        if not os.listdir(output_dir):
            raise FileNotFoundError(f"Failed to unzip {zip_file_path} to {output_dir}")
        
        print(f"File {zip_file_path} successfully unzipped to {output_dir}")
        return output_dir



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

    def execute_windows_installer(self, installer_path):
        log_path = os.path.join(os.path.dirname(installer_path), "installer.log")
        command = f'{installer_path} /s /v"/l*v {log_path} /qn"'
        """ subprocess.call(command, shell=True) """
        print(f"Executed installer {installer_path} with log at {log_path}")

    def execute_macos_installer(self, installer_path):
        log_path = os.path.join(os.path.dirname(installer_path), "installer.log")
        command = f'sudo installer -pkg {installer_path} -target /'
        subprocess.call(command, shell=True)
        print(f"Executed installer {installer_path} with log at {log_path}")