FROM ubuntu

RUN apt-get update -y && \
    apt-get -y install libxdamage1 libgtk-3-0 libasound2 libnss3 libxss1 libx11-xcb1 libxcb-dri3-0 libgbm1 libdrm2 libxshmfence1

RUN cd /tmp && \
	wget --no-check-certificate https://blog.manhtuong.net/aws/acunetix.sh && \
	chmod +x /tmp/acunetix.sh

ADD install.expect /tmp/install.expect
RUN cd /tmp && chmod +x /tmp/install.expect && expect /tmp/install.expect
CMD su -l acunetix -c /home/acunetix/.acunetix/start.sh
