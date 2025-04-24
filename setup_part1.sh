#!/bin/bash

set -x

current_dir=$(pwd)

# zsh
sudo apt install -y bat zsh ripgrep build-essential
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-bat
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

cp ${current_dir}/zsh_custom ${HOME}/.zshrc

exec zsh
p10k configure

tmp_dir=${current_dir}/tmp
mkdir ${tmp_dir}
cd ${tmp_dir}

# nvim
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage -P ${tmp_dir}
chmod u+x ${tmp_dir}/nvim-linux-x86_64.appimage
${tmp_dir}/nvim-linux-x86_64.appimage --appimage-extract
rsync -av --remove-source-files ${tmp_dir}/squashfs-root/usr/* ~/.local

# nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
source ${HOME}/.zshrc
nvm install --lts

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# clean up
cd ${current_dir}
rm -rf ${tmp_dir}

echo "done"
