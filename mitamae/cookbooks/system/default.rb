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

RIPGREP     = "ripgrep_#{node['ripgrep']['version']}_#{node['ripgrep']['arch']}.deb"
RIPGREP_URL = "https://github.com/BurntSushi/ripgrep/releases/download/#{node['ripgrep']['version']}/#{RIPGREP}"

http_request "/tmp/#{RIPGREP}" do
  url RIPGREP_URL
end

execute "dpkg -i /tmp/#{RIPGREP}"

GITMUX     = "gitmux_#{node['gitmux']['version']}_#{node['gitmux']['arch']}.tar.gz"
GITMUX_URL = "https://github.com/arl/gitmux/releases/download/v#{node['gitmux']['version']}/#{GITMUX}"

http_request "/usr/local/bin/#{GITMUX}" do
  url GITMUX_URL
end

execute "tar zxvf /usr/local/bin/#{GITMUX}" do
  cwd '/usr/local/bin'
end

execute 'apt-get clean && rm -rf /var/cache/apt/archives/* && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && truncate -s 0 /var/log/*log'
