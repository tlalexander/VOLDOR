# Pull base image.
FROM nvidia/cuda:10.1-devel-ubuntu18.04

# Set timezone:
RUN ln -snf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && echo America/Los_Angeles > /etc/timezone

# Install.
RUN \
  apt update && \
  apt install -y build-essential && \
  apt install -y curl git htop man unzip vim wget && \
  apt install -y libopencv-dev python-opengl python3-opengl python3-pip

RUN python3 -m pip install --upgrade pip

RUN mkdir -p /root/VOLDOR
COPY . /root/VOLDOR/

RUN python3 -m pip install -r /root/VOLDOR/slam_py/install/requirements.txt

RUN cd /root/VOLDOR/slam_py/install  && python3 setup_linux_vo.py build_ext -i

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]