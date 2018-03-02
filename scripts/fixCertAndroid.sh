#!/bin/sh
echo "Mount Android Phone"
ca=~/.mitmproxy/mitmproxy-ca-cert.pem
hash=$(openssl x509 -noout -subject_hash_old -in $ca)
sudo ~/Android/Sdk/platform-tools/adb root
sudo ~/Android/Sdk/platform-tools/adb shell cp -a /etc/security/cacerts /data/
sudo ~/Android/Sdk/platform-tools/adb push $ca /data/cacerts/$hash.0
sudo ~/Android/Sdk/platform-tools/adb shell chmod 644 /data/cacerts/$hash.0
sudo ~/Android/Sdk/platform-tools/adb shell mount --bind /data/cacerts /etc/security/cacerts
sudo ~/Android/Sdk/platform-tools/adb unroot  # optional: restart adbd as normal user
