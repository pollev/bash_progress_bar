#!/bin/bash


# This code was inspired by the open source C code of the APT progress bar
# http://bazaar.launchpad.net/~ubuntu-branches/ubuntu/trusty/apt/trusty/view/head:/apt-pkg/install-progress.cc#L233

CODE_SAVE_CURSOR="\033[s"
CODE_RESTORE_CURSOR="\033[u"
CODE_CURSOR_IN_SCROLL_AREA="\033[1A"
COLOR_FG="\e[30m"
COLOR_BG="\e[42m"
RESTORE_FG="\e[39m"
RESTORE_BG="\e[49m"

function setup_scroll_area() {
    lines=$(tput lines)
    let lines=$lines-1
    # Scroll down a bit to avoid visual glitch when the screen area shrinks by one row
    echo -en "\n"

    # Save cursor
    echo -en "$CODE_SAVE_CURSOR"
    # Set scroll region (this will place the cursor in the top left)
    echo -en "\033[0;${lines}r"

    # Restore cursor but ensure its inside the scrolling area
    echo -en "$CODE_RESTORE_CURSOR"
    echo -en "$CODE_CURSOR_IN_SCROLL_AREA"

    # Start empty progress bar
    draw_progress_bar 0
}

function destroy_scroll_area() {
    lines=$(tput lines)
    # Save cursor
    echo -en "$CODE_SAVE_CURSOR"
    # Set scroll region (this will place the cursor in the top left)
    echo -en "\033[0;${lines}r"

    # Restore cursor but ensure its inside the scrolling area
    echo -en "$CODE_RESTORE_CURSOR"
    echo -en "$CODE_CURSOR_IN_SCROLL_AREA"

    # We are done so clear the scroll bar
    clear_progress_bar

    # Scroll down a bit to avoid visual glitch when the screen area grows by one row
    echo -en "\n\n"
}

function draw_progress_bar() {
    percentage=$1
    lines=$(tput lines)
    let lines=$lines
    # Save cursor
    echo -en "$CODE_SAVE_CURSOR"

    # Move cursor position to last row
    echo -en "\033[${lines};0f"
	
	# Clear progress bar
    tput el

    # Draw progress bar
    print_bar_text $percentage

    # Restore cursor position
    echo -en "$CODE_RESTORE_CURSOR"
}

function clear_progress_bar() {
    lines=$(tput lines)
    let lines=$lines
    # Save cursor
    echo -en "$CODE_SAVE_CURSOR"

    # Move cursor position to last row
    echo -en "\033[${lines};0f"

    # clear progress bar
    tput el

    # Restore cursor position
    echo -en "$CODE_RESTORE_CURSOR"
}

function print_bar_text() {
    local percentage=$1

    # Prepare progress bar
    let remainder=100-$percentage
    progress_bar=$(echo -ne "["; echo -en "${COLOR_FG}${COLOR_BG}"; printf_new "#" $percentage; echo -en "${RESTORE_FG}${RESTORE_BG}"; printf_new "." $remainder; echo -ne "]");

    # Print progress bar
    if [ $1 -gt 99 ]
    then
        echo -ne "${progress_bar}"
    else
        echo -ne "${progress_bar}"
    fi
}

printf_new() {
    str=$1
    num=$2
    v=$(printf "%-${num}s" "$str")
    echo -ne "${v// /$str}"
}

setup_scroll_area
echo "this is a test"
sleep 1

echo "this is a test"
sleep 1

echo "this is a test"
sleep 1

draw_progress_bar 10
sleep 1
echo "this is a test"
sleep 1

echo "this is a test"
sleep 1

draw_progress_bar 90
sleep 1

echo "this is a test"
sleep 1

destroy_scroll_area
