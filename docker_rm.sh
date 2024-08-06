(docker container rm -f ambhtmx-tonejs-container || true) \
		&& (docker rmi $(docker images --format '{{.Repository}}:{{.ID}}'| egrep 'ambhtmx-tonejs-image' | cut -d':' -f2 | uniq) --force || true)