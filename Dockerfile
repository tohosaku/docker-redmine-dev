FROM debian:bullseye-slim

ENV GEM_HOME=/usr/local/bundle
ENV BUNDLE_APP_CONFIG=/usr/local/bundle

RUN apt-get update -qq && apt-get install -y curl git tig screen vim dialog ruby build-essential postgresql-client build-essential libpq-dev ruby-dev \
                          imagemagick ghostscript \
                       && mkdir -p /usr/local/dotfiles && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

WORKDIR /usr/src/redmine

COPY redmine.sh /usr/local/bin/
COPY ./dotfiles /usr/local/dotfiles

ARG LOCAL_UID
RUN apt-get update -qq && apt-get install -y nodejs yarn && \
    chmod +x /usr/local/bin/redmine.sh && useradd -u $LOCAL_UID -m user && cp -a /usr/local/dotfiles /home/user/.dotfiles && \
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb && \
    dpkg -i ripgrep_13.0.0_amd64.deb && \
    chown -R user:user /home/user
USER user

RUN sh /home/user/.dotfiles/init.sh && \
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install --all
