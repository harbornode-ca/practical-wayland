# WinApps - Windows Apps on Linux Powered by Dockur

## Changing compose.yaml
*Changes to compose.yaml require the container to be removed and re-created. This should NOT affect your data.*

## Stop and remove the existing container.

podman-compose --file ~/.config/winapps/compose.yaml down

## Remove the existing FreeRDP certificate (if required).
*Note: A new certificate will be created when connecting via RDP for the first time.*
*If you configured a custom RDP_PORT, replace 3389 with that port.*

rm ~/.config/freerdp/server/127.0.0.1_3389.pem

## Re-create the container with the updated configuration.
podman-compose --file ~/.config/winapps/compose.yaml up

## Subsequent Use
podman-compose --file ~/.config/winapps/compose.yaml start # Power on the Windows VM
podman-compose --file ~/.config/winapps/compose.yaml pause # Pause the Windows VM
podman-compose --file ~/.config/winapps/compose.yaml unpause # Resume the Windows VM
podman-compose --file ~/.config/winapps/compose.yaml restart # Restart the Windows VM
podman-compose --file ~/.config/winapps/compose.yaml stop # Gracefully shut down the Windows VM
podman-compose --file ~/.config/winapps/compose.yaml kill # Force shut down the Windows VM