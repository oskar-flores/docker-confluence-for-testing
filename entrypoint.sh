#!/usr/bin/env bash

eval "atlas-run-standalone --product confluence -v $CONFLUENCE_VERSION -c tomcat8x --server localhost -DskipAllPrompts=true"