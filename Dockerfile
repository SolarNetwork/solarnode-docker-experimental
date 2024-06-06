FROM jgoerzen/debian-base-minimal:bookworm

# Configure SNF package repo
RUN <<EOF bash
apt-get update
apt-get install -y --no-install-recommends curl gnupg sudo ca-certificates
EOF

RUN <<EOF bash
mkdir -p /etc/apt/keyrings
curl -s "https://debian.repo.solarnetwork.org.nz/KEY.gpg" |gpg --dearmor |tee /etc/apt/keyrings/solarnetwork.gpg
echo "deb [signed-by=/etc/apt/keyrings/solarnetwork.gpg] https://debian.repo.solarnetwork.org.nz bookworm main" >/etc/apt/sources.list.d/solarnetwork.list
apt-get update
EOF

RUN apt-get install -y --no-install-recommends libpam-systemd

RUN apt-get install -y --no-install-recommends openjdk-17-jre-headless

RUN apt-get install -y --no-install-recommends ssh openssh-sftp-server

RUN apt-get install -y --no-install-recommends tmux

RUN useradd -m -U -G dialout,sudo -s /bin/bash solar

RUN echo solar:solar |chpasswd

# Tweak sn-system settings
COPY sn-system.txt /etc/default/sn-system

RUN <<EOF bash
apt-get install -y --no-install-recommends \
	sn-osstat \
	sn-solarpkg \
	sn-solarssh \
	sn-system \
	solarnode-base \
	solarnode-app-core \
	solarnode-app-db-h2
EOF

EXPOSE 4202
EXPOSE 8080