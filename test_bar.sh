#!/bin/bash

# Source progress bar
source ./progress_bar.sh

function generate_some_output_and_sleep() {
    echo "Here is some output"
    ls -la /tmp
    head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-'
    echo -e "\n\n------------------------------------------------------------------"
    echo -e "\n\n Now sleeping one second \n\n"
    sleep 1
}


function main() {
    # Make sure that the progress bar is cleaned up when user presses ctrl+c
    enable_trapping
    # Create progress bar
    setup_scroll_area
    for i in {1..99}
    do
        generate_some_output_and_sleep
        draw_progress_bar $i
    done
    destroy_scroll_area
}

main
