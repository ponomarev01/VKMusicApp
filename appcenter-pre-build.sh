#!/usr/bin/env bash
echo "=== Running Pre-build Script ==="
rm -rf Pods/
pod install --repo-update
chmod +x appcenter-pre-build.sh
