*** Settings ***
Library   /Users/dboujnane/robotframework/custom-libraries/SensorSetup.py
Suite Setup    Setup Suite
Suite Teardown    Teardown Suite

*** Variables ***
${OUTPUT_FOLDER}    


*** Test Cases ***
Verify sensor installation on ${PLATFORM}
    [Documentation]    Test the installation of the sensor
    Log    "Sensor installation test"  

*** Keywords ***
Setup Suite
    [Documentation]    Suite setup to unzip files and prepare the environment

    ${PLATFORM}=    Evaluate    platform.system()
    set Suite Variable    ${PLATFORM}   ${PLATFORM}

    ${DOWNLOADS_FOLDER}=    Get Downloads Directory
    ${OUTPUT_FOLDER}=    Unzip File In Directory    ${DOWNLOADS_FOLDER}
    ${INSTALLER_PATH}=    Get Installer Path    ${OUTPUT_FOLDER}
    Log    Executing installer at: ${INSTALLER_PATH}
    
    Run Keyword If    '${PLATFORM}' == 'Darwin'    Execute Macos Installer    ${INSTALLER_PATH}
    ...    ELSE IF    '${PLATFORM}' == 'Windows'    Execute Windows Installer    ${INSTALLER_PATH}

Teardown Suite
    [Documentation]    Suite teardown to clean up the environment delete zip files from downloads folder
    Log    "Cleaning up the environment"
 

*** Variables ***
${PLATFORM}    ${None}