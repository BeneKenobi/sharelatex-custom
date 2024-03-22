FROM sharelatex/sharelatex:4.2.3

ENV DEBIAN_FRONTEND=noninteractive

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    ttf-mscorefonts-installer \
    python3-pygments \
    inkscape \
    && rm -rf /var/lib/apt/lists/*

RUN TEXLIVE_FOLDER=$(find /usr/local/texlive/ -type d -name '20*') \
    && echo % enable shell-escape by default >> /$TEXLIVE_FOLDER/texmf.cnf \
    && echo shell_escape = t >> /$TEXLIVE_FOLDER/texmf.cnf

    RUN wget http://mirror.ctan.org/systems/texlive/tlnet/update-tlmgr-latest.sh && \
    chmod +x update-tlmgr-latest.sh && ./update-tlmgr-latest.sh && \
    tlmgr install scheme-full --verify-repo=none