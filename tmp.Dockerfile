FROM debian:jessie
RUN mkdir -p /usr/share/man/man1 && \
    echo "deb http://archive.debian.org/debian jessie main contrib non-free" > /etc/apt/sources.list && \
    apt-get update && \
    apt-get -yu dist-upgrade && \
    apt-get -y --force-yes install tzdata=2018e-0+deb8u1 && \
    DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install x11vnc xvfb jwm iceweasel openjdk-7-jre tzdata-java icedtea-7-plugin icedtea-netx && \
    update-alternatives --set javaws /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/javaws && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/{apt,dpkg,cache,log}
RUN mkdir ~/.vnc && \
    echo "exec jwm &" >> ~/.xinitrc && \
    echo "firefox" >> ~/.xinitrc && \
    chmod 755 ~/.xinitrc
ENTRYPOINT ["/usr/bin/x11vnc", "-forever", "-create"]
