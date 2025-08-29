from robots.custom.unzipFiles import ZipFileOperation

if __name__ == "__main__":
    z = ZipFileOperation()
    output = z.unzip_file_located_in_directory("/")
    print(f"✅ Décompression réussie dans : {output}")
