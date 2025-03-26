#!/usr/bin/env bash
echo "=== CLEANING PODS ==="
rm -rf Pods/ Podfile.lock VKMusicApp.xcworkspace
rm -rf ~/Library/Caches/CocoaPods

echo "=== POD INSTALL ==="
pod install --repo-update --verbose
#!/usr/bin/env bash
echo "=== Running Pre-build Script ==="
rm -rf Pods/
pod install --repo-update
chmod +x appcenter-pre-build.sh

