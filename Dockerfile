FROM kalilinux/kali-rolling

RUN apt-get update -y && \
    apt-get -y install libxdamage1 sudo bzip2 wget expect libgtk-3-0 libasound2 libnss3 libxss1 libx11-xcb1  libxcb-dri3-0 libgbm1 libdrm2 libdrm-dev libgbm-dev

RUN cd /tmp && \
	wget --no-check-certificate https://gitlab.com/mtsec/tes123t/-/raw/14.3.210615184/acunetix_14.3.210615184_x64.sh && \
	chmod +x /tmp/acunetix_14.3.210615184_x64.sh

ADD install.expect /tmp/install.expect
ADD wvsc /tmp/wvsc
ADD license_info.json /tmp/license_info.json
ADD wa_data.dat /tmp/wa_data.dat
RUN cd /tmp && chmod +x /tmp/install.expect && expect /tmp/install.expect
RUN cp /tmp/wvsc /home/acunetix/.acunetix/v_*/scanner/
RUN cp /tmp/license_info.json /home/acunetix/.acunetix/data/license/
RUN cp /tmp/wa_data.dat /home/acunetix/.acunetix/data/license/
RUN chmod 444 /home/acunetix/.acunetix/data/license/license_info.json
RUN chmod 444 /home/acunetix/.acunetix/data/license/wa_data.dat
CMD su -l acunetix -c /home/acunetix/.acunetix/start.sh
