#!/bin/env bash

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
    auto_setup_progress_bar
    for i in {1..99}
    do
        if [ $i = 50 ]; then
            echo "waiting for user input"
            auto_block_progress_bar
            read -p "User input: "
        else
            generate_some_output_and_sleep
        fi
    done
    auto_end_progress_bar
}

main
