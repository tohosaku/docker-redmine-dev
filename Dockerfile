FROM ruby:3.3.0-slim-bookworm

ADD https://github.com/itamae-kitchen/mitamae/releases/download/v1.14.1/mitamae-x86_64-linux /usr/local/bin/mitamae
RUN chmod +x /usr/local/bin/mitamae

COPY ./mitamae /usr/local/share/mitamae
RUN /usr/local/bin/mitamae local -y /usr/local/share/mitamae/node.yml /usr/local/share/mitamae/cookbooks/system/default.rb

WORKDIR /workspace

ENV LANG=C.UTF-8

USER user

RUN /usr/local/bin/mitamae local /usr/local/share/mitamae/cookbooks/user/default.rb
