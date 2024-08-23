*** Settings ***
Documentation     Download executable from AWS S3 bucket

*** Variables ***
${bucket}         s3://bucket-name/executable.exe
${executable}     executable.exe
${path}           C:\\Users\\user\\Downloads\\

*** Test Cases ***
Download Executable
  [Documentation]    download executable from aws bucket
  Download Executable from AWS    

*** Keywords ***
Download Executable from AWS
  ${s3} = Create S3 Client
  Download Executable  ${bucket}  ${executable}  ${path}


Create S3 Client
  ${s3} =  Evaluate boto3.client('s3', aws_access_key_id='${AWS_ACCESS_KEY_ID}', aws_secret_access_key='${AWS_SECRET_ACCESS_KEY}')
  [Return]  ${s3}


Download Executable
  [Arguments]   ${bucket}  ${executable}   ${path}
  ${s3} =  Create S3 Client
  ${s3}.download_file(${bucket}, ${executable}, ${path})