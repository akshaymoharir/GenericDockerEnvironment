

############################    Basic   ###########################

FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
#RUN apt-get -y install tzdata

#ENV DEBIAN_FRONTEND noninteractive
#ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential  \
     checkinstall \
     libreadline-gplv2-dev \
    libncursesw5-dev \
    libssl-dev \
    libsqlite3-dev \
    tk-dev \
    libgdbm-dev \
    libc6-dev \
    libbz2-dev \
    zlib1g-dev \
    openssl \
    libffi-dev \
    wget


# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libzmq3-dev \
        pkg-config \
        liblzma-dev \
        rsync \
        software-properties-common \
        unzip \
        cmake \
        vim \
        git \
	    bc \
	    less \
	    strace \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 



RUN mkdir /tmp/Python37 \
    && cd /tmp/Python37 \
    && wget https://www.python.org/ftp/python/3.7.7/Python-3.7.7.tar.xz \
    && tar xvf Python-3.7.7.tar.xz \
    && cd /tmp/Python37/Python-3.7.7 \
    && ./configure \
    && make altinstall

RUN ln -s /usr/local/bin/python3.7 /usr/bin/python
RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py

RUN pip install --upgrade pip
RUN pip install requests
RUN apt-get install curl -y

RUN pip install jupyter --upgrade
RUN pip install jupyterlab --upgrade

RUN unlink /usr/bin/python
RUN ln -s /usr/local/bin/python3.7 /usr/bin/python


RUN apt-get install bash -y
RUN pip install bash_kernel
RUN python -m bash_kernel.install



############################    Machine Learning Packages   ###########################

RUN pip install numpy
RUN pip install scipy

RUN pip install pandas matplotlib plotly sklearn absl-py astor backports.functools-lru-cache backports.weakref cloudpickle cycler 
RUN pip install dask decorator django enum34 funcsigs futures gast grpcio image imutils kiwisolver Markdown mock networkx pbr 
RUN pip install protobuf pyparsing python-dateutil pytz PyWavelets PyYAML six subprocess32 termcolor toolz utils Werkzeug

RUN pip install scikit-learn
RUN pip install tensorflow
RUN pip install torch==1.5.1+cpu torchvision==0.6.1+cpu -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install keras keras_applications keras_preprocessing
RUN pip install Pillow h5py nodejs
###############################################################

#############################   OpenCV  #######################

#                    RUN add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
#                    RUN cwd=$(pwd)
#                    RUN apt-get update && apt-get install -y build-essential checkinstall cmake pkg-config yasm git gfortran \
#                    libjpeg8-dev libpng-dev software-properties-common libjasper1 libtiff-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev \
#                    libxine2-dev libv4l-dev

#                    RUN apt -y remove x264 libx264-dev
#                    ## Install dependencies
#
#                    RUN cd /usr/include/linux
#                    RUN ln -s -f ../libv4l1-videodev.h videodev.h
#                    RUN cd "$cwd"
#                    RUN apt-get update && apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
#                    libgtk2.0-dev libtbb-dev qt5-default \
#                    libatlas-base-dev \
#                    libfaac-dev libmp3lame-dev libtheora-dev \
#                    libvorbis-dev libxvidcore-dev \
#                    libopencore-amrnb-dev libopencore-amrwb-dev \
#                    libavresample-dev \
#                    x264 v4l-utils
#
#                    # Optional dependencies
#                    RUN apt-get update && apt-get install -y libprotobuf-dev protobuf-compiler \
#                    libgoogle-glog-dev libgflags-dev \
#                    libgphoto2-dev libeigen3-dev libhdf5-dev doxygen
#                    RUN apt-get update && apt-get install -y python3-dev python3-pip
#
#                    RUN apt-get install -y software-properties-common 
#                    RUN apt-add-repository universe 
#                    RUN apt-get update && apt-get install -y python-pip
#
#                    RUN pip2 install -U pip numpy && \
#                        pip3 install -U pip numpy
#
#                    #RUN apt-get install -y python3-testresources
#
#                    RUN python3 -m pip uninstall -y pip && \
#                        apt install -y python3-pip --reinstall
#
#                    RUN apt-get update && apt-get install -y python3-testresources
#
#                    RUN pip3 install numpy
#                    #RUN apt-get update && apt-get install python2.7
#
#                    ENV OPENCV_VERSION="4.3.0"
#                    RUN wget --no-verbose https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
#                    && unzip ${OPENCV_VERSION}.zip \
#                    && mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
#                    && cd /opencv-${OPENCV_VERSION}/ \
#                    #&& git clone https://github.com/opencv/opencv_contrib.git \
#                    #&& cd /opencv-${OPENCV_VERSION}/opencv_contrib \
#                    #&& git checkout 4.3.0 \
#                    && cd /opencv-${OPENCV_VERSION}/cmake_binary \
#                    && cmake -D CMAKE_BUILD_TYPE=RELEASE \
#                                -D CMAKE_INSTALL_PREFIX=$cwd/installation/OpenCV-"$OPENCV_VERSION" \
#                                -D INSTALL_C_EXAMPLES=ON \
#                                -D INSTALL_PYTHON_EXAMPLES=ON \
#                                -D WITH_TBB=ON \
#                                -D WITH_V4L=ON \
#                                -D OPENCV_PYTHON3_INSTALL_PATH=$cwd/OpenCV-$cvVersion-py3/lib/python3.5/site-packages \
#                            -D WITH_QT=ON \
#                            -D WITH_OPENGL=ON \
#                    #        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
#                            -D BUILD_EXAMPLES=ON .. \
#                            -DCMAKE_INSTALL_PREFIX=$(python3 -c "import sys; print(sys.prefix)") \
#                            -DPYTHON_EXECUTABLE=$(which python) \
#                            -DPYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
#                            -DPYTHON_PACKAGES_PATH=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
#                            #-DPYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")  \
#                            -DPYTHON_LIBRARY=$(python -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))") \
#                    && make -j 8 install \
#                    && rm /${OPENCV_VERSION}.zip \
#                    && rm -r /opencv-${OPENCV_VERSION} 

RUN pip3 install opencv-python
RUN apt-get update && apt-get install -y libopencv-dev
RUN export OpenCV_DIR=/usr/share/OpenCV

###############################################################


ENV MAIN_PATH=/usr/local/bin/my_docker_env
ENV LIBS_PATH=${MAIN_PATH}/libs
ENV CONFIG_PATH=${MAIN_PATH}/config
ENV NOTEBOOK_PATH=${MAIN_PATH}/notebooks

EXPOSE 8888

CMD cd ${MAIN_PATH} && sh config/run_jupyter.sh

###############################################################
