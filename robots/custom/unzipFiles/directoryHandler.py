import os, shutil

class DirectoryHandler:
    @staticmethod
    def prepare_output_dir(output_dir):
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
        else:
            if os.listdir(output_dir):
                shutil.rmtree(output_dir)
                os.makedirs(output_dir)
                print(f"Directory {output_dir} cleaned up")
