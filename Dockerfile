FROM ruby:3.1-slim-bullseye

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
      gnupg \
      file \
      curl \
      git \
      tig \
      screen \
      vim \
      dialog \
      build-essential \
      postgresql-client \
      libpq-dev \
      imagemagick \
      ghostscript \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log \
    && mkdir -p /usr/local/dotfiles && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

WORKDIR /usr/src/redmine

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
     chmod +x /usr/local/bin/redmine.sh && useradd -u $LOCAL_UID -m user && cp -a /usr/local/dotfiles /home/user/.dotfiles && \
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb && \
    dpkg -i ripgrep_13.0.0_amd64.deb && \
    chown -R user:user /home/user

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

USER user

RUN sh /home/user/.dotfiles/init.sh && \
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install --all && \
    curl -sS https://starship.rs/install.sh | sh && \
    bundle config set path '/usr/local/bundle'
