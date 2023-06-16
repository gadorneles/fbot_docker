# fbot_docker


![docker drawio(3)](https://github.com/gadorneles/fbot_docker/assets/14030779/1255bef0-1e3d-423b-916a-b46df8776244)

## Setup

1. Install docker following the [official documentation](https://docs.docker.com/get-docker/).
2. Install the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html).
3. Clone this repository:
```bash
git clone https://github.com/gadorneles/fbot_docker
```
4. Build the images from this repository:
```bash
docker build -f Dockerfile.nvidiaros -t nvidiaros .
docker build -f Dockerfile.sim -t doris_sim .
```
5. Allow docker to have access to the host:
```bash
xhost + local:docker
```
6. Initialize the container:

```bash
docker run -t -i --net=host --gpus all \
--env="NVIDIA\_DRIVER\_CAPABILITIES=all" \
--env="DISPLAY" \
--env="QT\_X11\_NO_MITSHM=1" \
--env="PULSE_SERVER=unix:/tmp/pulseaudio.socket" \
--env="PULSE_COOKIE=/tmp/pulseaudio.cookie" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
--volume="/tmp/pulseaudio.socket:/tmp/pulseaudio.socket" \
--privileged \
doris_sim \
bash

```

7. Clone the butia_behavior repository:  
```bash
cd ~/butia_ws/src
git clone https://github.com/butia-bots/butia_behavior.git
```
8. Run rosdep:
```bash
cd ~/butia_ws/
sudo rosdep init
rosdep update
rosdep install -r --from-paths .
```
9. Build the package:
```bash
cd ~/butia_ws/
catkin_make
```
10. If you need to launch multiple terminals of the container do it with the following code:
```bash
docker exec -it <container> bash
```


