#!/bin/sh
set -e
echo "=== starting jackett Initialization ==="
APP_DIR="/app"
CONFIG_DIR="/config"
mkdir -p "$APP_DIR" "$CONFIG_DIR"
if [ "$JACKETT_VERSION" = "latest" ]|| [ -z "$JACKETT_VERSION" ]; then
    echo "[+] Checking  latest release from GitHub API ..."

    TARGET_VERSION=$(curl -sL https://api.github.com/repos/Jackett/Jackett/releases/latest | jq -r .tag_name)
else
    TARGET_VERSION="$JACKETT_VERSION"
fi
echo "[+] Target Version is: $TARGET_VERSION"
CURRENT_VERSION="none"
if [ -f "$APP_DIR/version.txt" ]; then
    CURRENT_VERSION=$(cat "$APP_DIR/version.txt")
fi
echo "[+] Current installed Version: $CURRENT_VERSION"
if [ "$CURRENT_VERSION" != "$TARGET_VERSION" ]; then
    echo "[+] Upgrading Jackett to $TARGET_VERSION..."
    DOWNLOAD_URL="https://github.com/Jackett/Jackett/releases/download/${TARGET_VERSION}/Jackett.Binaries.LinuxMuslAMDx64.tar.gz"
    echo "[+] downloading from: $DOWNLOAD_URL"
    curl -sL "$DOWNLOAD_URL" | tar -xz -C "$APP_DIR" --strip-components=1
    echo "$TARGET_VERSION" > "$APP_DIR/version.txt"
    echo " Jackett Successfully Updated to: $TARGET_VERSION"
else
    echo "Jackett is already up to date."
fi
echo " Launching Jackett Server."
exec "$APP_DIR/jackett" --NoRestart --DataFolder "$CONFIG_DIR"