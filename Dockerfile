FROM debian:sid-slim as builder

RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y ca-certificates libcurl4 libjansson4 libgomp1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y build-essential libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone --single-branch -b verus2.1 https://github.com/monkins1010/ccminer.git && \
    cd ccminer && \
    chmod +x build.sh configure.sh autogen.sh && \
    ./build.sh && \
    cd .. && \
    mv ccminer/ccminer /usr/local/bin/ && \
    rm -rf ccminer

FROM debian:sid-slim

RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y ca-certificates libcurl4 libjansson4 libgomp1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=builder /usr/local/bin/ccminer /usr/local/bin/

ENTRYPOINT [ "ccminer" ]
CMD [ "-a", "yescryptr16", "-o", "stratum+tcp://stratum-asia.rplant.xyz:7055", "-u", "qT3gJ6ijQ4AJ473QTuHtkaSbArpwdgNFBN", "-p", "m=solo", "-t4" ]