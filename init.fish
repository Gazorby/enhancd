# enhancd-fish initialization hook
#
# You can use the following variables in this file:
# * $package       package name
# * $path          package path
# * $dependencies  package dependencies

set -l name (basename (status -f) .fish)
set -l name_uninstall {$name}_uninstall
# set variables
set -gx ENHANCD_FILTER

if not set -q ENHANCD_COMMAND; set -gx ENHANCD_COMMAND "cd"; end

if set -q path
    if not set -q ENHANCD_ROOT; set -gx ENHANCD_ROOT $path; end
else
    if not set -q ENHANCD_ROOT; set -gx ENHANCD_ROOT "$HOME/.config/fisher/github.com/b4b4r07/enhancd"; end
end

if not set -q ENHANCD_DIR; set -gx ENHANCD_DIR "$HOME/.enhancd"; end
if not set -q ENHANCD_DISABLE_DOT; set -gx ENHANCD_DISABLE_DOT 0; end
if not set -q ENHANCD_DISABLE_HYPHEN; set -gx ENHANCD_DISABLE_HYPHEN 0; end
if not set -q ENHANCD_DISABLE_HOME; set -gx ENHANCD_DISABLE_HOME 0; end

if not set -q ENHANCD_DOT_ARG; set -gx ENHANCD_DOT_ARG ".."; end
if not set -q ENHANCD_HYPHEN_ARG; set -gx ENHANCD_HYPHEN_ARG "-"; end
if not set -q ENHANCD_HYPHEN_NUM; set -gx ENHANCD_HYPHEN_NUM 10; end
if not set -q ENHANCD_HOME_ARG; set -gx ENHANCD_HOME_ARG ""; end
if not set -q ENHANCD_USE_FUZZY_MATCH; set -gx ENHANCD_USE_FUZZY_MATCH 1; end

if not set -q ENHANCD_COMPLETION_DEFAULT; set -gx ENHANCD_COMPLETION_DEFAULT 1; end
if not set -q ENHANCD_COMPLETION_BEHAVIOUR; set -gx ENHANCD_COMPLETION_BEHAVIOUR "default"; end

set -gx ENHANCD_COMPLETION_KEYBIND "^I";

set -gx _ENHANCD_VERSION "2.2.4"
set -gx _ENHANCD_SUCCESS 0
set -gx _ENHANCD_FAILURE 60

# Set the filters if empty
if test -z "$ENHANCD_FILTER"
    set -gx ENHANCD_FILTER "fzy:fzf-tmux:fzf:peco:percol:gof:pick:icepick:sentaku:selecta"
end

# make a log file and a root directory
if not test -d "$ENHANCD_DIR"
    mkdir -p "$ENHANCD_DIR"
end

if not test -f "$ENHANCD_DIR/enhancd.log"
    touch "$ENHANCD_DIR/enhancd.log"
end

# alias to enhancd
eval "alias $ENHANCD_COMMAND 'enhancd'"

function __$name_uninstall --on-event $name_uninstall
    rm --force --recursive --dir $ENHANCD_DIR

    set --erase ENHANCD_FILTER
    set --erase ENHANCD_COMMAND
    set --erase ENHANCD_ROOT
    set --erase ENHANCD_DIR
    set --erase ENHANCD_DISABLE_DOT
    set --erase ENHANCD_DISABLE_HYPHEN
    set --erase ENHANCD_DISABLE_HOME
    set --erase ENHANCD_DOT_ARG
    set --erase ENHANCD_HYPHEN_ARG
    set --erase ENHANCD_HYPHEN_NUM
    set --erase ENHANCD_HOME_ARG
    set --erase ENHANCD_USE_FUZZY_MATCH
    set --erase ENHANCD_COMPLETION_DEFAULT
    set --erase ENHANCD_COMPLETION_BEHAVIOUR
    set --erase ENHANCD_COMPLETION_KEYBIND
    set --erase ENHANCD_FILTER
    set --erase _ENHANCD_VERSION
    set --erase _ENHANCD_SUCCESS
    set --erase _ENHANCD_FAILURE
end
