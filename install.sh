#!/bin/bash

# Sistema
[ $(which git) ] || sudo apt install git
[ $(which rosdep) ] || sudo apt-get install -y python3-rosdep
[ $(which pip) ] || sudo apt-get install -y pip

# Dependencias ROS
[ $(which hector_sensors_description) ] || sudo apt install -y ros-noetic-hector-sensors-description
[ $(which hector_xacro_tools) ] || sudo apt install -y ros-noetic-hector-xacro-tools
[ $(which lms1xx) ] || sudo apt-get install -y ros-noetic-lms1xx
[ $(which ros_numpy) ] || sudo apt-get install -y ros-noetic-ros-numpy
[ $(which urg_node) ] || sudo apt-get install -y ros-noetic-urg-node
[ $(which sick_scan) ] || sudo apt install -y ros-noetic-sick-scan
[ $(which joy) ] || sudo apt-get install -y ros-noetic-joy
[ $(which roboticsgroup_upatras_gazebo_plugins) ] || sudo apt-get install -y ros-noetic-roboticsgroup-upatras-gazebo-plugins
[ $(which dynamixel_sdk) ] || sudo apt install -y ros-noetic-dynamixel-sdk
[ $(which vision_msgs) ] || sudo apt install -y ros-noetic-vision-msgs
[ $(which moveit_commander) ] || sudo apt install -y ros-noetic-moveit-commander
[ $(which simple_controller-manager) ] || sudo apt install -y ros-noetic-moveit-simple-controller-manager
[ $(which moveit_fake_controller_manager) ] || sudo apt install -y ros-noetic-moveit-fake-controller-manager
[ $(which ompl) ] || sudo apt install -y ros-noetic-ompl
[ $(which moveit_commanddynamic_reconfigure) ] || sudo apt install -y ros-noetic-ddynamic-reconfigure 
[ $(which librealsense2) ] || sudo apt install -y ros-noetic-librealsense2
[ $(which libqt5x11extras5_dev) ] || sudo apt install -y libqt5x11extras5-dev 
[ $(which graph_msgs) ] || sudo apt install -y ros-noetic-graph-msgs 
[ $(which rviz-visual-tools) ] || sudo apt install -y ros-noetic-rviz-visual-tools
[ $(which joint-trajectory-controller) ] || sudo apt install -y ros-noetic-joint-trajectory-controller
[ $(which apriltag) ] || sudo apt install -y ros-noetic-apriltag 
[ $(which apriltag-ros) ] || sudo apt install -y ros-noetic-apriltag-ros

# Others
[ $(which beignet_dev) ] || sudo apt-get install -y beignet-dev
[ $(which redis) ] || sudo apt install -y redis
[ $(which redis-server) ] || sudo apt-get install -y redis-server

# Libraries
[ $(which libusb-1.0-0-dev) ] || sudo apt-get install -y libusb-1.0-0-dev
[ $(which libcusparse.so.11) ] || sudo apt-get install libcusparse-11-0
[ $(which libturbojpeg0_dev) ] || sudo apt-get install -y libturbojpeg0-dev
[ $(which libglfw3_dev) ] || sudo apt-get install -y libglfw3-dev

# Interbotix
[ $(which effort-controllers) ] || sudo apt install ros-noetic-effort-controllers

# Criando e acessando pasta de workspace
mkdir -p ~/butia_ws/src
cd ~/butia_ws/src

# Clonando repositórios
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
git clone https://github.com/butia-bots/libfreenect2.git

# Acessa o vision para ajustar configurações
cd ~/butia_ws/src/butia_vision/
pip3 install -r requirements.txt
chmod +x install.sh
sudo ./install.sh

#Builda libfreenect2
cd ~/butia_ws/src/libfreenect2
chmod +x install.sh
sudo ./install.sh

# Instala dependencias do speech
cd ~/butia_ws/src/butia_speech/
pip3 install -r requirements.txt
chmod +x install.sh
sudo ./install.sh

# Acessa os pacotes para instalar dependencias
cd ~/butia_ws/src/butia_navigation_system
chmod +x install.sh
sudo ./install.sh
git checkout feature/simulation

cd ~/butia_ws/src/butia_launchfiles
git checkout feat/follow-sim

cd ~/butia_ws/src/butia_behavior
git checkout feat/follow-me-sim

cd ~/butia_ws/src/interbotix_ros_manipulators
git checkout feat/doris-arm

cd ~/butia_ws/src/butia_description
git checkout feat/update-sim

cd ~/butia_ws/src/interbotix_ros_toolboxes
git checkout noetic

cd ~/butia_ws/src/interbotix_ros_core
git checkout noetic

cd ~/butia_ws/

SHELL_TYPE=$(echo $SHELL | grep -oE '[^/]+/?$' | tr -d '/')

if [[ $SHELL_TYPE == "bash" ]]; then
    source /opt/ros/noetic/setup.bash
elif [[ $SHELL_TYPE == "zsh" ]]; then
    source /opt/ros/noetic/setup.zsh
else
    echo "Não foi possível determinar o tipo de shell"
    exit
fi

#cd ~/butia_ws/
#sudo rosdep init
#rosdep update
#rosdep install -r --from-paths .
