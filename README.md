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

5. Create the pulseaudio socket

```bash
pactl load-module module-native-protocol-unix socket=/tmp/pulseaudio.socket
```

6. Allow docker to have access to the host:
```bash
xhost + local:docker
```
7. Initialize the container:

```bash
chmod +x run_docker.sh
./run_docker.sh doris_sim
```
### Inside the container:

1. Run rosdep:
```bash
cd ~/butia_ws/
sudo rosdep init
rosdep update
rosdep install -r --from-paths .
```
2. Build the package:
```bash
cd ~/butia_ws/
catkin_make
```
3. If you need to launch multiple terminals of the container do it with the following code:
```bash
docker exec -it <container> bash
```


