#!/bin/bash

echo "Running 'rm' tests."
echo

echo -n "Test 1: rm 1 file .................... "
touch test1
./rm test1
if [[ $? -ne 0 && -f test1 ]]; then
  echo "failed."
  exit 1
fi
echo "passed."

echo -n "Test 2: force rm existing file ....... "
touch test1
./rm --force test1
if [[ $? -ne 0 && -f test1 ]]; then
  echo "failed."
  exit 1
fi
echo "passed."

echo -n "Test 3: force rm non-existent file ... "
./rm --force test1
if [[ $? -ne 0 ]]; then
  echo "failed."
  exit 1
fi
echo "passed."

echo -n "Test 4: rm multiple files ............ "
touch test1 test2
./rm test1 test2
if [[ $? -ne 0 ]]; then
  echo "failed: exit non-zero."
  exit 1
fi
if [[ -f test1 || -f test2 ]]; then
  echo "failed."
  exit 1
fi
echo "passed."

echo -n "Test 5: rm flag out-of-order ......... "
touch test1 test2
./rm test1 --force test2
if [[ $? -ne 0 ]]; then
  echo "failed: exit non-zero."
  exit 1
fi
if [[ -f test2 ]]; then
  echo "failed."
  exit 1
fi
echo "passed."

echo
echo "All rm tests passed."

exit 0
