FROM debian:bullseye-slim
RUN apt-get update -qq && apt-get install -y git tig screen vim dialog ruby build-essential postgresql-client build-essential libpq-dev ruby-dev \
                          imagemagick ghostscript \
                       && mkdir -p /usr/local/dotfiles
WORKDIR /usr/src/redmine

COPY redmine.sh /usr/local/bin/
COPY ./dotfiles /usr/local/dotfiles
RUN chmod +x /usr/local/bin/redmine.sh
ENV GEM_HOME=/usr/local/bundle
ENV BUNDLE_APP_CONFIG=/usr/local/bundle
ARG LOCAL_UID
RUN useradd -u $LOCAL_UID -m user
USER user
