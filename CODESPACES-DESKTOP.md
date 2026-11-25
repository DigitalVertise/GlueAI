# Linux desktop in GitHub Codespaces

This repository includes an optional lightweight XFCE desktop streamed through noVNC.

## Start

1. Open this repository in GitHub Codespaces.
2. Choose the `.devcontainer` configuration when prompted.
3. Wait for the container image to build.
4. Codespaces will start XFCE, Xvfb, x11vnc and noVNC.
5. Open forwarded port **6080**. Keep its visibility set to **Private**.
6. In the noVNC page, select **Connect**.

The desktop is 1600x900. Firefox ESR and XFCE Terminal are installed.

## Security

- Port 6080 is configured as **private**. It must remain private.
- The VNC server binds to localhost and has no VNC password because it is reachable only through the authenticated private Codespaces port forward.
- Never change the forwarded port to Public or expose port 5900.
- Do not put API keys or passwords in this repository. Use Codespaces Secrets.

## Use with Android TV and iPhone

Open the Codespaces forwarded-port URL in the Android TV box browser or iPhone browser while signed into the GitHub account that owns the Codespace. A Bluetooth keyboard and mouse are strongly recommended. TV browser compatibility varies; if noVNC does not render correctly, use the iPhone browser or another supported browser.

## Add development tools

Install project-specific tools in the Codespace as needed. The environment is ephemeral: commit or push work to GitHub, and do not rely on uncommitted files surviving a rebuild or deletion.

## Limits

Codespaces is a cloud development environment, not an always-on VPS. Availability, compute, storage and usage depend on the account's current plan and included quotas. The desktop stops when the Codespace stops.
