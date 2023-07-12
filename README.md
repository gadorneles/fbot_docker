# fbot_docker


![docker drawio(3)](https://github.com/gadorneles/fbot_docker/assets/14030779/1255bef0-1e3d-423b-916a-b46df8776244)

## Setup

It's important to note that the container currently only works if you have a working NVIDIA GPU.

1. Install docker following the [official documentation](https://docs.docker.com/get-docker/).
2. Install the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html).
3. Clone this repository:
```bash
git clone https://github.com/gadorneles/fbot_docker
```
4. Build the images from this repository:
```bash
docker build -f Dockerfile.fbot -t fbot .
```

5. Create the pulseaudio socket

```bash
pactl load-module module-native-protocol-unix socket=/tmp/pulseaudio.socket
```

6. Allow docker to have access to the host:
```bash
xhost + local:docker
```
7. Download the butia packages:
```bash
mkdir -p ~/butia_ws/src
cd ~/butia_ws/src
```

```bash
git clone https://github.com/butia-bots/butia_speech.git
git clone https://github.com/butia-bots/butia_launchfiles.git
git clone https://github.com/butia-bots/butia_world.git
git clone https://github.com/butia-bots/butia_world_msgs.git
git clone https://github.com/butia-bots/butia_navigation_system.git
git clone https://github.com/butia-bots/butia_quiz.git
git clone --recursive https://github.com/butia-bots/butia_vision.git
git clone https://github.com/butia-bots/interbotix_ros_core.git
git clone https://github.com/butia-bots/interbotix_ros_manipulators.git
git clone https://github.com/butia-bots/interbotix_ros_toolboxes.git
git clone https://github.com/butia-bots/butia_face.git
git clone https://github.com/butia-bots/butia_description.git
git clone https://github.com/butia-bots/iai_kinect2.git
git clone https://github.com/butia-bots/rosaria.git
```
7. Initialize the container:

```bash
chmod +x run_docker.sh
./run_docker.sh fbot
```
### Inside the container:

1. Clone the libfreenect repository:
```bash
cd ~/butia_ws/src/
git clone https://github.com/butia-bots/libfreenect2.git
cd ~/butia_ws/src/libfreenect
chmod +x install.sh
./install.sh
```
Everytime you create a new container you need to delete the current libfreenect folder and clone it again.

2. Enter the correct branches:

```bash
cd ~/butia_ws/src/butia_vision/ \
git checkout feat/vision_reqs \
chmod +x install.sh \
./install.sh \
cd ~/butia_ws/src/libfreenect2 \
chmod +x install.sh \
./install.sh \
cd ~/butia_ws/src/butia_speech \
git checkout feat/speech_reqs \
cd ~/butia_ws/src/butia_navigation_system \
git checkout feature/simulation \
cd ~/butia_ws/src/butia_launchfiles \
git checkout feat/follow-sim \
cd ~/butia_ws/src/interbotix_ros_manipulators \
git checkout feat/doris-arm \
cd ~/butia_ws/src/butia_description \
git checkout feat/update-sim \
cd ~/butia_ws/src/interbotix_ros_toolboxes \
git checkout noetic \
cd ~/butia_ws/src/interbotix_ros_core \
git checkout noetic\ 
```

3. Run rosdep:
```bash
cd ~/butia_ws/
sudo rosdep init
rosdep update
rosdep install -r --from-paths .
```

4. Build the package:
```bash
cd ~/butia_ws/
catkin_make
```
5. If you need to launch multiple terminals of the container do it with the following:
```bash
docker exec -it <container> bash
```



