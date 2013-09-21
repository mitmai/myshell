
export BOOKMARK_PATH=$HOME/.dirbookmarks
if [ ! -d $BOOKMARK_PATH ]; then
  mkdir $BOOKMARK_PATH
fi
function bj {
  cd -P "$BOOKMARK_PATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function bm {
  mkdir -p "$BOOKMARK_PATH"; ln -s "$(pwd)" "$BOOKMARK_PATH/$1"
}
function brm {
  rm -i "$BOOKMARK_PATH/$1"
}
function bl {
ls -l "$BOOKMARK_PATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $BOOKMARK_PATH -type l -exec basename {} \; )
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks bj ubm

