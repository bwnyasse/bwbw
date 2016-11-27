#!/usr/bin/env bash
# PROJECT :: ${POJECT_NAME}
#===========================================================================
# @description  : <DESCRIPTION>
# @version      : <VERSION>ss
# @script       : ${NAME}
# @usage        : <SYNTAX_USAGE>
#===========================================================================

#GLOBAL VARIABLES
readonly RED="\\033[1;31m"
readonly GREEN="\\033[1;32m"
readonly YELLOW="\\033[1;33m"
readonly MAGENTA="\\033[1;35m"
readonly GRAS="\033[1m"
readonly END="\\033[1;00m"

log::debug() {
	[[ -n $DEBUG ]] && echo -e "$MAGENTA[DEBUG]$END $*" || return 0
}

log::error() {
	echo -e "$RED [ERROR] $* $END" >&2
}

log::error_and_exit() {
	echo -e "$RED [ERROR] $1 $*\n $END" >&2 && exit 1
}

log::info() {
	echo -e "$GREEN [INFO] $* $END"
}

log::info_and_exit() {
	echo -e "$GREEN [INFO] $* $END\n" && exit 0
}

log::warn() {
	echo -e "$YELLOW [WARN] $* $END"
}
