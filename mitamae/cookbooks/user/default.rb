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
