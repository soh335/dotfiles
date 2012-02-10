TERM="xterm-color"

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh-history
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#キーバインドはvi
bindkey -v

#プロンプトの設定
local WHITE=$'%{\e[1;37m%}'
local DEFAULT=$'%{\e[1;m%}'

#http://d.hatena.ne.jp/mollifier/20090814/p1
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"'[%~]'

# this is local alias
alias ls='/bin/ls -GF'
alias ll='/bin/ls -FlshG'
alias lla='/bin/ls -FlashG'
alias alc='w3m "http://eow.alc.co.jp/function/UTF-8/?ref=sa" | less +37'
alias pad="plackup -MPlack::App::Directory -e 'Plack::App::Directory->new->to_app'"
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

#history
setopt hist_ignore_dups #重複を除く
setopt share_history #複数zshでhistoryをshare

# 履歴の検索を^N, ^pで出来るようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_cd

#cd -[tab]で過去のcdが見られるはずだが、見られない
setopt auto_pushd

#間違ってたら補正
setopt correct

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt append_history

# 補完候補を詰めて表示する
setopt list_packed 

# 補完候補表示時などにピッピとビープ音をならないように設定
setopt nolistbeep

function json_dump()
{
  php -r 'print_r(json_decode(file_get_contents($argv[1]), true));' $1
}

function title_screen()
{
  screen -X eval "title '$(basename $(pwd))'"
}

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

