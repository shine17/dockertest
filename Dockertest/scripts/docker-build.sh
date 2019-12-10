#!/bin/bash

set -ex


project_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $project_dir
docker_dir="$project_dir/../../."

echo  $docker_dir 

docker build -f $docker_dir/Dockerfile -t "dockertest:latest" $docker_dir
