#!/usr/bin/env bash

set -e
FILENAME=$1

if [ -z $FILENAME ]; then
  echo 'The path to the file is required'
  exit 1
fi

while IFS='=' read -r key value; do
  keyReplace=$(printf '__%s__\n' "$key" | sed -e 's/[]\/$*.^[]/\\&/g')
  valueReplace=$(printf '%s\n' "$value" | sed -e 's/[\/&]/\\&/g')
  echo "Setting $key"
  echo $value | wc -l
  sed -i "s/${keyReplace}/${valueReplace}/g" $FILENAME
done < <(printenv)
