FROM ubuntu:latest
RUN apt update && apt -y upgrade && \
    apt install -y python3 python3-pip && \
    python3 -m pip install Django && \
    pip install coverage && \
    mkdir /django-data
RUN echo "tzdata tzdata/Areas select Europe" | debconf-set-selections && \
    echo "tzdata tzdata/Zones/Europe select Berlin" | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
COPY django-init.sh /
# ENTRYPOINT [ "./django-init.sh" ]
# ENTRYPOINT [ "tail", "-f", "/dev/null" ]
WORKDIR /django-data
# EXPOSE 8000
USER root