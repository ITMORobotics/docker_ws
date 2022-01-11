ARG from

FROM ${from}

SHELL ["/bin/bash", "-c"]


ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y apt-utils \
                                         lsb-release \
                                         mesa-utils \
                                         gnupg2 \
                                         net-tools \
                                         build-essential \
                                         wget \
                                         unzip \
                                         curl \
                                         git \
                                         mc \
                                         vim

# Base packages

RUN useradd -ms /bin/bash docker_ur
WORKDIR /ws
RUN chown -R docker_ur:docker_ur /ws
RUN chmod 775 /ws

RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y ros-noetic-desktop-full\
    python3-pip\
    libcanberra-gtk-module \
    libcanberra-gtk3-module &&\
    source /opt/ros/noetic/setup.bash && \
    echo "source /opt/ros/noetic/setup.bash"  >> /home/docker_ur/.bashrc && \
    echo "source /ws/catkin_ws/devel/setup.bash"  >> /home/docker_ur/.bashrc && \
    pip3 install rosdep rosinstall numpy scipy && \
    sudo rosdep fix-permissions && rosdep init && rosdep update

# Project packages
RUN pip3 install catkin_tools
RUN sudo addgroup docker

RUN apt-get install -y ros-noetic-industrial-robot-status-controller \
                        ros-noetic-industrial-robot-status-interface \
                        ros-noetic-scaled-joint-trajectory-controller \
                        ros-noetic-speed-scaling-interface

# Dependency for ur_driver
RUN apt-get install -y ros-noetic-speed-scaling-state-controller \
                        ros-noetic-ur-msgs \
                        ros-noetic-pass-through-controllers \
                        ros-noetic-ur-client-library \
                        ros-noetic-moveit

# USER docker_ur

