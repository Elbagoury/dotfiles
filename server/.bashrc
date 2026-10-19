# ~/.bashrc: load ble.sh for interactive shells only
if [[ $- == *i* ]]; then
    source ~/.local/share/blesh/ble.sh
fi
