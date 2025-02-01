#!/usr/bin/env bash

source ./scripts/functions.sh

check-env
source-distro "$DOTBOT_TARGET"
prebuild
