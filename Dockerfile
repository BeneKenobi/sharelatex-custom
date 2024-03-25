FROM sharelatex/sharelatex:4.2.3

ENV DEBIAN_FRONTEND=noninteractive

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
    set -xe \
    && apt-get update -qqy || apt-get --only-upgrade install ca-certificates -y && apt-get update -qqy \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    ttf-mscorefonts-installer \
    python3-pygments \
    inkscape \
    texlive-full \
    xzdec \
    python-pygments \
    aspell \
    aspell-* \
    texlive-babel-* \
    && rm -rf /var/lib/apt/lists/*
