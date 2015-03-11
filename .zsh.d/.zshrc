##
# init export
##
export LANG=ja_JP.UTF-8
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH
#export EDITOR='/usr/local/bin/emacs -nw'
export EDITOR=emacs
export LESSHISTFILE=$HOME/tmp/.lesshst
export GDBHISTFILE=$HOME/tmp/.gdb_history
export MYSQL_HISTFILE=$HOME/tmp/.mysql_history


##
# set zsh options
##
autoload -U compinit
compinit -d $HOME/tmp/.zsh.$USER.zcompdump
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# setopt
setopt no_beep
setopt nolistbeep
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
setopt correct

# set colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=2

# etc
bindkey -e
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


##
# history
##
HISTFILE=$HOME/tmp/.zsh.history       # 履歴をファイルに保存する
HISTSIZE=10000                        # メモリ内の履歴の数
SAVEHIST=10000                        # 保存される履歴の数
setopt hist_ignore_dups               # 重複を除く
setopt hist_ignore_space              # 先頭にスペースを入れると履歴に残らない
setopt extended_history               # 履歴ファイルに時刻を記録
function history-all { history -E 1 } # 全履歴の一覧を出力


##
# ターミナルのタイトル
##
case $TERM in
    kterm*|xterm)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST}\007"
        }
        ;;
esac


##
# set alias
##
alias ll="ls -laFG"
alias l=ll
alias less='less -R'
alias lll="ls -laFG | less"
alias llh="ls -laFGh"
alias rm="rm -i"
alias mv="mv -i"
alias grep="grep --color"
alias ducks="du -cks * | sort -rn"
alias dt="cd ~/Desktop"
alias g=git
alias gst='git st && git stash list'
alias gsr='git svn rebase'
alias gsta='git stash'
alias gstap='git stash pop'
alias gh='hub'
alias emacs="/usr/local/bin/emacs -nw -l ~/.emacs.d/init.el"
alias e=emacs
alias es="/usr/local/bin/emacs -nw -l ~/.emacs.d/init.el"
alias f="fg"
alias fraise="open -a fraise"
alias fr=fraise
alias textmate="open -a TextMate"
alias tm=textmate
alias mou="open -a Mou"
alias j="jobs"
alias bksc="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background"
alias dnscc="dscacheutil -flushcache"
alias ql='qlmanage -p "$@" >& /dev/null'
alias tree='tree -N -F'
alias t=tree
alias top=htop
alias df=dfc
alias mkdir="mkdir -p"
alias beep="echo $'\a'"
alias say='say -v Victoria'
alias sayj='say -v Kyoko'
alias pc='pbcopy'
alias pv='pbpaste'
alias b='brew'
alias pb='phpbrew'
alias s='svn'
alias r='rails'
alias diff='colordiff'
alias notifon='launchctl load -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist; terminal-notifier -message 通知設定をonにしました'
alias notifoff='terminal-notifier -message 通知設定をoffにしました; sleep 2; launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist'
alias vagrant='/usr/bin/vagrant'
alias be='bundle exec'
alias relogin='exec $SHELL -l'

alias -g ....="../.."
alias -g ......="../../.."
alias -g G='| grep'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g S='| sort'
alias -g W='| wc'
alias -g X='| xargs'


##
# set prompt
##
function git-prompt {
    local repo branch stash

#    if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
#        return
#    fi

    repo="`git config --get remote.origin.url | cut -d":" -f2 | cut -d "." -f1 2> /dev/null`"
    if [[ -n $repo ]]; then
        repo="$repo"
    fi

    branch=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
    if [[ -z $branch ]]; then
	echo $branch
        return
    fi

    stash="`git stash list | awk -F':' '{print $1}' | wc -l | tr -d ' '`"
#    stash="`git stash list | awk -F':' '{print $1}' | tr '\n' ',' | sed 's/,$//g'`"
    if [[ -n $stash ]]; then
        stash="%{\e[32m%}[stash:$stash]%{\e[00m%}"
    fi

    echo "%{\e[35m%}($branch@$repo)$stash%{\e[00m%} "
}

setopt prompt_subst # プロンプト文字列の再評価

if [ "$EMACS" ]; then;
    stty -echo nl
    PROMPT="%/
%n@emacs%% "
else
    PROMPT=$'`git-prompt`%{\e[33m%}%~%{\e[00m%}
%{\e[36m%}[%D{%Y/%m/%d %H:%M:%S}] %n$%{\e[00m%} '
    RPROMPT=""
fi

## for z
#. `brew --prefix`/etc/profile.d/z.sh
#function precmd () {
#   z --add "$(pwd -P)"
#}

# for android
#export PATH=$PATH:$HOME/android-sdk/platform-tools

# for perl, perlbrew
#export MODULE_SETUP_DIR=~/perl5/.module-setup
#export DBIC_TRACE=1
#source ~/perl5/perlbrew/etc/bashrc
#alias pb="perlbrew"
#alias perlmodules="find `perl -e 'print\"@INC\"'` -name '*.pm' -print";

## for node
#export PATH=$HOME/.nodebrew/current/bin:$PATH
#export NODE_PATH=$HOME/.nodebrew/current/node_modules

# for ruby
#export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM
export NOKOGIRI_USE_SYSTEM_LIBRARIES=1
export MAKEOPTS="-j2"
eval "$(rbenv init - zsh)"

# for go-lang
export GOPATH=~/go
export PATH=$GOPATH/bin:$PATH

# include
[ -f $ZDOTDIR/.zshrc.local ] && source $ZDOTDIR/.zshrc.local
[ -f $ZDOTDIR/include/functions.zsh ] && source $ZDOTDIR/include/functions.zsh

# for anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

eval "$(direnv hook $0)"
export DIRENV_RUBY=/usr/bin/ruby

## ^r でのコマンドヒストリにpecoを使う
function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(\history -n 1 | \
    eval $tac | \
    peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
