#/usr/bin/env bash

# Change to script's directory to ensure we're in the correct folder.
# http://stackoverflow.com/questions/3349105/how-to-set-current-working-directory-to-the-directory-of-the-script
CURRENT_DIR="${0%/*}"
cd ${CURRENT_DIR} || exit 1
FULL_DIR="$(readlink -f ${CURRENT_DIR})"

for FILENAME in .??*; do
  if [ "${FILENAME}" != ".git" ]; then
    ln -s "${FULL_DIR}/${FILENAME}" ~/${FILENAME}
  fi
done
