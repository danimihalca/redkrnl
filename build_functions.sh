#!/bin/bash

build_image() {
    local image_tag="$1"

    # Build image only if image don`t exists
    if [ -z "$(sudo docker images -q $image_tag)" ]; then
        sudo docker build . -t "$image_tag"
    fi
}

run_command_in_container() { # create container based on redkrnl-biloba-build image and run command from $1
    local command="$1"

    sudo docker run --rm -ti -v "${PWD}:/builddir" \
           -w /builddir \
           redkrnl-biloba-build bash -c "$command"
}
