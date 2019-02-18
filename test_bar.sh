#!/bin/bash

# Source progress bar
source ./progress_bar.sh

generate_some_output_and_sleep() {
    echo "Here is some output"
    head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-'
    head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-'
    head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-'
    head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-'
    echo -e "\n\n------------------------------------------------------------------"
    echo -e "\n\n Now sleeping briefly \n\n"
    sleep 0.3
}


main() {
    # Make sure that the progress bar is cleaned up when user presses ctrl+c
    enable_trapping
    # Create progress bar
    setup_scroll_area
    for i in {1..99}
    do
        if [ $i = 50 ]; then
            echo "waiting for user input"
            block_progress_bar $i
            read -p "User input: "
        else
            generate_some_output_and_sleep
            draw_progress_bar $i
        fi
    done
    destroy_scroll_area
}

main
