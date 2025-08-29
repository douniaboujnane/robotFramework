import os, zipfile

from robots.customLibraries.unzipFiles.directoryHandler import DirectoryHandler
from robots.customLibraries.unzipFiles.platformUtils import PlatformUtils

class ZipFileOperation:
    def unzip_file_located_in_directory(self, directory):
        if not os.path.exists(directory):
            raise FileNotFoundError(f"Directory {directory} not found")

        ext = PlatformUtils.get_zip_extension()
        zip_files = [f for f in os.listdir(directory) if f.endswith(ext)]
        if not zip_files:
            zip_files = [f for f in os.listdir(directory) if f.endswith(".zip")]
        if not zip_files:
            raise FileNotFoundError(f"No zip files found in {directory}")

        zip_file = zip_files[0]
        zip_file_path = os.path.join(directory, zip_file)
        output_dir = os.path.join(directory, os.path.splitext(zip_file)[0])

        DirectoryHandler.prepare_output_dir(output_dir)

        with zipfile.ZipFile(zip_file_path, 'r') as zip_ref:
            zip_ref.extractall(output_dir)

        if not os.listdir(output_dir):
            raise FileNotFoundError(f"Failed to unzip {zip_file_path} to {output_dir}")

        print(f"File {zip_file_path} successfully unzipped to {output_dir}")
        return output_dir
