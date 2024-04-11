packages = %w(
  file
  curl
  git
  tig
  tmux
  vim
  dialog
  build-essential
  postgresql-client
  libpq-dev
  imagemagick
  ghostscript
  universal-ctags
)

execute 'update apt index' do
  command 'apt-get update -qq'
end

packages.each do |pkg|
  package pkg
end

remote_file '/etc/ImageMagick-6/policy.xml'
remote_file '/usr/local/bin/redmine.sh' do
  mode '755'
end

u = node['user']

group u.name do
  gid u.gid
end

user u.name do
  uid u.uid
  gid u.gid
  home "/home/#{u.name}"
  shell '/bin/bash'
end

directory "/home/#{u.name}" do
  owner u.name
  mode '755'
end

RIPGREP = 'https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb'

http_request '/tmp/ripgrep_13.0.0_amd64.deb' do
  url RIPGREP
end

execute 'dpkg -i /tmp/ripgrep_13.0.0_amd64.deb'

GITMUX = 'https://github.com/arl/gitmux/releases/download/v0.7.10/gitmux_0.7.10_linux_amd64.tar.gz'

http_request '/usr/local/bin/gitmux_0.7.10_linux_amd64.tar.gz' do
  url GITMUX
end

execute 'tar zxvf /usr/local/bin/gitmux_0.7.10_linux_amd64.tar.gz' do
  cwd '/usr/local/bin'
end

execute 'apt-get clean && rm -rf /var/cache/apt/archives/* && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && truncate -s 0 /var/log/*log'
