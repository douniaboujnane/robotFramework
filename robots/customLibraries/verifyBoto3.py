import boto3
from botocore.config import Config
import json


s3=boto3.client('s3', config=Config(signature_version='s3v4'))

# List all S3 buckets
response = s3.list_buckets()
print('Existing buckets:', response['Buckets'][0])

