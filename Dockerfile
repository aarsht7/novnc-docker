FROM debian:stable-slim

RUN apt-get install python3-pip

RUN   pip uninstall pillow --break-system-packages \
      pip uninstall pyyaml --break-system-packages \
      pip uninstall pygments --break-system-packages \
      pip uninstall cryptography --break-system-packages \
      pip uninstall certifi --break-system-packages 

RUN   pip install pillow==10.0.1 --break-system-packages \
      pip install pyyaml>=5.4 --break-system-packages \ 
      pip install pygments>=2.15.0 --break-system-packages \
      pip install cryptography==41.0.4 --break-system-packages 

RUN set -ex; \
    apt-get update; \
    apt-get upgrade; \
    apt-get install -y \
      bash \
      git \
      net-tools \
      novnc \
      supervisor \
      xterm 

ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=no \
    RUN_FLUXBOX=no

RUN apt-get purge python3-pip -y

COPY . /novnc-docker

CMD ["/novnc-docker/app/entrypoint.sh"]
EXPOSE 8080