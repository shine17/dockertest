#!/bin/bash

set -ex 

scriptdirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
projectdirectory="$scriptdirectory/.."

echo  "project directory is - "$projectdirectory 

ls -l

# Remove the contents of publish folder
rm -r -f publish

rm -r -f $projectdirectory/bin

# Clean web application project referred in the csproj file
# dotnet clean $projectdirectory/Dockertest.csproj

dotnet build $projectdirectory/Dockertest.csproj

# Publish the web application project to publish directory for release
dotnet publish $projectdirectory/Dockertest.csproj  --force  --configuration Release --verbosity normal --output publish/