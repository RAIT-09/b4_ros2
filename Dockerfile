FROM ubuntu:22.04

# ビルド時に渡すパラメータ
ARG UID
ARG GID
ARG USER_NAME
ARG GROUP_NAME

# Timezone, Launguage設定
RUN apt update \
    && apt install -y --no-install-recommends \
        locales sudo \
    software-properties-common tzdata \
    && locale-gen en_US en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
    && add-apt-repository universe

ENV LANG=en_US.UTF-8
ENV TZ=Asia/Tokyo

# ライブラリの追加
RUN apt update \
    && apt install -y --no-install-recommends \
        curl git tmux gnupg2 lsb-release python3-pip vim wget build-essential ca-certificates

# ROS2のインストール
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt update \
    && apt upgrade -y\
    && DEBIAN_FRONTEND=noninteractive \
    && apt install -y --no-install-recommends \
    ros-humble-desktop \
    python3-colcon-common-extensions \
    python3-rosdep \
    '~nros-humble-rqt*'

# ユーザとグループの追加
RUN groupadd -g $GID $GROUP_NAME
RUN useradd -u $UID -g $GID -s /bin/bash -m $USER_NAME
RUN usermod -a -G video $USER_NAME
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && chmod 0440 /etc/sudoers && chmod g+w /etc/passwd
USER $USER_NAME

WORKDIR /home/${USER_NAME}/ws
RUN mkdir src

SHELL ["/bin/bash", "-c"]

RUN source /opt/ros/humble/setup.bash \
    && sudo apt-get update \
    && sudo rosdep init \
    && rosdep update \
    && rosdep install --from-paths src --rosdistro humble -i -y

RUN echo "source /opt/ros/humble/setup.bash" >> /home/${USER_NAME}/.bashrc
RUN echo "source ~/ws/install/setup.bash" >> /home/${USER_NAME}/.bashrc

RUN source /opt/ros/humble/setup.bash && \
    colcon build --symlink-install --parallel-workers 1 --event-handlers console_cohesion+ console_direct+ log+

RUN sudo rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]