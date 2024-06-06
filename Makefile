build : 
	docker build -t solarnode-experimental .
	
run :
	docker run -td --publish 8080:8080 --publish 4202:4202 \
		--mount src=sn-conf,dst=/etc/solarnode \
		--mount src=sn-data,dst=/var/lib/solarnode/var \
		--memory 1GB \
		--stop-signal=SIGRTMIN+3 \
		--tmpfs /run:size=250M --tmpfs /run/lock:size=100M \
		-v /sys/fs/cgroup:/sys/fs/cgroup:rw \
		--cgroupns=host \
		--name solarnode-experimental solarnode-experimental
		
stop : 
	docker stop solarnode-experimental
		
start : 
	docker start solarnode-experimental
		
shell:
	docker exec -it solarnode-experimental /bin/bash
	
tag:
	docker tag solarnode-experimental:latest snmatt/sndev:solarnode-experimental

push:
	docker push snmatt/sndev:solarnode-experimental
