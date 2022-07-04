#!/bin/sh

set -ue

aws_access_key_id="${INPUT_AWS_ACCESS_KEY_ID}"
[ -z $aws_access_key_id ] && EXPORT AWS_ACCESS_KEY_ID="$aws_access_key_id"

aws_secret_access_key="${INPUT_AWS_SECRET_ACCESS_KEY}"
[ -z $aws_secret_access_key ] && EXPORT AWS_SECRET_ACCESS_KEY="$aws_secret_access_key"

aws_region="${INPUT_AWS_REGION}"
repository_name="${INPUT_REPOSITORY_NAME}"

repository=$(aws codecommit get-repository --repository-name ${repository_name} --region ${aws_region})

if [ -z $repository ]
then
  repository=$(aws codecommit create-repository --repository-name ${repository_name} --region ${aws_region})
fi

CodeCommitUrl=$(echo $repository | jq .repositoryMetadata.cloneUrlHttp)

git config --global --add safe.directory /github/workspace
git config --global credential.'https://git-codecommit.*.amazonaws.com'.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
git remote add sync ${CodeCommitUrl}
git push sync --mirror
