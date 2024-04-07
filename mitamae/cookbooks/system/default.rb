packages = %w(
  gnupg
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
remote_file '/usr/local/bin/redmine.sh'
