*** Settings ***
Documentation    Main sensor installation tasks
...              This file contains the main tasks executable by Robot Framework
Library          customLibraries/SensorInstallation.py
Resource         resources/sensor/download_executable.robot
Resource         resources/sensor/install_sensor.robot

*** Tasks ***
Environment Verification
    [Documentation]    Verifies that the environment is ready for installation
    [Tags]             verification    environment
    
    Step 1: Detect System Platform
    Step 2: Locate Downloads Folder

Complete Sensor Installation
    [Documentation]    Main task to automatically install a sensor
    [Tags]             installation    sensor
    
    Step 2: Locate Downloads Folder
    # Install Sensor Automatically