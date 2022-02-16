# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
source $ZSH/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $ZSH/plugins/vi-mode/vi-mode.plugin.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Aliases
alias ls="exa -aG"
alias sl="ls"
alias ll="exa -lG"
alias lstree="exa -T"
alias ..="cd .."
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias c="clear"
alias o="open "$@""
alias grep="grep -i --color=always"
alias dl="cd ~/Downloads && ls"
alias dev="cd ~/Dev/; zranger" #The zranger extension allow to switch between ranger and command line by pressing ⌥ + Z and move between directories that way
alias dojo="cd ~/Dev/dojo; zranger"
alias work="cd ~/Work; zranger"
alias bc="bc -l" #bc calculator with floating point
alias airpods="BluetoothConnector -c FF-FF-FF-FF-FF-FF --notify" #Replace FF-FF-... with your aipods MAC address
alias jarvissh="ssh jarvis@192.168.0.52" #This is my home server
alias battery="pmset -g batt"
alias menu="cat ~/.config/menu" #Basic menu of my utilities so i don't forget them
alias temperature="sudo powermetrics --samplers smc"
alias gitlocal="git log origin/main..HEAD"
alias oc="cd ~/Dev/OC; ranger"
alias mediasmb="mkdir /tmp/smb &&
mkdir /tmp/smb/hdd{1..3} &&
mount_smbfs -N //guest@192.168.0.254/hdd1 /tmp/smb/hdd1/ &&
mount_smbfs -N //guest:@192.168.0.254/hdd2 /tmp/smb/hdd2/ &&
mount_smbfs -N //guest@192.168.0.254/hdd3 /tmp/smb/hdd3/" #My home media NAS hdds
alias hdds="cd /tmp/smb/hdd2" #Series HDD
alias rm="trash "$@"" #Allow to rm files to the trash of macOS instead of a direct delete
alias tmp='mkdir tmp && cd "$_"' #Create tmp file and cd inside it.
alias fh='history | fzf' #Best way to interact with history
alias icloud='cd "/Users/ezirel/Library/Mobile Documents/com~apple~CloudDocs"'
alias td='termdown' #Stopwatch give it time argument to countdown

# Applications shortcuts

alias omni="o /Applications/OmniFocus.app"
alias chrome="o -a /Applications/Google\ Chrome.app"
alias safari="o -a /Applications/Safari.app"
alias ff="o /Applications/Firefox.app"
alias mess="o /Applications/Messages.app"
alias pages="o /Applications/Pages.app"
alias numbers="o /Applications/Numbers.app"
alias calendar="o /Applications/Calendar.app"
alias notes="ranger ~/Dev/notes/pad"
alias gpg="gpg2"
alias mutt="neomutt"
alias jailbreak="o ~/Documents/iphone/checkra1n.app"
alias zsh_profile="vi ~/.zshrc"
alias pirate="pirate-get" #PirateBay CLI Interface
alias wac="/Users/ezirel/Library/Python/3.9/bin/./wal -n -i Pictures/Desktop" #Unused script, convert terminal profile colors to the palette of wallpaper, buggy for now
alias rtwitter="source ~/Dev/cli_app/twitter/venv/bin/activate; rainbowstream" #Command line twitter
alias wiki="vim ~/.config/vimwiki/index.md" 
alias cheat="nocorrect cheat"

##Dotfile git manager
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' #Git bare repo alias

# Googler custom searches
alias googler="ddgr" #Cli quick googler search
alias @g='googler -x -n 4 $@'
alias @w='googler -x -n 4 -w en.wikipedia.org $@'
alias @rd='googler -x -n 4 --url-handler ttrv -w reddit.com "$@"'
alias @y='googler -r "us-en" -n 4 --url-handler mpv -w youtube.com "$@"'
alias @git='googler -n 4 -w github.com $@'
alias @so='so $@'

# Noter function #

noter() {
	vim + "$(date +"%y-%m-%d %H:%M" | while read d t ;
		do f=$HOME/Dev/notes/pad/$d ;
		( echo; echo $t ; echo ) >> "$f" ;
		echo "$f";
		done; )" ;
}

# Ranger nesting preventer #

ranger() {
	if [ -z "$RANGER_LEVEL" ]; then
		/usr/local/bin/ranger "$@"
	else
		exit
	fi
}

# Print current working directory of PID given as args #

function pwdx {
  lsof -a -p $1 -d cwd -n | tail -1 | awk '{print $NF}'
}

#Archive auto extractor
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1;;
           *.tar.gz)    tar xvzf $1;;
           *.bz2)       bunzip2 $1 ;;
           *.rar)       unrar x $1 ;;
           *.gz)        gunzip $1  ;;
           *.tar)       tar xvf $1 ;;
           *.tbz2)      tar xvjf $1;;
           *.tgz)       tar xvzf $1;;
           *.zip)       unzip $1   ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1;;
           *) echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

#Busy, a joke to friends
alias busy="cat /dev/urandom | hexdump -C | grep 'ca fe'"

#Iterm color profile change
it2prof() { echo -e "\033]50;SetProfile=$1\a"; }
alias itr="it2prof `echo $ITERM_PROFILE`"

#Title tab from command line, change tab name
function title {
    echo -ne "\033]0;"$*"\007"
}

#Taskwarrior utilities 
alias to="taskopen "$@"" #Open file of task number sent as args
alias @t="dl;tasksh"
alias questmap="twdeps -f png > ~/Downloads/questMap.png" #Product a png sort of Questmap, of where you are now in your project, like the quest journal in the witcher ?
alias tws="timew summary :ids :annotations"
alias twsw="timew summary :week :ids :annotations"
alias twsm="timew summary :month :ids :annotations"
alias twsy="timew summary :year :ids :annotations"

#Media function Initialize and mount my medias hdd
function media {
	mediasmb 2>/dev/null
	cd /tmp/smb/
}
alias rpv="mpv */* --shuffle"

#Tmux new session
function tat {
  name=$(basename `pwd` | sed -e 's/\.//g')

  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"
ZLE_RPROMPT_INDENT=0
# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
#COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=1000
SAVEHIST=1000
HISTFILE="$HOME/.zsh_history"
# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=${ZSH}/custom/
# Options sections
setopt AUTO_CD
setopt CORRECT
setopt CORRECT_ALL
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# User configuration
plugins=(auto-ls\
	auto-color-ls\
	autojump\
	brew\
	colorize\
	colored-man-pages\
	git\
	zsh-interactive-cd\
	ripgrep\
	macos\
	otp\
	jsontools\
	pass\
	taskwarrior\
	timewarrior\
	iterm2\
	vscode\
	npm\
	pod\
	zsh-autosuggestions
)

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.

# Completion settings
#case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix  

# Brew completion settings
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

#Zranger settings
autoload -U zranger
bindkey -s 'Â' "zranger\n"

#ZSH Autocomplete settings

zstyle ':autocomplete:*' default-context ''
# '': Start each new command line with normal autocompletion.
# history-incremental-search-backward: Start in live history search mode.
zstyle ':autocomplete:*' min-delay 0.25  # float
# Wait this many seconds for typing to stop, before showing completions.
zstyle ':autocomplete:*' min-input 3  # int
# Wait until this many characters have been typed, before showing completions.

zstyle ':autocomplete:*' list-lines 10  # int
# If there are fewer than this many lines below the prompt, move the prompt up
# to make room for showing this many lines of completions (approximately).

zstyle ':autocomplete:history-search:*' list-lines 15  # int
# Show this many history lines when pressing ↑.

zstyle ':autocomplete:history-incremental-search-*:*' list-lines 15  # int
# Show this many history lines when pressing ⌃R or ⌃S.

zstyle ':autocomplete:*' recent-dirs no
# cdr:  Use Zsh's `cdr` function to show recent directories as completions.
# no:   Don't show recent directories.
# zsh-z|zoxide|z.lua|z.sh|autojump|fasd: Use this instead (if installed).
# ⚠️ NOTE: This setting can NOT be changed at runtime.

# yes: Tab first inserts a substring common to all listed completions, if any.

zstyle ':autocomplete:*' widget-style menu-select
# complete-word: (Shift-)Tab inserts the top (bottom) completion.
# menu-complete: Press again to cycle to next (previous) completion.
# menu-select:   Same as `menu-complete`, but updates selection in menu.
# ⚠️ NOTE: This setting can NOT be changed at runtime.

zstyle ':autocomplete:*' fzf-completion yes
# no:  Tab uses Zsh's completion system only.
# yes: Tab first tries Fzf's completion, then falls back to Zsh's.
# ⚠️ NOTE: This setting can NOT be changed at runtime and requires that you
# have installed Fzf's shell extensions.

# Add a space after these completions:
zstyle ':autocomplete:*' add-space \
    executables aliases functions builtins reserved-words commands


# Up arrow:
bindkey '\e[A' up-line-or-search
bindkey '\eOA' up-line-or-search
# up-line-or-search:  Open history menu.
# up-line-or-history: Cycle to previous history line.

# Down arrow:
bindkey '\e[B' down-line-or-select
bindkey '\eOB' down-line-or-select
# down-line-or-select:  Open completion menu.
# down-line-or-history: Cycle to next history line.

# Control-Space:
bindkey '\0' list-expand
# list-expand:      Reveal hidden completions.
# set-mark-command: Activate text selection.

# Uncomment the following lines to disable live history search:
# zle -A {.,}history-incremental-search-forward
# zle -A {.,}history-incremental-search-backward

# Return key in completion menu & history menu:
bindkey -M menuselect '\r' accept-line
bindkey '‹' vi-forward-word
# .accept-line: Accept command line.
# accept-line:  Accept selection and exit menu


export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;35m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

#Measure shell load time
timezsh() {
	shell=${1-$SHELL}
	for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

