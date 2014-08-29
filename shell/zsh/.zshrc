#{{{ ZSH Modules
fpath=(~/.zsh/functions $fpath)
autoload -U colors compinit promptinit zcalc zsh-mime-setup
autoload -U ~/.zsh/functions/*(:t) # Autoload zsh functions.
colors
compinit
promptinit
zsh-mime-setup
#}}}

#{{{ Primary Functions
typeset -ga preexec_functions # Enable auto-execution of functions.
typeset -ga precmd_functions
typeset -ga chpwd_functions

preexec_functions+='preexec_update_git_vars' # Append git funcs for prompt.
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'
#}}}

#{{{ Changing Directories
setopt AUTO_CD                 # Non-command 'dir' translated into 'cd dir'.
setopt AUTO_PUSHD              # This makes cd=pushd, push old dir onto stack.
setopt PUSHD_IGNORE_DUPS       # Ignore multiple duplicate dirs on the stack.
setopt PUSHD_MINUS             # Exchange meaning of '+' and '-' during ops.
#setopt PUSHD_SILENT           # Do not print dir stack after pushd/popd.
setopt PUSHD_TO_HOME           # Blank pushd goes to home directory.
#}}}
#{{{ Completion
setopt AUTO_LIST               # List choices on an ambiguous completion.
setopt AUTO_MENU               # Use menu completion after the 2nd request.
setopt AUTO_NAME_DIRS          # Use named dirs when possible.
setopt COMPLETE_IN_WORD        # Tab completion from both ends.
setopt GLOB_COMPLETE           # Expand globs for completion.
unsetopt LIST_AMBIGUOUS        # Completion handled explicitly (below).
#}}}
#{{{ Expansion & Globbing
setopt EXTENDED_GLOB           # Treat #, ~, ^ as part of filename gen patterns.
setopt NO_CASE_GLOB            # Case insensitive globbing of filenames.
setopt NUMERIC_GLOB_SORT       # Sort filenames numerically if necessary.
setopt RC_EXPAND_PARAM         # Support array expansion.
#}}}
#{{{ History
setopt APPEND_HISTORY          # All zsh sessions append.
setopt EXTENDED_HISTORY        # Save timestamp and duration.
setopt HIST_EXPIRE_DUPS_FIRST  # Expire oldest duplicates first.
setopt HIST_FIND_NO_DUPS       # Do not display dups during search.
setopt HIST_IGNORE_ALL_DUPS    # Save only last of duplicate commands.
setopt HIST_IGNORE_DUPS        # Do not save history of consecutive dups.
setopt HIST_IGNORE_SPACE       # Do not save commands that start with a space.
setopt HIST_NO_STORE           # Remove history command from history.
setopt HIST_REDUCE_BLANKS      # Remove extra blanks from each command line.
setopt HIST_SAVE_NO_DUPS       # Do not save older dups when writing history.
setopt HIST_VERIFY             # Show the expanded history before executing it.
#setopt INC_APPEND_HISTORY     # Add commands as soon as they are entered.
setopt SHARE_HISTORY           # Share history across multiple shells.
#}}}
#{{{ Input/Output
setopt NO_CLOBBER              # Do not allow > to truncate existing files.
setopt RM_STAR_WAIT            # 10 second waiting period if rm * is invoked.
#}}}
#{{{ Scripts & Functions
setopt MULTIOS                 # Implicit tees/cats during multiple redirections.
#}}}
#{{{ ZLE
setopt ZLE                     # Use magic (default).
setopt NO_BEEP                 # No beeps on error in ZLE.
#}}}
#{{{ Prompting
setopt PROMPT_SUBST            # Parameter expansion, command substitution and
                               # arithmetic expansion are performed in prompts.
#}}}

#{{{ Variables
declare -U path
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export EDITOR=vim
export SHELL=/bin/zsh
export SVN_SSH=/usr/bin/ssh
export PATH=/opt/local/bin:/opt/local/sbin:$HOME/bin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
export TERM=rxvt               # Fix all terminal bugs
export MAILCHECK=0             # Disable mail checking
#}}}

#{{{ Aliases
alias sz='source ~/.zshrc'
alias ez='vi ~/.zshrc'
alias grep="grep --color=auto"
alias mk=popd
alias cp='cp -i'
alias mv='mv -i'
alias la='ls -Al'              # Show hidden files.
alias ls='ls -hF --color=auto' # Add colors for filetype recognition.
alias lx='ls -lXB'             # Sort by extension.
alias lk='ls -lSr'             # Sort by size.
alias lc='ls -lcr'             # Sort by change time.
alias lu='ls -lur'             # Sort by access time.
alias lr='ls -lR'              # Recursive ls.
alias lt='ls -ltr'             # Sort by date.
alias tree='tree -AC' #-Csu'   # Directory/file tree.
# Copy with a progress bar
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
alias '..'='cd ..'
alias -g '...'='../..'
alias -g '....'='../../..'
alias -g '.....'='../../../..'
alias -g G="| grep"
alias -g L="| less"
#}}}

#{{{ Completion
bindkey -M viins '\C-i' complete-word
LISTMAX=40 # automatically decide when to page a list of completions
zstyle ':completion::complete:*' use-cache 1                   # Faster with cache.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'            # Case insensitive completion.
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
#zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete
zstyle ':completion:*' completer _expand _force_rehash _complete _approximate _ignored
# adds remote hostnames for 'ssh' and other network commands to the autocomplete suggestions, based on the contents of your ~/.ssh/known_hosts lists
zstyle -e ':completion::*:hosts' hosts 'reply=($(sed -e "/^#/d" -e "s/ .*\$//" -e "s/,/ /g" /etc/ssh_known_hosts(N) ~/.ssh/known_hosts(N) 2>/dev/null | xargs) $(grep \^Host ~/.ssh/config(N) | cut -f2 -d\  2>/dev/null | xargs))'
zstyle ':completion:*' auto-description 'specify: %d'          # Generate descriptions with magic.
zstyle ':completion:*:default' list-prompt '%S%M matches%s'    # Don't prompt for a huge list, page it.
zstyle ':completion:*:default' menu 'select=0'                 # Don't prompt for a huge list, menu it.
zstyle ':completion:*' file-sort modification reverse          # Have the newer files last so seen first.
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"    # Color code completion.
zstyle ':completion:*:manuals' separate-sections true          # Separate man page sections.
zstyle ':completion:*:windows' menu on=0                       # Complete with a menu for xwindow ids.
zstyle ':completion:*:expand:*' tag-order all-expansions
# more errors allowed for large words and fewer for small words
zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b' # Errors format.
zstyle ':completion::*:(rm|vi):*' ignore-line true             # Don't complete stuff already on the line.
zstyle ':completion:*' ignore-parents parent pwd               # Don't complete directory we are already in.
zstyle ':completion::approximate*:*' prefix-needed false
#}}}

#{{{ Key Bindings
bindkey -v
bindkey '\e[1~' beginning-of-line # Make home work.
bindkey '\e[4~' end-of-line       # Make end work.
bindkey -M vicmd "/" history-incremental-search-backward # Incremental search.
bindkey -M vicmd "?" history-incremental-search-forward
bindkey -M vicmd "//" history-beginning-search-backward  # Historical search.
bindkey -M vicmd "??" history-beginning-search-forward
bindkey "\eOP" run-help
bindkey '\e[3~' delete-char # Rebind the delete key.
bindkey '' beginning-of-line
bindkey '' end-of-line
bindkey \C-R history-incremental-search-backward
bindkey '' history-incremental-search-backward
#}}}

#{{{ History
HISTFILE=~/.history
SAVEHIST=10000
HISTSIZE=10000
#}}}

zle -N edit-command-output

#{{{ Prompt Appearance
for COLOR in RED GREEN YELLOW WHITE BLACK CYAN BLUE; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'         
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done                                                 
PR_RESET="%{${reset_color}%}";
PROMPT='[${PR_RESET}${PR_GREEN}%t${PR_RESET} %U%n@%m%u ${PR_BLUE}%2d${PR_RESET}]$(prompt_git_info) ${PR_RESET}$ '
#PROMPT='[${PR_RESET}${PR_GREEN}%t${PR_RESET} %U%m%u ${PR_BLUE}%3d${PR_RESET}]   '
#RPROMPT='$(prompt_git_info)'
# Single quotes above are necessary for git info to function correctly.
#}}}
#RPROMPT='[${PR_BLUE}%d${PR_RESET}]'

#{{{ Shell Title
function preexec () { # Special symbol that is auto-run after a command is entered.
    if [ -s "$STY" ]; then
        echo -ne "\ek${1%% *}\e\\"
    fi
}
#function title () { # Explicit function to have the title auto-set.
#    command echo -n "]2;$1"
#}
function title {
    if [[ $TERM == "screen" ]]; then
        # Use these two for GNU Screen:
        print -nR $'\033k'$1$'\033'\\

        print -nR $'\033]0;'$2$'\a'
    elif [[ $TERM == "xterm" || $TERM == "rxvt" ]]; then
        # Use this one instead for XTerms:
        print -nR $'\033]0;'$*$'\a'
    fi
}
function precmd {
  title zsh "$PWD"
}
function preexec {
  emulate -L zsh
  local -a cmd; cmd=(${(z)1})
  title $cmd[1]:t "$cmd[2,-1]"
}

#}}}

#{{{ Miscellaneous Functions
function _force_rehash () {
    (( CURRENT == 1 )) && rehash
    return 1  # Because we didn't really complete anything.
}

function edit-command-output () {
    BUFFER=$(eval $BUFFER)
    CURSOR=0
}

function my_ip () # get IP adresses
{
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
    MY_ISP=$(/sbin/ifconfig eth0 | awk '/P-t-P/ { print $3 } ' | sed -e s/P-t-P://)
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
    echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:-"Not connected"}
}

function ii ()   # get current host related info
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    my_ip 2>&- ;
    echo
}

function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)    tar xjvf $1      ;;
            *.tar.gz)     tar xzvf $1      ;;
            *.bz2)        bunzip2 $1       ;;
            *.rar)        rar x $1         ;;
            *.gz)         gunzip $1        ;;
            *.tar)        tar xf $1        ;;
            *.tbz2)       tar xjf $1       ;;
            *.tgz)        tar xzf $1       ;;
            *.zip)        unzip $1         ;;
            *.Z)          uncompress $1    ;;
            *)            echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
#}}}

### See the man page for full details:
### $ man zshoptions
