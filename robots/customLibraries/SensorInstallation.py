import os
import platform

from robots.customLibraries.InstallerOperations import InstallerOperations
from robots.customLibraries.unzipFiles.zipFileOperation import ZipFileOperation


class SensorInstallation:
    
    def __init__(self):
        self.installer_ops = InstallerOperations()
        self.zip_ops = ZipFileOperation()
        self.current_platform = platform.system()
    
    def detect_current_platform(self):
        platform_name = self.current_platform
        print(f"Platform detected: {platform_name}")
        return platform_name
    
    def find_downloads_folder(self):
        downloads_path = self.installer_ops.get_downloads_directory()
        print(f"Downloads folder found: {downloads_path}")
        return downloads_path
    
    def extract_sensor_package_from_folder(self, folder_path):
        if not os.path.exists(folder_path):
            raise FileNotFoundError(f"Folder {folder_path} does not exist")
        
        print(f"Searching for sensor package in: {folder_path}")
        extracted_path = self.zip_ops.unzip_file_located_in_directory(folder_path)
        print(f"Package extracted to: {extracted_path}")
        return extracted_path
    
    def locate_sensor_installer(self, extracted_folder):
        installer_path = self.installer_ops.get_installer_path(extracted_folder)
        print(f"Installer found: {installer_path}")
        return installer_path
    
    def install_sensor_silently(self, installer_path):
        print(f"Starting silent installation: {installer_path}")
        self.installer_ops.execute_installer(installer_path)
        print("Installation completed successfully")
    
    def verify_folder_exists(self, folder_path):
        exists = os.path.exists(folder_path)
        if exists:
            print(f"✓ Folder exists: {folder_path}")
        else:
            print(f"✗ Folder does not exist: {folder_path}")
        return exists
    
    def list_files_in_folder(self, folder_path):
        if not os.path.exists(folder_path):
            print(f"Folder {folder_path} does not exist")
            return []
        
        files = os.listdir(folder_path)
        print(f"Files found in {folder_path}:")
        for file in files:
            print(f"  - {file}")
        return files