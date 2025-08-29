*** Settings ***
Documentation    Main sensor installation tasks
...              This file contains the main tasks executable by Robot Framework
Library          custom/SensorInstallationLibrary.py
Resource         sensor/install_sensor_improved.robot

*** Tasks ***
Complete Sensor Installation
    [Documentation]    Main task to automatically install a sensor
    [Tags]             installation    sensor    automatic
    
    Install Sensor Automatically

System Diagnostics
    [Documentation]    Diagnostic task to check system status
    [Tags]             diagnostic    debug
    
    Diagnose Installation Issues

Environment Verification
    [Documentation]    Verifies that the environment is ready for installation
    [Tags]             verification    environment
    
    Step 1: Detect System Platform
    Step 2: Locate Downloads Folder