*** Settings ***
Documentation    Automatic sensor installation with natural language steps
Library          ../custom/SensorInstallationLibrary.py

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
    Log To Console    🔍 Detecting system platform...
    ${platform}=    Detect Current Platform
    Log To Console    ✅ Platform detected: ${platform}
    Set Suite Variable    ${CURRENT_PLATFORM}    ${platform}

Step 2: Locate Downloads Folder
    [Documentation]    Automatically finds the user's Downloads folder
    Log To Console    📁 Searching for downloads folder...
    ${downloads}=    Find Downloads Folder
    Set Suite Variable    ${DOWNLOADS_FOLDER}    ${downloads}
    
    Log To Console    📋 Checking folder contents...
    ${files}=    List Files In Folder    ${downloads}
    Log To Console    ✅ Downloads folder located: ${downloads}

Step 3: Extract Sensor Package
    [Documentation]    Searches for and automatically extracts the sensor ZIP file
    Log To Console    📦 Extracting sensor package...
    
    Verify Folder Exists    ${DOWNLOADS_FOLDER}
    ${extracted}=    Extract Sensor Package From Folder    ${DOWNLOADS_FOLDER}
    Set Suite Variable    ${EXTRACTED_FOLDER}    ${extracted}
    
    Log To Console    ✅ Package successfully extracted to: ${extracted}

Step 4: Find Installer
    [Documentation]    Locates the installation executable in the extracted package
    Log To Console    🔎 Searching for installer...
    
    ${installer}=    Locate Sensor Installer    ${EXTRACTED_FOLDER}
    Set Suite Variable    ${INSTALLER_PATH}    ${installer}
    
    Log To Console    ✅ Installer found: ${installer}

Step 5: Proceed With Installation
    [Documentation]    Launches silent installation of the sensor
    Log To Console    ⚙️  Starting silent installation...
    
    Install Sensor Silently    ${INSTALLER_PATH}
    
    Log To Console    ✅ Installation completed successfully!

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

Diagnose Installation Issues
    [Documentation]    Diagnostic keyword for troubleshooting problems
    Log To Console    🔧 === INSTALLATION DIAGNOSTICS ===
    
    Log To Console    1. Checking downloads folder...
    Run Keyword If    '${DOWNLOADS_FOLDER}' != '${EMPTY}'
    ...    List Files In Folder    ${DOWNLOADS_FOLDER}
    ...    ELSE    Log To Console    ❌ Downloads folder not defined
    
    Log To Console    2. Checking extracted package...
    Run Keyword If    '${EXTRACTED_FOLDER}' != '${EMPTY}'
    ...    List Files In Folder    ${EXTRACTED_FOLDER}
    ...    ELSE    Log To Console    ❌ Package not extracted
    
    Log To Console    3. Checking installer...
    Run Keyword If    '${INSTALLER_PATH}' != '${EMPTY}'
    ...    Log To Console    ✅ Installer: ${INSTALLER_PATH}
    ...    ELSE    Log To Console    ❌ Installer not found