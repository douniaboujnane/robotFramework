*** Settings ***
Library   ../custom/InstallerOperations.py
Library   ../custom/SensorInstallationLibrary.py

*** Tasks ***
Install sensor
    [Documentation]    Evaluate the platform (Windows or macOS) and install sensor
    ${PLATFORM}=    Detect Current Platform
    ${DOWNLOAD_FOLDER}=    Find Downloads Folder
    ${OUTPUT_FOLDER}=    Unzip File Located In Directory   ${DOWNLOAD_FOLDER}
    ${INSTALLER_PATH}=    Get Installer Path    ${OUTPUT_FOLDER}
    Execute Installer    ${INSTALLER_PATH}


*** Keywords ***
Unzip File Located In Directory
    [Arguments]    ${directory}
    [Documentation]    Extracts the ZIP file found in the specified directory
    ${output_dir}=    Extract Sensor Package From Folder    ${directory}
    [Return]    ${output_dir}
