#   bundle config set path '/usr/local/bundle'

git '/home/user/.dotfiles' do
  repository 'https://github.com/tohosaku/dotfiles.git'
end

execute 'sh ~/.dotfiles/init.sh'

git '/home/user/.fzf' do
  repository 'https://github.com/junegunn/fzf.git'
  depth 1
end

execute '~/.fzf/install --all'

directory '/home/user/.cache'

directory '/home/user/bin'

GITMUX = 'https://github.com/arl/gitmux/releases/download/v0.7.10/gitmux_0.7.10_linux_amd64.tar.gz'

http_request '/home/user/bin/gitmux_0.7.10_linux_amd64.tar.gz' do
  url GITMUX
  block -> do
    cwd '/home/user/bin/'
    execute 'tar zxvf /home/user/bin/gitmux_0.7.10_linux_amd64.tar.gz'
  end
end
