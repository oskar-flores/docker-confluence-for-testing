#!/usr/bin/env bash

help() {
    echo
    echo "Usage: docker-run-container.sh [x.y.z]"
    echo
    echo "Runs the confluence-4-testing container with the provided Confluence version."
    echo
    echo "The following options are available:"
    echo "x.y.z (Optional) Confluence version. If empty latest release version will be used"
    echo
    exit
}

while [ $# -gt 0 ]
do
    case "$1" in
        [0123456789]*)
            CONFLUENCE_VERSION=$1
            shift 1;;
        "-?" | "-h" | "--help" | "-help" | "help")
            help;;
        *)
            shift 1
    esac
done

# Set current folder to parent
cd "$(dirname "$0")"/..

if [[ -z "$CONFLUENCE_VERSION" ]]
then
    # Get latest available version
    CONFLUENCE_VERSION=$(curl -s https://marketplace.atlassian.com/rest/2/applications/confluence/versions/latest | jq '.version') 
fi

COMMAND="docker-compose run --rm --service-ports -e CONFLUENCE_VERSION=$CONFLUENCE_VERSION confluence"
echo $COMMAND
eval $COMMAND