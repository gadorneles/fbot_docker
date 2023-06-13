# fbot_docker


![docker drawio(1)](https://github.com/gadorneles/fbot_docker/assets/14030779/ef2c8756-0d20-4a69-a919-b2d2e23c02fe)

docker build -f Dockerfile.nvidiaros -t nvidiaros .
docker build -f Dockerfile.sim -t doris_sim .

docker exec -it <container> bash

xhost + local:docker
docker run -it --net=host --gpus all \
--env="NVIDIA\_DRIVER\_CAPABILITIES=all" \
--env="DISPLAY" \
--env="QT\_X11\_NO_MITSHM=1" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
--privileged \
doris_sim \
bash

