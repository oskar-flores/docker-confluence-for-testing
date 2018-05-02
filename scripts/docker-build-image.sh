#!/usr/bin/env bash

help() {
    echo
    echo "Usage: docker-build-image.sh <jdk_download_url>"
    echo
    echo "Builds the confluence-4-testing image"
    echo
    echo "The following options are available:"
    echo "<jdk_download_url>  (Mandatory)Provide the url to download the JDK to be used"
    echo
    exit
}

while [ $# -gt 0 ]
do
    case "$1" in
        "-?" | "-h" | "--help" | "-help" | "help")
            help;;
        *)
            JDK_URL="$1"
            shift 1;;
    esac
done

if [[ -z "$JDK_URL" ]]
then
    help
fi

# Set current folder to parent
cd "$(dirname "$0")"/..

COMMAND="docker build -t confluence-4-testing --build-arg JDK_URL=$JDK_URL ."
echo $COMMAND
eval $COMMAND