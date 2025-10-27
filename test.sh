#!/bin/bash

set -ex

make all

pushd build

touch test1
./rm test1
if [[ $? -ne 0 && -f test1 ]]; then
  echo "rm 1 file failed"
  exit 1
fi

touch test1
./rm --force test1
if [[ $? -ne 0 && -f test1 ]]; then
  echo "force rm existent file failed"
  exit 1
fi

./rm --force test1
if [[ $? -ne 0 ]]; then
  echo "force rm non-existent file failed"
  exit 1
fi

touch test1 test2
./rm test1 test2
if [[ $? -ne 0 ]]; then
  echo "rm multiple files failed: exit non-zero"
  exit 1
fi
if [[ -f test1 || -f test2 ]]; then
  echo "rm multiple files failed"
  exit 1
fi

touch test1 test2
./rm test1 --force test2
if [[ $? -ne 0 ]]; then
  echo "rm flag out of order failed: exit non-zero"
  exit 1
fi
if [[ -f test2 ]]; then
  echo "rm flag out of order failed"
  exit 1
fi

popd

exit 0
