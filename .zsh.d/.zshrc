##
# init export
##
export LANG=ja_JP.UTF-8
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH
export EDITOR='/usr/local/bin/emacs -nw -q -l ~/.emacs.d/.emacs.small'
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
alias emacs="/usr/local/bin/emacs -nw -l ~/.emacs.d/.emacs"
alias e=emacs
alias es="/usr/local/bin/emacs -nw -q -l ~/.emacs.d/.emacs.small"
alias f="fg"
alias fraise="open -a fraise"
alias fr=fraise
alias j="jobs"
alias bksc="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background"
alias dnscc="dscacheutil -flushcache"
alias ql='qlmanage -p "$@" >& /dev/null'
alias tree='tree -N'
alias t=tree
alias mkdir="mkdir -p"
alias beep="echo $'\a'"
alias say='say -v Victoria'
alias pc='pbcopy'
alias pv='pbpaste'

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
    local branch stash

    if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
        return
    fi

    branch=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
    if [[ -z $branch ]]; then
        return
    fi

    stash="`git stash list | awk -F':' '{print $1}' | tr '\n' ',' | sed 's/,$//g'`"
    if [[ -n $stash ]]; then
        stash=" %{\e[32m%}($stash)%{\e[00m%}"
    fi

    echo "%{\e[35m%}($branch)$stash%{\e[00m%} "
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

# for android
export PATH=$PATH:$HOME/android-sdk/platform-tools

# for perl, perlbrew
export MODULE_SETUP_DIR=~/perl5/.module-setup
export DBIC_TRACE=1
source ~/perl5/perlbrew/etc/bashrc
alias pb="perlbrew"
alias perlmodules="find `perl -e 'print\"@INC\"'` -name '*.pm' -print";

# for node
export PATH=$HOME/.nodebrew/current/bin:$PATH
export NODE_PATH=$HOME/.nodebrew/current/node_modules

# for ruby
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM

# include
[ -f $ZDOTDIR/.zshrc.local ] && source $ZDOTDIR/.zshrc.local
[ -f $ZDOTDIR/include/functions.zsh ] && source $ZDOTDIR/include/functions.zsh
