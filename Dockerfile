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
