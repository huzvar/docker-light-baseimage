#!/bin/sh -e
# This file is used only during the image build and deleted at the end.

## Add tools to /sbin
ln -s /container/tools/* /sbin/

# Create image default directories.
mkdir -p /container/environment \
         /container/services \
         /container/entrypoint /container/entrypoint/startup /container/entrypoint/process /container/entrypoint/finish

# Install required packages.
echo "@edgecommunity https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

apk add -q --no-cache bash

packages-index-update
packages-install-clean ca-certificates python3 py3-dotenv gettext jq libeatmydata@edgecommunity

# Clean.
rm -rf /tmp/* /var/tmp/* /container/build /container/Dockerfile
