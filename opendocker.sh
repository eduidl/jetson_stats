#!/bin/bash

sudo docker build -t jetson_stats .

NVPModel=$(sudo nvpmodel -q 2>/dev/null)
NVPModel=$(echo $NVPModel | sed 's/.*Mode://')
power_mode_id=$(echo $NVPModel | cut -d' ' -f 2)

echo Power Mode ID: $power_mode_id

sudo docker run --rm -it \
  --privileged \
  -v /sys/kernel/debug/:/sys/kernel/debug:ro \
  -v /usr/bin/jetson_clocks:/usr/bin/jetson_clocks:ro \
  -v /usr/bin/tegrastats:/usr/bin/tegrastats:ro \
  -v /usr/sbin/nvpmodel:/usr/sbin/nvpmodel:ro \
  -v /etc/nvpmodel.conf:/etc/nvpmodel.conf:ro \
  -e DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  jetson_stats \
  bash -c "nvpmodel -m ${power_mode_id} && jtop"
