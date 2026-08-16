# Fish Shell Configuration
# Place this in ~/.config/fish/config.fish

# ═══════════════════════════════════════════════════════════════════════════
# Environment Variables
# ═══════════════════════════════════════════════════════════════════════════

# Disable welcome message
set -g fish_greeting

# Editor configuration
set -gx EDITOR nvim
set -gx VISUAL nvim

# Path additions
fish_add_path -g ~/.local/bin
fish_add_path -g ~/.cargo/bin
fish_add_path -g ~/go/bin
fish_add_path -g ~/.npm-global/bin
fish_add_path -g ~/.deno/bin

set -g fish_cursor_default block
set -g fish_cursor_insert block
set -g fish_cursor_replace_one block
set -g fish_cursor_replace block
set -g fish_cursor_visual block

# Language environment
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# History
set -g fish_history_max 100000

# # Launch webdev Neovim
function wvim
    NVIM_APPNAME=nvim-webdev nvim $argv
end

# Less configuration
set -gx LESS '-R -i -M -s -w -X -F'
set -gx LESSHISTFILE /dev/null

# ═══════════════════════════════════════════════════════════════════════════
# Colors and Theme
# ═══════════════════════════════════════════════════════════════════════════

# Syntax highlighting
set -g fish_color_normal white
set -g fish_color_command blue --bold
set -g fish_color_keyword magenta --bold
set -g fish_color_quote yellow
set -g fish_color_redirection cyan --bold
set -g fish_color_end green
set -g fish_color_error red --bold
set -g fish_color_param brwhite
set -g fish_color_comment brblack --italics
set -g fish_color_selection --background=brblack
set -g fish_color_search_match --background=brblack
set -g fish_color_operator cyan
set -g fish_color_escape bryellow
set -g fish_color_autosuggestion brblack
set -g fish_color_cancel red

# Completion colors
set -g fish_pager_color_progress brblack --background=cyan
set -g fish_pager_color_prefix cyan --bold
set -g fish_pager_color_completion white
set -g fish_pager_color_description brblack --italics
set -g fish_pager_color_selected_background --background=brblack
set -g fish_pager_color_selected_prefix bryellow --bold
set -g fish_pager_color_selected_completion brwhite
set -g fish_pager_color_selected_description bryellow

# ═══════════════════════════════════════════════════════════════════════════
# Aliases - Navigation
# ═══════════════════════════════════════════════════════════════════════════

alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

# Note: ~ and - cannot be aliased in fish, but they work natively
# ~ already works as cd ~
# cd - already works to go to previous directory

# ═══════════════════════════════════════════════════════════════════════════
# Aliases - File Operations
# ═══════════════════════════════════════════════════════════════════════════

# Modern replacements
if command -q eza
    alias ls 'eza --icons --group-directories-first'
    alias ll 'eza -lah --icons --group-directories-first --git'
    alias la 'eza -a --icons --group-directories-first'
    alias lt 'eza --tree --level=2 --icons'
    alias ltt 'eza --tree --level=3 --icons'
else
    alias ls 'ls --color=auto -h'
    alias ll 'ls -lAh --color=auto'
    alias la 'ls -A --color=auto'
end

if command -q bat
    alias cat 'bat --style=auto'
    alias catn 'bat --style=plain'
    alias catt 'bat --style=plain --paging=never'
end

if command -q rg
    alias grep rg
else
    alias grep 'grep --color=auto'
end

if command -q fd
    alias find fd
end

# Safe file operations
alias cp 'cp -iv'
alias mv 'mv -iv'
alias rm 'rm -iv'
alias mkdir 'mkdir -pv'

# ═══════════════════════════════════════════════════════════════════════════
# Aliases - System
# ═══════════════════════════════════════════════════════════════════════════

alias h history
alias j 'jobs -l'
alias clr clear
alias c clear

# Process management
if command -q btm
    alias top btm
else if command -q htop
    alias top htop
end

alias ps 'ps auxf'
alias psg 'ps aux | grep -v grep | grep -i -e VSZ -e'

# Disk usage
if command -q duf
    alias df duf
else
    alias df 'df -h'
end

if command -q dust
    alias du dust
else
    alias du 'du -h'
end

# Network
alias ports 'netstat -tulanp'
alias myip 'curl -s ifconfig.me'
alias localip 'ip addr show | grep "inet " | grep -v 127.0.0.1'

# ═══════════════════════════════════════════════════════════════════════════
# Aliases - Git
# ═══════════════════════════════════════════════════════════════════════════

alias g git
alias ga 'git add'
alias gs 'git status'
alias gaa 'git add --all'
alias gc 'git commit -v'
alias gcm 'git commit -m'
alias gca 'git commit -v --amend'
alias gcan 'git commit -v --amend --no-edit'
alias gco 'git checkout'
alias gcb 'git checkout -b'
alias gd 'git diff'
alias gds 'git diff --staged'
alias gf 'git fetch'
alias gl 'git log --oneline --graph --decorate'
alias gla 'git log --oneline --graph --decorate --all'
alias gp 'git push'
alias gpf 'git push --force-with-lease'
alias gpl 'git pull'
alias gst 'git status'
alias gss 'git status -s'
alias gsw 'git switch'
alias gswc 'git switch -c'
alias grb 'git rebase'
alias grbi 'git rebase -i'
alias grs 'git restore'
alias grss 'git restore --staged'
alias gsh 'git stash'
alias gsha 'git stash apply'
alias gshp 'git stash pop'
alias gshl 'git stash list'
# ═══════════════════════════════════════════════════════════════════════════
# Functions - Utilities
# ═══════════════════════════════════════════════════════════════════════════

# Create and enter directory
function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end

# Extract archives
function extract
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar x $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via extract()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

# Find and kill process by name
function killp
    ps aux | grep -i $argv[1] | grep -v grep | awk '{print $2}' | xargs kill -9
end

# Create backup of file
function backup
    cp $argv[1] $argv[1].backup-(date +%Y%m%d-%H%M%S)
end

# Cheat sheet
function cheat
    curl -s "cheat.sh/$argv[1]"
end

# QR code generator
function qr
    curl -s "qrenco.de/$argv[1]"
end

# Git clone and cd
function gcl
    git clone $argv[1] && cd (basename $argv[1] .git)
end

# ═══════════════════════════════════════════════════════════════════════════
# Functions - Navigation
# ═══════════════════════════════════════════════════════════════════════════

# Quick directory access with fuzzy finder
function fcd
    if command -q fzf
        set -l dir (fd --type d --hidden --follow --exclude .git | fzf)
        test -n "$dir" && cd "$dir"
    else
        echo "fzf not installed"
    end
end

# Recent directories
function frecent
    if command -q fzf
        set -l dir (string split \n -- (dirh | string trim) | fzf)
        test -n "$dir" && cd "$dir"
    end
end

# ═══════════════════════════════════════════════════════════════════════════
# Functions - Development
# ═══════════════════════════════════════════════════════════════════════════

# Git helper - quick commit and push
function gcp
    git add --all
    git commit -m "$argv"
    git push
end

# Initialize common project types
function init-python
    python3 -m venv venv
    source venv/bin/activate.fish
    pip install --upgrade pip
    touch requirements.txt
    touch README.md
    echo "Python project initialized"
end

function init-node
    bun init
    touch README.md
    echo node_modules/ >.gitignore
    echo "Node.js project initialized"
end

function init-rust
    cargo init
    echo "Rust project initialized"
end

# Find largest files/directories
function largest
    du -ah . | sort -rh | head -n (test -n "$argv[1]" && echo $argv[1] || echo 20)
end

# Quick file search with preview
function ff
    set file (fzf --preview 'bat --style=numbers --color=always {}')
    if test -n "$file"
        if test -S /tmp/nvim-server
            nvim --server /tmp/nvim-server --remote "$file"
        else
            nvim "$file"
        end
    end
end

# Search content in files
function ff
    set query $argv
    set file ""

    if test -n "$query"
        set file (fzf --query "$query" --preview 'bat --style=numbers --color=always {}')
    else
        set file (fzf --preview 'bat --style=numbers --color=always {}')
    end

    if test -n "$file"
        if test -S /tmp/nvim-server
            nvim --server /tmp/nvim-server --remote "$file"
        else
            nvim "$file"
        end
    end
end

# ═══════════════════════════════════════════════════════════════════════════
# Key Bindings
# ═══════════════════════════════════════════════════════════════════════════

# Ctrl+F for file finder
if command -q fzf
    bind \cf ff
end

# Ctrl+R for history search with fzf
if command -q fzf
    bind \cr 'history | fzf | read -l result; and commandline -i $result'
end

# Ctrl+G for fuzzy cd
if command -q fzf
    bind \cg fcd
end

# ═══════════════════════════════════════════════════════════════════════════
# Abbreviations (expand on space)
# ═══════════════════════════════════════════════════════════════════════════

abbr -a -g gti git
abbr -a -g chmox chmod +x
abbr -a -g pls 'sudo !!'
abbr -a -g ipy ipython
abbr -a -g tf terraform
abbr -a -g k kubectl
abbr -a -g dc docker-compose
abbr -a -g vim nvim
abbr -a -g vi nvim

# ═══════════════════════════════════════════════════════════════════════════
# Tool Integrations
# ═══════════════════════════════════════════════════════════════════════════

# Starship prompt
if command -q starship
    starship init fish | source
end

# Zoxide (better cd)
if command -q zoxide
    zoxide init fish | source
    alias cd z
end

# FZF configuration
if command -q fzf
    set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --inline-info'
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
end

# Direnv
if command -q direnv
    direnv hook fish | source
end

# Atuin (shell history)
if command -q atuin
    atuin init fish | source
end

# Node version manager
if test -d ~/.nvm
    set -gx NVM_DIR ~/.nvm
end

# Rust/Cargo
if test -f ~/.cargo/env.fish
    source ~/.cargo/env.fish
end

# ═══════════════════════════════════════════════════════════════════════════
# Local Configuration
# ═══════════════════════════════════════════════════════════════════════════

# Load local config if exists
if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end

# ═══════════════════════════════════════════════════════════════════════════
# Completion Settings
# ═══════════════════════════════════════════════════════════════════════════

# Enable command-not-found suggestions (if available)
if test -f /usr/share/doc/find-the-command/ftc.fish
    source /usr/share/doc/find-the-command/ftc.fish
end

# Better tab completion
set -g fish_complete_path $fish_complete_path ~/.config/fish/completions

# ═══════════════════════════════════════════════════════════════════════════
# Performance Tweaks
# ═══════════════════════════════════════════════════════════════════════════

# Async prompt loading (if using tide or other async prompts)
set -g fish_prompt_pwd_dir_length 3

# Reduce escape sequence timeout for vim mode
set -g fish_escape_delay_ms 10

#Aliases
alias v nvim
alias vim nvim
alias q exit
alias i 'yay -S'
alias r 'yay -R'
alias s 'yay -Ss'
alias cache 'yay -Sc'
alias cleanup 'sudo pacman -Rns $(pacman -Qdtq)'
