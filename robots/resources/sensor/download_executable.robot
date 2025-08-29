*** Settings ***
Documentation     Download executable from AWS S3 bucket
Library           Collections

*** Variables ***
${BUCKET_NAME}         bucket-name
${EXECUTABLE_NAME}     executable.exe
${AWS_ACCESS_KEY_ID}   ${EMPTY}
${AWS_SECRET_ACCESS_KEY}   ${EMPTY}

*** Keywords ***
Download Executable from AWS
    [Documentation]    Downloads executable from AWS S3 bucket
    ${downloads_path}=    Get Downloads Path
    ${s3_client}=    Create S3 Client
    Download File From S3    ${s3_client}    ${BUCKET_NAME}    ${EXECUTABLE_NAME}    ${downloads_path}

Create S3 Client
    [Documentation]    Creates and returns an S3 client
    ${s3_client}=    Evaluate
    ...    boto3.client('s3', aws_access_key_id='${AWS_ACCESS_KEY_ID}', aws_secret_access_key='${AWS_SECRET_ACCESS_KEY}')
    ...    modules=boto3
    [Return]    ${s3_client}

Download File From S3
    [Documentation]    Downloads a file from S3 bucket to local path
    [Arguments]    ${s3_client}    ${bucket_name}    ${file_name}    ${local_path}
    ${full_path}=    Set Variable    ${local_path}${/}${file_name}
    Evaluate    $s3_client.download_file('${bucket_name}', '${file_name}', '${full_path}')
    Log    Downloaded ${file_name} to ${full_path}

Get Downloads Path
    [Documentation]    Gets the appropriate downloads path for the current OS
    ${home}=    Evaluate    os.path.expanduser("~")    modules=os
    ${downloads_path}=    Set Variable    ${home}${/}Downloads
    [Return]    ${downloads_path}