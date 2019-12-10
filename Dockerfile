# Build the dotnet binary using latest dotnet sdk image , this is an ubuntu image
FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic  AS build-env
LABEL MAINTAINER="shsivada@starbucks.com"

USER root 

# set the working directory as sourcecode to copy the project files
WORKDIR /sourcecode

#Copy all the source code to the /sourcecode folder in the container

COPY . /sourcecode/

RUN ls -al

# Run the dotnet publish shell scripts to get the dotnet binary
RUN ./Dockertest/scripts/dotnet-publish.sh

# Second stage of the docker file to build the docker image having dotnet core  runtime and the dotnet app binary

#Use the dotnet core runtime images
FROM  mcr.microsoft.com/dotnet/core/runtime:3.1-bionic
LABEL MAINTAINER="shsivada@starbucks.com"

WORKDIR /app

# copy the published dotnet core binaries from previous build container to /app folder in the runtime container
COPY --from=build-env /sourcecode/publish ./

# Just verify if the necessary dotnet dlls are copied
RUN ls -l

#Expose port 5000 of linux container
#EXPOSE 5000

# Start the container using ENTRYPOINT exec form so that the dotnet webserver will be having process identification number 1 (PID)
# This allows the dotnet webserver to take the SIGTERM or SIGINT linux signals and do a graceful shutdown while control plane reschedule the pod to different node
ENTRYPOINT ["dotnet" ,"Dockertest.dll"]

