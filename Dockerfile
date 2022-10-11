FROM ruby:3.1-slim-bullseye

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
      gnupg \
      file \
      curl \
      git \
      tig \
      tmux \
      vim \
      dialog \
      build-essential \
      postgresql-client \
      libpq-dev \
      imagemagick \
      ghostscript \
      universal-ctags \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log \
    && mkdir -p /usr/local/dotfiles && \
    mkdir /root/.gnupg && gpg  --no-default-keyring --keyring /usr/share/keyrings/archive-keyring.gpg --fetch-keys https://dl.yarnpkg.com/debian/pubkey.gpg && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    echo "deb [signed-by=/usr/share/keyrings/archive-keyring.gpg] https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

WORKDIR /workspace

COPY redmine.sh /usr/local/bin/
COPY ./dotfiles /usr/local/dotfiles

ARG LOCAL_UID
RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    nodejs yarn && \
    apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log \
     chmod +x /usr/local/bin/redmine.sh && useradd -u $LOCAL_UID -m user && \
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb && \
    dpkg -i ripgrep_13.0.0_amd64.deb && \
    chown -R user:user /home/user

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

USER user

RUN rm -rf ~/.dotfiles && cp -a /usr/local/dotfiles ~/.dotfiles && sh ~/.dotfiles/init.sh && \
    rm -rf ~/bin && mkdir ~/bin && cd ~/bin && \
    curl -LO https://github.com/arl/gitmux/releases/download/v0.7.10/gitmux_0.7.10_linux_amd64.tar.gz && tar zxvf gitmux_0.7.10_linux_amd64.tar.gz && \
    mkdir ~/.cache && \
    cd /workspace && \
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install --all && \
    bundle config set path '/usr/local/bundle'
