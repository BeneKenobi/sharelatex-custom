FROM docker.io/sharelatex/sharelatex:4.2.3

ENV DEBIAN_FRONTEND=noninteractive

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
    && apt-get update -qqy || apt-get --only-upgrade install ca-certificates -y && apt-get update -qqy \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    ttf-mscorefonts-installer \
    python3-pygments \
    inkscape \
    xzdec \
    python-pygments \
    aspell \
    aspell-* \
    cm-super \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://mirror.ctan.org/systems/texlive/tlnet/update-tlmgr-latest.sh \
    && sh update-tlmgr-latest.sh -- --upgrade \
    && rm update-tlmgr-latest.sh

RUN tlmgr option repository https://ftp.rrzn.uni-hannover.de/pub/mirror/tex-archive/systems/texlive/tlnet \
    && tlmgr update --self --all \
    && tlmgr install scheme-full

RUN luaotfload-tool -fu

RUN TEXLIVE_FOLDER=$(find /usr/local/texlive/ -type d -name '20*') \
    && echo % enable shell-escape by default >> /$TEXLIVE_FOLDER/texmf.cnf \
    && echo shell_escape = t >> /$TEXLIVE_FOLDER/texmf.cnf