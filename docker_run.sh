(docker build -f Dockerfile -t ambhtmx-tonejs-image . || true) \
		&& docker run --env-file=.Renviron -p 7860:7860 --name ambhtmx-tonejs-container --rm ambhtmx-tonejs-image