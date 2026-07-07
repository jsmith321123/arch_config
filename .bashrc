# .bashrc
export PS1="\\[\e[1m\e[36m\\]\u\\[\e[0m\e[1m\e[39m\\]@\\[\e[32m\\]\h \\[\e[39m\\]\$\\[\e[0m\\] "


# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

alias v.="nvim ."
alias v="nvim"
alias vim="nvim"

alias tn="tmux new -s"

export FONTAWESOME_PACKAGE_TOKEN="9716F9F6-CA0D-4BE1-99D6-595F9B8501C8"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools


eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

# Update terminal title to user@host: pwd
set_terminal_title() {
  # %n = username, %m = short hostname, %~ = current directory (with ~ for home)
  print -Pn "\e]2;%n@%m: %~\a"
}
# Update terminal title to user@host: pwd
set_terminal_title() {
  # \u = username, \h = short hostname, \w = current directory (with ~ for home)
  echo -ne "\e]2;\u@\h: \w\a"
}
