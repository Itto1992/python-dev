ARG PYTHON_VERSION=3.10.12
FROM python:${PYTHON_VERSION}

# poetry install
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH /root/.local/bin:$PATH

COPY pyproject.toml poetry.lock poetry.toml $WORKDIR/
RUN mkdir -m 700 $HOME/.ssh \
    && ssh-keyscan github.com > $HOME/.ssh/known_hosts
RUN pip install --upgrade pip
RUN --mount=type=ssh poetry install --no-root

# oh-my-zsh
ENV HOME /root
RUN apt -y update \
    && apt -y upgrade \
    && apt -y install \
    git \
    less \
    wget \
    zsh
SHELL ["/bin/zsh", "-c"]
RUN wget http://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
CMD ["zsh"]

# install neovim
# https://github.com/neovim/neovim/wiki/Installing-Neovim#appimage-universal-linux-package
# npm will used for vim-lsp
RUN apt update -y \
    && apt install -y \
    curl \
    npm \
    && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
    && chmod u+x nvim.appimage \
    && ./nvim.appimage --appimage-extract \
    && ./squashfs-root/AppRun --version \
    && ln -s /squashfs-root/AppRun /usr/bin/nvim

# vim-lsp server
RUN mkdir /root/.cache/tmp

# imgcat
COPY imgcat /usr/local/bin/imgcat
RUN chmod +x /usr/local/bin/imgcat

# install gcloud cli
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-477.0.0-linux-x86_64.tar.gz && \
    tar -xf google-cloud-cli-477.0.0-linux-x86_64.tar.gz && \
    ./google-cloud-sdk/install.sh -q && \
    mv ./google-cloud-sdk /root && \
    rm google-cloud-cli-477.0.0-linux-x86_64.tar.gz

# install terraform
RUN wget https://go.dev/dl/go1.22.6.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.22.6.linux-amd64.tar.gz && \
    rm go1.22.6.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
RUN git clone https://github.com/hashicorp/terraform.git && \
    cd terraform && \
    go install
