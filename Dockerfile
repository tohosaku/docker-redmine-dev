FROM debian:bullseye-slim

RUN apt-get update -qq && apt-get install -y gosu git screen vim dialog ruby build-essential postgresql-client build-essential libpq-dev ruby-dev \
                          imagemagick ghostscript \
                       && mkdir -p /usr/local/dotfiles
WORKDIR /usr/src/redmine

COPY entrypoint.sh redmine.sh /usr/local/bin/
COPY ./dotfiles /usr/local/dotfiles
RUN chmod +x /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/redmine.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
