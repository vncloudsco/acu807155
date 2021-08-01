FROM ubuntu:18.04
LABEL maintainer="xrsec"
LABEL mail="contact@manhtuong.net"

RUN mkdir /awvs
COPY awvs.sh /awvs
COPY Dockerfile /awvs
COPY xaa /awvs
COPY xab /awvs
COPY xac /awvs
COPY xad /awvs
COPY xae /awvs
COPY xaf /awvs
COPY awvs_listen.zip /awvs

# init
# RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak \
#     && sed -i "s/archive.ubuntu/mirrors.aliyun/g" /etc/apt/sources.list \
#     && sed -i "s/security.ubuntu/mirrors.aliyun/g" /etc/apt/sources.list \
#     && apt update -y \
RUN apt update -y \
    && apt upgrade -y \
    && apt-get install wget libxdamage1 libgtk-3-0 libasound2 libnss3 libxss1 libx11-xcb-dev sudo libgbm-dev curl ncurses-bin unzip -y
    # && apt-get install wget libxdamage1 libgtk-3-0 libasound2 libnss3 libxss1 libx11-xcb-dev sudo libgbm-dev curl ncurses-bin unzip -y \
    # && mv /etc/apt/sources.list.bak /etc/apt/sources.list

# init_install
RUN cat /awvs/xaa /awvs/xab /awvs/xac /awvs/xad /awvs/xae /awvs/xaf > /awvs/awvs_x86.sh \
    && chmod 777 /awvs/awvs_x86.sh \
    && sed -i "s/read -r dummy/#read -r dummy/g" /awvs/awvs_x86.sh \
    && sed -i "s/pager=\"more\"/pager=\"cat\"/g" /awvs/awvs_x86.sh \
    && sed -i "s/read -r ans/ans=yes/g" /awvs/awvs_x86.sh \
    && sed -i "s/read -p \"    Hostname \[\$host_name\]:\" hn/hn=awvs/g" /awvs/awvs_x86.sh \
    && sed -i "s/host_name=\$(hostname)/host_name=awvs/g" /awvs/awvs_x86.sh \
    && sed -i "s/read -p \"    Hostname \[\$host_name\]:\" hn/awvs/g" /awvs/awvs_x86.sh \
    && sed -i "s/read -p '    Email: ' master_user/master_user=contact@manhtuong.net/g" /awvs/awvs_x86.sh \
    && sed -i "s/read -sp '    Password: ' master_password/master_password=Abcd1234/g" /awvs/awvs_x86.sh \
    && sed -i "s/read -sp '    Password again: ' master_password2/master_password2=Abcd1234/g" /awvs/awvs_x86.sh \
    && sed -i "s/systemctl/\# systemctl/g"  /awvs/awvs_x86.sh \
    && /bin/bash /awvs/awvs_x86.sh

# init_listen
RUN chmod 777 /awvs/awvs.sh \
    && unzip -d /awvs/awvs_listen /awvs/awvs_listen.zip \
    && chmod 444 /awvs/awvs_listen/license_info.json \
    && cp /awvs/awvs_listen/wvsc /home/acunetix/.acunetix/v_210628104/scanner/ \
    && cp /awvs/awvs_listen/license_info.json /home/acunetix/.acunetix/data/license/ \
    && cp /awvs/awvs_listen/wa_data.dat /home/acunetix/.acunetix/data/license/ \
    && chown acunetix:acunetix /home/acunetix/.acunetix/data/license/wa_data.dat

ENTRYPOINT [ "/awvs/awvs.sh"]

EXPOSE 3443

STOPSIGNAL SIGQUIT

CMD ["/awvs/awvs.sh"]
