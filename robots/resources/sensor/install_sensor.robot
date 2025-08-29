*** Settings ***
Documentation    Automatic sensor installation with natural language steps
Library          ../../customLibraries/SensorInstallation.py

*** Variables ***
${DOWNLOADS_FOLDER}    ${EMPTY}
${EXTRACTED_FOLDER}    ${EMPTY}
${INSTALLER_PATH}      ${EMPTY}
${CURRENT_PLATFORM}    ${EMPTY}

*** Keywords ***
Install Sensor Automatically
    [Documentation]    Complete sensor installation process
    ...                Steps: Detect platform → Find downloads → Extract package → Install
    
    Step 1: Detect System Platform
    Step 2: Locate Downloads Folder
    Step 3: Extract Sensor Package
    Step 4: Find Installer
    Step 5: Proceed With Installation
    Display Installation Summary

Step 1: Detect System Platform
    [Documentation]    Automatically identifies if we are on Windows, macOS or Linux
    ${platform}=    Detect Current Platform
    Set Suite Variable    ${CURRENT_PLATFORM}    ${platform}

Step 2: Locate Downloads Folder
    [Documentation]    Automatically finds the user's Downloads folder
    ${downloads}=    Find Downloads Folder
    Set Suite Variable    ${DOWNLOADS_FOLDER}    ${downloads}
    
    ${files}=    List Files In Folder    ${downloads}

Step 3: Extract Sensor Package
    [Documentation]    Searches for and automatically extracts the sensor ZIP file
    
    Verify Folder Exists    ${DOWNLOADS_FOLDER}
    ${extracted}=    Extract Sensor Package From Folder    ${DOWNLOADS_FOLDER}
    Set Suite Variable    ${EXTRACTED_FOLDER}    ${extracted}
    

Step 4: Find Installer
    [Documentation]    Locates the installation executable in the extracted package
    
    ${installer}=    Locate Sensor Installer    ${EXTRACTED_FOLDER}
    Set Suite Variable    ${INSTALLER_PATH}    ${installer}
    

Step 5: Proceed With Installation
    [Documentation]    Launches silent installation of the sensor
    
    Install Sensor Silently    ${INSTALLER_PATH}
    

Display Installation Summary
    [Documentation]    Shows a summary of the steps performed
    Log To Console    ${SPACE}
    Log To Console    📊 === INSTALLATION SUMMARY ===
    Log To Console    🖥️  Platform: ${CURRENT_PLATFORM}
    Log To Console    📁 Source folder: ${DOWNLOADS_FOLDER}
    Log To Console    📦 Extracted package: ${EXTRACTED_FOLDER}
    Log To Console    ⚙️  Installer used: ${INSTALLER_PATH}
    Log To Console    ✅ Status: Installation successful
    Log To Console    ===================================

Verify Folder Exists
    [Arguments]    ${folder_path}
    [Documentation]    Verifies that a folder exists before continuing
    ${exists}=    Verify Folder Exists    ${folder_path}
    Should Be True    ${exists}    Folder ${folder_path} does not exist
   