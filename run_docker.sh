# Define Docker volumes and environment variables
DOCKER_VOLUMES="
--volume="/tmp/.X11-unix:/tmp/.X11-unix" \
--volume="/tmp/pulseaudio.socket:/tmp/pulseaudio.socket" \
--volume="$(eval echo ~$USER)/butia_ws/:/home/fbot/butia_ws/:rw" \
"
DOCKER_ENV_VARS="
--env="NVIDIA_DRIVER_CAPABILITIES=all" \
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1" \
--env="PULSE_SERVER=unix:/tmp/pulseaudio.socket" \
--env="PULSE_COOKIE=/tmp/pulseaudio.cookie" \
"
DOCKER_ARGS=${DOCKER_VOLUMES}" "${DOCKER_ENV_VARS}

# Run the command
docker run -it --net=host --gpus all --runtime=nvidia --privileged $DOCKER_ARGS $1 bash