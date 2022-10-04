FROM sharelatex/sharelatex

ENV DEBIAN_FRONTEND=noninteractive

RUN tlmgr install scheme-full

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    ttf-mscorefonts-installer \
    && rm -rf /var/lib/apt/lists/*
