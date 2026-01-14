#!/bin/bash

# https://superuser.com/questions/1539634/pulseaudio-daemon-wont-start-inside-docker
# Start the pulseaudio server
rm -rf /var/run/pulse /var/lib/pulse /root/.config/pulse
pulseaudio -D --verbose --exit-idle-time=-1 --system --disallow-exit

# if [[ -v FORMAT ]]; then
#     ./pipe-audio.sh
# fi

if [[ -v HOST ]]; then
    ./snapcast.sh
    ./sendspin.sh
fi

echo /opt/ledfx/bin/ledfx -p 8888 --host 0.0.0.0 -c /app/ledfx-config $LEDFX_OPTS
/opt/ledfx/bin/ledfx -p 8888 --host 0.0.0.0 -c /app/ledfx-config $LEDFX_OPTS
