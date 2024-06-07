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

# Serial device support


Serial devices connected to the host system can be used in the container
by adding this to the `run` command to give udev access to the container:

```
-v /dev:/dev -v /run/udev:/run/udev:ro
```

Additionally, for each class of device, permission must be granted with a
`--device-cgroup-rule` argument. For example to allow USB serial devices:

```
--device-cgroup-rule='c 188:* rmw'
```

Here are some example devices that could be included:

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
