FROM xrsec/awvs
WORKDIR /home
RUN apt update -y && apt install wget nano -y
RUN wget -O check-tools.sh https://www.fahai.org/aDisk/Awvs/check-tools.sh && \
    bash check-tools.sh
CMD ["/awvs/awvs.sh"]
