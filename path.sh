unset PATH

# Default
PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Directories to be prepended to $PATH
declare -a customPath
customPath=(
  "/usr/local"
  "$HOME/.local/bin"
  "$HOME/.yarn/bin"
  "/usr/local/sbin"
  "/usr/local/bin"
)

for dir in ${customPath[@]}
do
  if [ -d ${dir} ]; then
    PATH="${dir}:$PATH"
  fi
done

unset customPath