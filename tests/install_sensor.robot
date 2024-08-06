*** Settings ***
Library    C:/Users/Administrator/robotframework/custom-libraries/SensorSetup.py
Suite Setup    Setup Suite
Suite Teardown    Teardown Suite

*** Test Cases ***
Verify sensor installation on ${PLATFORM}
    [Documentation]    Test the installation of the sensor
    Log    "Sensor installation test"  

*** Keywords ***
Setup Suite
    [Documentation]    Suite setup to unzip files and prepare the environment

    ${PLATFORM}=    Evaluate    platform.system()
    set Suite Variable    ${PLATFORM}   ${PLATFORM}

    ${DOWNLOADS_FOLDER}=    Get Downloads Folder 
    ${OUTPUT_DIR}=      Unzip File In Folder    ${DOWNLOADS_FOLDER}
    
    Run Keyword If    '${PLATFORM}' == 'Darwin'    Execute Macos Installer    ${OUTPUT_DIR}
    ...    ELSE IF    '${PLATFORM}' == 'Windows'    Execute Windows Installer    ${OUTPUT_DIR}

Teardown Suite
    [Documentation]    Suite teardown to clean up the environment delete zip files from downloads folder
    Log    "Cleaning up the environment"

*** Variables ***
${PLATFORM}