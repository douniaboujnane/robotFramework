*** Settings ***
Library   ../custom/ZipFileOperation.py
Library   ../custom/InstallerOperations.py

*** Tasks ***
Install sensor
    [Documentation]    Evaluate the platform (Windows or macOS) and install sensor
    ${PLATFORM}=    Evaluate    platform.system()
    ${DOWNLOAD_FOLDER}=    Get Downloads Directory    ${PLATFORM}
    ${OUTPUT_FOLDER}=    Unzip File Located In Directory   ${DOWNLOAD_FOLDER}
    ${INSTALLER_PATH}=    Get Installer Path    ${OUTPUT_FOLDER}
    Execute Installer    ${INSTALLER_PATH}