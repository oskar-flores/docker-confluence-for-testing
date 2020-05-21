#!/bin/bash

EVENT=$1

if [ "$EVENT" = "finish_setup" ]; then
    # url="http://admin:admin@confluence:8090/confluence/rest/plugins/1.0/"
    # token=$(curl -sI "$url?os_authType=basic" | grep upm-token | cut -d ":" -f 2 | tr -d '[:space:]')
    # pluginurl="${url}?token=${token}"
    # echo $pluginurl
    # curl -XPOST $pluginurl -F plugin=@"${APP_PATH}"
    echo "ALl good!!"
fi

  