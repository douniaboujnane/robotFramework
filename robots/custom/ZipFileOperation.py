import platform
import shutil
import zipfile
import os
import subprocess

class ZipFileOperation:
    def __init__(self):
        pass
        
    def unzip_file_located_in_directory(self, directory):
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

