############################################################
# A dockerfile used to construct a container for RRBSsim, making it easy to use. 
# Based on Ubuntu:14.04 
############################################################


# base image for python2.7
FROM ubuntu:17.10

# Author
MAINTAINER xwsun@zju.edu.cn version: 0.1.0

RUN apt-get update

# Compiler Installation
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 apt-utils

# python2.7 Installation
RUN apt-get install --yes python2.7

# Numpy and Scipy Installation
RUN apt-get install --yes python-scipy \
    python-numpy

# pip Installation
RUN apt-get install --yes python-pip


# pyfasta Installation
RUN pip install pyfasta

# pirs Downloading
RUN apt-get install -y wget
RUN wget -q ftp://ftp.genomics.org.cn/pub/pIRS/pIRS_111.tgz -O- | tar xzvf - -C /opt/ && \
    ln -s /opt/pIRS_111/ /opt/pirs

RUN apt-get install -y git
RUN git clone https://github.com/xwBio/RRBSsim.git /opt/RRBSsim  && \
    chmod -R a+x /opt/RRBSsim

WORKDIR /home


ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/pirs:/opt/RRBSsim 
