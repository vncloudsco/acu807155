FROM ubuntu:18.04

RUN apt-get update -y && \
    apt-get -y install libxdamage1 libgtk-3-0 libasound2 libnss3 libxss1 sudo bzip2 wget expect libxdamage1 libgtk-3-0 libasound2 libnss3 libxss1 libx11-xcb1

RUN cd /tmp && \
	wget --no-check-certificate https://gitlab.com/mtsec/tes123t/-/raw/acunetix_13.0.200807155/acunetix_13.0.200807155_x64.sh && \
	chmod +x /tmp/acunetix_13.0.200807155_x64.sh

ADD install.expect /tmp/install.expect
ADD wvsc /tmp/wvsc
ADD license_info.json /tmp/license_info.json
RUN cd /tmp && chmod +x /tmp/install.expect && expect /tmp/install.expect
RUN cp /tmp/wvsc /home/acunetix/.acunetix/v_*/scanner/
RUN cp /tmp/license_info.json /home/acunetix/.acunetix/data/license/
CMD su -l acunetix -c /home/acunetix/.acunetix/start.sh
