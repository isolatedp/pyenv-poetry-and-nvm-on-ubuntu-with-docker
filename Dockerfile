FROM ubuntu:24.04

ARG USER=root

RUN echo "done ubuntu env package" && \
    DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -yq locales tzdata && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure -f noninteractive tzdata locales

ENV TZ=Asia/Taipei
ENV LANG=en_US.utf8

RUN echo "done pyhton dep package" && \
    DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y build-essential --no-install-recommends make \
    ca-certificates \
    git \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    vim

# Python and poetry installation
USER $USER
ARG HOME="/$USER"
ARG PYTHON_VERSION=3.13

ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${HOME}/.local/bin:$PATH"

RUN curl https://pyenv.run | bash && \
    pyenv install ${PYTHON_VERSION} && \
    pyenv global ${PYTHON_VERSION} && \
    curl -sSL https://install.python-poetry.org | python3 - && \
    poetry config virtualenvs.in-project true && \
    poetry config virtualenvs.options.always-copy true

# Nvm and npm installation
ENV NODE_VERSION=22

ENV NVM_DIR="${HOME}/.nvm"
RUN echo "done nvm package" && \
    mkdir -p ${NVM_DIR} && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && \
    . ${NVM_DIR}/nvm.sh && \
    nvm install ${NODE_VERSION} && \
    nvm alias default ${NODE_VERSION} && \
    nvm use default

ENV NODE_PATH="${NVM_DIR}/v${NODE_VERSION}/lib/node_modules"
ENV PATH="${NVM_DIR}/versions/node/v${NODE_VERSION}/bin:$PATH"
    
RUN apt-get -y autoclean
