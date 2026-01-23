# Find the first dark theme
THEME=$(ls /usr/share/themes | grep -i "dark" | head -n 1)

# Check if THEME is not empty
if [ -n "$THEME" ]; then
    export GTK_THEME="$THEME"
fi

