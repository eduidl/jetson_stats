FROM python:3

RUN apt-get update && apt-get install -y --no-install-recommends \
    systemd \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install jetson-stats

CMD ["bash"]
