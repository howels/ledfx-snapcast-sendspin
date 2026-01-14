FROM --platform=$TARGETPLATFORM python:3.12-trixie

ARG LEDFX_RELEASE
ENV LEDFX_RELEASE=$LEDFX_RELEASE

WORKDIR /app

RUN apt update
RUN apt install -y gcc \
                       cmake \
                       python3-dev \
                       python3-virtualenv \
                       git \
                       libatlas3-base \
                       libatlas3-base \
                       portaudio19-dev \
                       pulseaudio \
                       alsa-utils \
                       snapclient

RUN python -m venv /opt/ledfx
ENV PATH="/opt/ledfx/bin:$PATH"
RUN pip install Cython
RUN pip install samplerate
RUN pip install git+https://github.com/aubio/aubio@5461304
RUN pip install  --upgrade pip wheel setuptools
RUN pip install git+https://github.com/LedFx/LedFx@${LEDFX_RELEASE}
RUN pip install sendspin

# RUN apt-get install -y pulseaudio alsa-utils
RUN adduser root pulse-access

# allow swapping scripts without full rebuilds
ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
COPY setup-files/ /app/
RUN chmod a+wrx /app/*

ENTRYPOINT ./entrypoint.sh
