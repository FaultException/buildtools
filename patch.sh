#!/bin/bash
#
# Build tools to automatically apply patches to my
# CM9 folder on the epic build server.
#
# Based on EpicCM/epictools
#

set -e

repo abandon auto

# Patches

# Example:
#
# echo "### <review title>"
# repo start auto device/samsung/aries-common
# cd device/samsung/aries-common
# <cherry-pick-line>
# cd ../../..
