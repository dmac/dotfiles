#!/bin/sh

DOTDIR=$(pwd)
echo "Linking files in ${DOTDIR}"
for file in .*
do
  if [ $file != . ] &&
     [ $file != .. ] &&
     [ $file != .git ]; then
    rm -fr ~/$file
    ln -Fs ${DOTDIR}/${file} ~/${file}
    echo ${file}
  fi
done
