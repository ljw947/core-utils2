#!/bin/bash

# Test Runner

echo "Running all tests."
echo

if [ -n "$1" ]; then
  if [ $1 == "debug" ]; then
     set -ex
     make debug
  fi
else
  make all 1> /dev/null
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

pushd build 1> /dev/null

# Test calls go here
echo "------------------------------------------------------------------------"
${SCRIPT_DIR}/test-rm.sh
echo "------------------------------------------------------------------------"

popd 1> /dev/null

rm -rf build

echo
echo "All tests passed."
