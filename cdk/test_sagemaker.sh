#!/usr/bin/env zsh

set -eux

project_path=${0:h:h}
versioned_uri="${COLLEGIUM_ECR}:${CODEBUILD_RESOLVED_SOURCE_VERSION}"

# Import the temporary credentials
source $project_path/cdk/assume.sh

docker run \
    -e AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY \
    -e AWS_SESSION_TOKEN \
    -e AWS_REGION \
    --rm "$versioned_uri" \
    python -m cdk.cli sagemaker-jupyter-process --image-version "${CODEBUILD_RESOLVED_SOURCE_VERSION}"