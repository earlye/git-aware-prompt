find_git_branch() {
    # Based on: http://stackoverflow.com/a/13003854/170413

    local branch # bash for "declare local variable named 'branch'"
    
    branch=$(git branch-name)
    if [[ ! -z $branch ]] ; then
        if [[ "$branch" == "HEAD" ]]; then
            branch='(*detached)'
        fi
        git_branch="($branch)"
    else
        git_branch=""
    fi
}

find_git_dirty() {
    GIT_ROOT=$(git rev-parse --show-toplevel 2> /dev/null )
    if [[ ! -f $GIT_ROOT/.git_prompt_nodirty ]]; then
        git_dirty=''
    else
        local status=$(git status --porcelain 2> /dev/null)
        if [[ "$status" != "" ]]; then
            git_dirty='*'
        else
            git_dirty=''
        fi
    fi
}

PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
