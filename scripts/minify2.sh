#!/bin/bash

clear
echo

f_create_dist() {
  if [ ! -d "dist" ]; then
    mkdir dist
  fi
}

f_exclude_paths() {
  excluded_paths=(
    "*dist*"
    "*node_modules*"
    "./.*"
    "*scripts*"
  )

  exclude=()
  for i in "${excluded_paths[@]}"
  do
    exclude+=(-not -path "$i")
  done
}

f_build() {
  while read -d $'\0' file; do
      rel_path=${file#./}
      min_path="dist/$rel_path"

      case "$file" in
          *.html)
          html-minifier "$file" -o "$min_path" --collapse-whitespace --remove-comments
          ;;
          *.css)
          cleancss "$file" -o "$min_path" --compatibility "ie >= 11, Edge >= 12, Firefox >= 2, Chrome >= 4, Safari >= 3.1, Opera >= 15, iOS >= 3.2"
          ;;
          *.js)
          uglifyjs "$file" -o "$min_path" --compress drop_console --mangle --mangle-props
          ;;
          *)
          cp -r "$file" "$min_path"
          ;;
      esac
  done < <(find . -mindepth 1 "${exclude[@]}" -print0)

  echo
  echo Done!
  echo
}

f_create_dist
f_exclude_paths
f_build