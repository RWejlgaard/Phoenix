#!/bin/bash
set -e
ORIGINAL_DIR=`pwd`

for d in ./functions/* ; do
   cd $ORIGINAL_DIR/$d
   rm -rf $ORIGINAL_DIR/$d/venv
   python3 -m venv $ORIGINAL_DIR/$d/venv
   . $ORIGINAL_DIR/$d/venv/bin/activate
   pip install -r $ORIGINAL_DIR/$d/requirements.txt
   zip -r $ORIGINAL_DIR/terraform/files/${PWD##*/}.zip *.py venv
done