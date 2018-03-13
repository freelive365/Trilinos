#!/bin/bash -e

# NOTE: This script should only be run by checkin-test-atdm.sh.  It does not
# have enough info to run on its own.

ATDM_JOB_NAME_KEYS=$1 ; shift

source $STD_ATDM_DIR/load-env.sh $ATDM_JOB_NAME_KEYS

echo "-GNinja
-DTrilinos_CONFIGURE_OPTIONS_FILE:STRING=cmake/std/atdm/ATDMDevEnv.cmake
" > $ATDM_JOB_NAME_KEYS.config

echo
echo "Running: checkin-test.py --st-extra-builds=$ATDM_JOB_NAME_KEYS ..."
echo
echo "  ==> See output file checkin-test.$ATDM_JOB_NAME_KEYS.out"
echo

set -x

$ATDM_TRILINOS_DIR/cmake/tribits/ci_support/checkin-test.py \
  --make-options="-j $ATDM_CONFIG_BUILD_COUNT" \
  --ctest-options="-j $ATDM_CONFIG_CTEST_PARALLEL_LEVEL" \
  --st-extra-builds=$ATDM_JOB_NAME_KEYS "$@" \
  &> checkin-test.$ATDM_JOB_NAME_KEYS.out

set +x

echo "source $STD_ATDM_DIR/load-env.sh $ATDM_JOB_NAME_KEYS" > $ATDM_JOB_NAME_KEYS/load-env.sh

# ToDo: Read env var ATDM_CONFIG_USE_NINJA and set --use-ninja!
