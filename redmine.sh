#!/bin/bash

bin/bundle install

bin/rake db:create
bin/rake db:migrate
bin/rake redmine:plugins:migrate
