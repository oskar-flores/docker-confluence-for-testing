#!/usr/bin/env bash
ATLAS_SDK_VERSION="6.3.10"
CONFLUENCE_VERSION=$(curl -s https://marketplace.atlassian.com/rest/2/addons/atlassian-plugin-sdk-tgz/versions/name/$ATLAS_SDK_VERSION | jq '.vendorLinks.binary')
echo $CONFLUENCE_VERSION