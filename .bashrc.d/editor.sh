# The .selected_editor file is created by running select-editor in Ubuntu
if [ -f ~/.selected_editor ]; then
  source ~/.selected_editor
  export EDITOR=$SELECTED_EDITOR
fi
