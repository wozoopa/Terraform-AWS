#!/bin/bash

TOKEN=$1

read -p 'Provide token: ' TOKEN

CREDS=(`aws sts get-session-token --serial-number arn:aws:iam::<ACCOUNT-ID>:mfa/Adminek --token-code $TOKEN --profile cetf --output text`)

echo -e "Run below command: \n"
echo -e "export AWS_ACCESS_KEY_ID=\"${CREDS[1]}\" ; export AWS_SECRET_ACCESS_KEY=\"${CREDS[3]}\" ; export AWS_SESSION_TOKEN=\"${CREDS[4]}\""
