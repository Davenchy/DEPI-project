#!/bin/sh

# Get the GID of the docker group on the host from the mounted socket
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)

# Create the docker group with the same GID as the host, if it doesn't exist
if ! getent group docker > /dev/null 2>&1; then
    addgroup -g $DOCKER_GID docker
fi

# Add the Jenkins user to the docker group
addgroup jenkins docker

su jenkins

# Continue with the Jenkins entrypoint script
exec /usr/local/bin/jenkins.sh "$@"
