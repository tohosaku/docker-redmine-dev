FROM ruby:3.3.0-slim-bookworm

ADD https://github.com/itamae-kitchen/mitamae/releases/download/v1.14.1/mitamae-x86_64-linux /usr/local/bin/mitamae
RUN chmod +x /usr/local/bin/mitamae

COPY ./mitamae /usr/local/share/mitamae
RUN /usr/local/bin/mitamae local /usr/local/share/mitamae/cookbooks/system/default.rb

WORKDIR /workspace

ARG LOCAL_UID
RUN chmod +x /usr/local/bin/redmine.sh \
    && useradd -u $LOCAL_UID -m user \
    && curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb \
    && dpkg -i ripgrep_13.0.0_amd64.deb \
    && chown -R user:user /home/user \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && truncate -s 0 /var/log/*log

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

USER user

RUN rm -rf ~/.dotfiles && git clone https://github.com/tohosaku/dotfiles.git ~/.dotfiles && sh ~/.dotfiles/init.sh && \
    rm -rf ~/bin && mkdir ~/bin && cd ~/bin && \
    curl -LO https://github.com/arl/gitmux/releases/download/v0.7.10/gitmux_0.7.10_linux_amd64.tar.gz && tar zxvf gitmux_0.7.10_linux_amd64.tar.gz && \
    mkdir ~/.cache && \
    cd /workspace && \
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install --all && \
    bundle config set path '/usr/local/bundle'
