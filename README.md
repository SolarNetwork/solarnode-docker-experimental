# SolarNode Docker

Based on [jgoerzen/debian-base-minimal:bookworm](https://github.com/jgoerzen/docker-debian-base-minimal?tab=readme-ov-file)
Docker image to leverage existing SolarNodeOS packages as much as possible.

# Use

Pull the `snmatt/sndev:solarnode-experimental` image from Dockerhub.

# Building

You can use `make` with the following targets:

| Target | Description |
|:-------|:------------|
| `build` | Create the SolarNode Docker image |
| `run`   | Launch the SolarNode container |
| `start` | Start a previously stopped SolarNode container |
| `stop`  | Stop a launched (via `run` SolarNode container) |
| `tag`   | Tag the latest SolarNode image |
| `push`  | Push the latest SolarNode image tag |

# Future research

The following sections detail areas needed further research.

## Serial device support

Serial devices connected to the host system are unlikely to work as-is.

To handle USB may need stuff like:

```
# webcams
--device-cgroup-rule='c 81:* rmw'

# ttyUSB
--device-cgroup-rule='c 188:* rmw'

# ttyAMA
--device-cgroup-rule='c 204:* rmw'

# gpiochip
--device-cgroup-rule='c 254:* rmw'
```

See <https://stackoverflow.com/a/66427245>

Test if need to add to `dialout` group:

```
--group-add dialout
```
