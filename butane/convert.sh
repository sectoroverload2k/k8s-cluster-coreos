#!/bin/bash

if [ ! "$2" ]; then
	echo "Usage: ./convert.sh <butanefile> <ignitionfile>"
	exit 1
fi

BUTANE_FILE=$1
IGNITION_FILE=$2
PODMAN=/usr/bin/podman

$PODMAN run --interactive --rm quay.io/coreos/butane:release --pretty --strict < "$BUTANE_FILE" > "$IGNITION_FILE"
