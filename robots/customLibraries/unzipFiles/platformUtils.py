import platform

class PlatformUtils:
  @staticmethod
  def get_zip_extension():
    if platform.system() == "Darwin":
        return "+macos.aarch64.zip"
    elif platform.system() == "Windows":
        return "+windows.amd64.zip"
    else:
        return ".zip"