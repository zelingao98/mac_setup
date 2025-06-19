# Mac_Setup
Setup Guidance for New Macbook

## Setup .zshrc
replace ``.zshrc``

## Setup homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Setup maple-mono font
download link: https://github.com/subframe7536/maple-font/releases

## Setup oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
copy my own theme ``zelin.zsh-theme`` into folder ``/Users/jamesgzl/.oh-my-zsh/themes/``

## Setup oh-my-tmux
```bash
git clone --single-branch https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
```

## Setup uv
```
# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh
# test cmd
uv venv uv_tutor --python 3.11
source uv_tutor/bin/activate
uv pip install torch torchvision
python -c "import torch; print(torch.__version__)"
```