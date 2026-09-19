## Software APT Lists

One package per line. Install modules read these with `apt install $(cat <file>)`.

| File | Used by |
| --- | --- |
| `niri-build.apt` | Niri build dependencies (`scripts/2609180944.sh`). |
| `niri-runtime.apt` | Niri runtime / desktop baseline. |
| `ashell-build.apt`, `ashell-runtime.apt` | Status bar build and runtime deps. |
| `lemurs.apt` | Lemurs build deps (`scripts/2609180937.sh`). |
| `gpuIntel.apt`, `gpuAMD.apt`, `gpuNVIDIA.apt` | GPU drivers (`scripts/2609180913.sh`). |
| `noctalia.apt`, `noctalia-runtime.apt` | Noctalia repo packages and runtime (`scripts/2609180916.sh`). |
| `rc.apt` | Rat Commander deps (`scripts/2609181123.sh`). |
| `xwayland-satellite.apt` | Xwayland Satellite deps (`scripts/2609181656.sh`). |
| `winapps.apt` | Podman stack (`scripts/2609181124.sh`). |
| `lazy-spotify.apt` | LazySpotify deps. |

To add a package, append one package name per line. Keep build-time and run-time lists separate.
