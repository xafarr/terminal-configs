# Git bash for windows powerline theme
#
# Licensed under MIT
# Based on https://github.com/Bash-it/bash-it and https://github.com/Bash-it/bash-it/tree/master/themes/powerline
# Some ideas from https://github.com/speedenator/agnoster-bash
# Git code based on https://github.com/joeytwiddle/git-aware-prompt/blob/master/prompt.sh
# More info about color codes in https://en.wikipedia.org/wiki/ANSI_escape_code

PROMPT_CHAR=" "
POWERLINE_PROMPT="os_symbol cwd scm"

USER_INFO_SSH_CHAR=" "
DOT_CHAR="·"
USER_INFO_PROMPT_COLOR="- C"
OS_SYMBOL_PROMPT_COLOR="- C"

SCM_GIT_CHAR=" "
SCM_BRANCH_COLOR="- G"

CWD_PROMPT_COLOR="- B"

function __color {
    local bg
    local fg
    local mod
    case $1 in
    'Bl') bg=40 ;;
    'R') bg=41 ;;
    'G') bg=42 ;;
    'Y') bg=43 ;;
    'B') bg=44 ;;
    'M') bg=45 ;;
    'C') bg=46 ;;
    'W') bg=47 ;;
    *) bg=49 ;;
    esac

    case $2 in
    'Bl') fg=30 ;;
    'R') fg=31 ;;
    'G') fg=32 ;;
    'Y') fg=33 ;;
    'B') fg=34 ;;
    'M') fg=35 ;;
    'C') fg=36 ;;
    'W') fg=37 ;;
    *) fg=39 ;;
    esac

    case $3 in
    'B') mod=1 ;;
    *) mod=0 ;;
    esac

    # Control codes enclosed in \[\] to not polute PS1
    # See http://unix.stackexchange.com/questions/71007/how-to-customize-ps1-properly
    echo "\[\e[${mod};${fg};${bg}m\]"
}

function __powerline_os_symbol_prompt {
    local windows=" "
    local color=${OS_SYMBOL_PROMPT_COLOR}
    echo "$windows|${color}"
}

function __powerline_user_info_prompt {
    local user_info=""
    local user
    user=$(whoami)
    local host
    host=$(hostname)
    if [[ -n "${SSH_CLIENT}" ]]; then
        user_info="${USER_INFO_SSH_CHAR}$user@$host"
    else
        user_info="$user@$host"
    fi
    echo -n "${user_info}|${USER_INFO_PROMPT_COLOR}"
}

function __powerline_cwd_prompt {
    dir=$(pwd | sed "s|^$HOME|~|")
    echo -n "$dir|${CWD_PROMPT_COLOR}"
}

function __powerline_scm_prompt {
    # Fast exit if not in Git repo
    [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) != "true" ]] && return

    local git_dir branch tracking_branch
    local -i ahead=0 behind=0 stashed=0
    local -A counts=([staged]=0 [unstaged]=0 [untracked]=0 [conflicts]=0 [deleted]=0 [renamed]=0)
    local status_lines

    IFS=$'\n' read -rd '' status_lines <<<"$(git status --porcelain -b --ignored 2>/dev/null)"

    # Parse status output in single pass
    while IFS= read -r line; do
        # Branch and tracking info
        if [[ ${line:0:2} == "##" ]]; then
            branch="${line#* }"
            branch="${branch%%...*}"
            if [[ ${branch} == *"HEAD (no branch)"* ]]; then
                branch="HEAD ($(git rev-parse --short HEAD))"
            fi
            tracking_branch="${line#*...}"
            tracking_branch="${tracking_branch%% *}"
            # try to match ahead N
            [[ $line =~ ahead[[:space:]]([0-9]+) ]] && ahead=${BASH_REMATCH[1]}
            # try to match behind N
            [[ $line =~ behind[[:space:]]([0-9]+) ]] && behind=${BASH_REMATCH[1]}
            continue
        fi

        # File status parsing with improved pattern matching
        prefix=${line:0:2}
        case "$prefix" in
        "##") continue ;;
        "??") ((counts[untracked]++)) ;;                  # Untracked files
        "!!") ;;                                          # Ignored files (skip)
        U? | ?U | "AA" | "DD") ((counts[conflicts]++)) ;; # Merge conflicts
        R?) ((counts[renamed]++)) ;;                      # Renamed files
        ?D | D?) ((counts[deleted]++)) ;;                 # Deleted files
        *)
            # Staged changes (except deletions/renames)
            [[ "${line:0:1}" =~ [ACDMR] ]] && ((counts[staged]++))
            # Unstaged changes
            [[ "${line:1:1}" =~ [ACDMR] ]] && ((counts[unstaged]++))
            ;;
        esac
    done <<<"$status_lines"

    [[ -f "$(git rev-parse --git-dir)/refs/stash" ]] &&
        stashed=$(git rev-list --walk-reflogs --ignore-missing --count refs/stash)

    # Special state detection
    local state_symbols=()
    git_dir="$(git rev-parse --git-dir)"
    [[ -d "$git_dir/rebase-merge" || -d "$git_dir/rebase-apply" ]] && state_symbols+=(↦REBASING)
    [[ -f "$git_dir/CHERRY_PICK_HEAD" ]] && state_symbols+=(🍒CHERRY-PICKING)
    [[ -f "$git_dir/MERGE_HEAD" ]] && state_symbols+=( MERGING)
    [[ -f "$git_dir/BISECT_LOG" ]] && state_symbols+=(󰃻 BISECTING)
    [[ -f "$git_dir/REVERT_HEAD" ]] && state_symbols+=(↻REVERTING)

    # Build status string
    local status=""
    [[ ${counts[unstaged]} -gt 0 ]] && status+=" $(__color - Y)!${counts[unstaged]}"
    [[ ${counts[staged]} -gt 0 ]] && status+=" $(__color - Y)+${counts[staged]}"
    [[ ${counts[untracked]} -gt 0 ]] && status+=" $(__color - B)?${counts[untracked]}"
    [[ ${counts[deleted]} -gt 0 ]] && status+=" $(__color - R)-${counts[deleted]}"
    [[ ${counts[renamed]} -gt 0 ]] && status+=" $(__color - B)→${counts[renamed]}"
    [[ ${counts[conflicts]} -gt 0 ]] && status+=" $(__color - M)✗${counts[conflicts]}"
    [[ $ahead -gt 0 ]] && status+=" $(__color - G)⇡$ahead"
    [[ $behind -gt 0 ]] && status+=" $(__color - G)⇣$behind"
    [[ $stashed -gt 0 ]] && status+=" $(__color - G)󰀼 $stashed"

    # Add state symbols to branch name
    [[ ${#state_symbols[@]} -gt 0 ]] && branch="${branch} $(__color - Y)${state_symbols[*]}"

    echo -n "${SCM_GIT_CHAR}$branch$status|${SCM_BRANCH_COLOR}"
}

function __get_segment_with_color {
    local OLD_IFS="${IFS}"
    IFS="|"
    local params=($1)
    IFS="${OLD_IFS}"
    local styles=(${params[1]})
    styles=(${params[1]})
    echo -n " $(__color ${styles[@]})${params[0]}$(__color)"
}

function __powerline_left_segment {
    LEFT_PROMPT+="$(__get_segment_with_color "$1")"
}

function __powerline_last_status_prompt {
    local symbol="${PROMPT_CHAR} "
    local last_status=$1
    local color="- G B"
    if [[ "$last_status" -ne 0 ]]; then
        color="- R B"
    fi
    echo -n "$symbol|$color"
}
#
# Function to strip ANSI control codes for accurate length calculation
function __strip_ansi {
    echo -e "$1" | sed -r 's/\x1B\[[0-9;]*[a-zA-Z]//g;s/\\\[|\\\]//g'
}

function __dot_separator {
    local left_plain
    local right_plain

    left_plain=$(__strip_ansi "${1}")
    right_plain=$(__strip_ansi "${2}")

    # Calculate lengths
    local cols
    cols=$(tput cols)
    local gap=$((cols - ${#left_plain} - ${#right_plain} - 2))

    # Create dot separator
    local dots=""
    if ((gap > 0)); then
        dots=$(printf "%${gap}s" | sed "s/ /$DOT_CHAR/g")
        dots=" \[\e[38;2;146;146;146m\]\[\e[2m\]$dots\[\e[22m\]$(__color)"
    fi
    echo -n "$dots"

}

function __powerline_prompt_command {
    local last_status="$?" ## always the first

    # Left prompt
    LEFT_PROMPT=""
    RIGHT_PROMPT=""

    # Right prompt
    local right_prompt_info
    right_prompt_info="$(__powerline_user_info_prompt)"
    RIGHT_PROMPT+="$(__get_segment_with_color "$right_prompt_info")"

    ## left prompt ##
    local info
    for segment in $POWERLINE_PROMPT; do
        info="$(__powerline_"${segment}"_prompt)"
        [[ -n "${info}" ]] && __powerline_left_segment "${info}"
    done

    local powerline_prompt_info
    local prompt
    powerline_prompt_info="$(__powerline_last_status_prompt $last_status)"
    prompt="$(__get_segment_with_color "$powerline_prompt_info")"

    LEFT_PROMPT+=$(__color)

    local dots
    dots=$(__dot_separator "${LEFT_PROMPT}" "${RIGHT_PROMPT}")

    PS1="${LEFT_PROMPT}${dots}${RIGHT_PROMPT}\n$prompt"

    ## cleanup ##
    unset LAST_SEGMENT_COLOR \
        LEFT_PROMPT \
        RIGHT_PROMPT \
        SEGMENTS_AT_LEFT
}

function safe_append_prompt_command {
    local prompt_re

    # Set OS dependent exact match regular expression
    if [[ ${OSTYPE} == darwin* ]]; then
        # macOS
        prompt_re="[[:<:]]${1}[[:>:]]"
    else
        # Linux, FreeBSD, etc.
        prompt_re="\<${1}\>"
    fi

    if [[ ${PROMPT_COMMAND} =~ ${prompt_re} ]]; then
        return
    elif [[ -z ${PROMPT_COMMAND} ]]; then
        PROMPT_COMMAND="${1}"
    else
        PROMPT_COMMAND="${1};${PROMPT_COMMAND}"
    fi
}

safe_append_prompt_command __powerline_prompt_command

__color_matrix() {
    local buffer

    declare -A colors=([0]=black [1]=red [2]=green [3]=yellow [4]=blue [5]=purple [6]=cyan [7]=white)
    declare -A mods=([0]='' [1]=B [4]=U [5]=k [7]=N)

    # Print foreground color names
    echo -ne "       "
    for fgi in "${!colors[@]}"; do
        local fg
        fg=$(printf "%10s" "${colors[$fgi]}")
        #print color names
        echo -ne "\e[m$fg "
    done
    echo

    # Print modificators
    echo -ne "       "
    local mod
    for fgi in "${!colors[@]}"; do
        for modi in "${!mods[@]}"; do
            mod=$(printf "%1s" "${mods[$modi]}")
            buffer="${buffer}$mod "
        done
        # echo -ne "\e[m "
        buffer="${buffer} "
    done
    echo -e "$buffer\e[m"
    buffer=""

    # Print color matrix
    local bgn
    local bg
    local fgn
    local fg
    for bgi in "${!colors[@]}"; do
        bgn=$((bgi + 40))
        bg=$(printf "%6s" "${colors[$bgi]}")

        #print color names
        echo -ne "\e[m$bg "

        for fgi in "${!colors[@]}"; do
            fgn=$((fgi + 30))
            fg=$(printf "%7s" "${colors[$fgi]}")

            for modi in "${!mods[@]}"; do
                buffer="${buffer}\e[${modi};${bgn};${fgn}m "
            done
            # echo -ne "\e[m "
            buffer="${buffer}\e[m "
        done
        echo -e "$buffer\e[m"
        buffer=""
    done
}

__character_map() {
    echo "powerline: ±●➦★⚡★ ✗✘✓✓✔✕✖✗← ↑ → ↓"
    echo "other: ☺☻👨⚙⚒⚠⌛"
}
