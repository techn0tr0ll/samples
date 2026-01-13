#/bin/sh
# Forked from https://raw.githubusercontent.com/dktr0/estuary/dev/generateAudioResources.sh to support Strudel

printf "{\n"
printf "  \"_base\":\"https://raw.githubusercontent.com/username/repository/master/\",\n"
dircount=0
find $1 -mindepth 1 -maxdepth 1 -iname "*" | sort | while read d; do
  if [ -d "$d" ]
  then
    dirname=`basename "$d"`
    if [[ ($dircount -ne 0) ]]; then
      printf ",\n"
    fi
    printf "  \"%s\":[\n" "$dirname"
    find "$d" -iname "*.wav" -mindepth 1 -maxdepth 1 | sort | while read f; do
      filename=$(printf %q "$f")
      basename=${f##*/}
      if [[ ($filecount -ne 0) ]]; then
        printf ",\n"
      fi
      if [[ ${basename:0:1} != "." ]]; then
        printf "    \"%s/%s\"" "$dirname" "$basename"
        (( filecount++ ))
      fi
    done
    (( dircount++ ))
    printf "\n  ]"
  fi
done
printf "\n}\n"
