#!/usr/bin/env bash
#
################################################################################
# @description  : Create bwadmin user
# @version      : 0.0.1-SNAPSHOT
# @script       : init-bwnadmin
# @usage        : <syntax script>
################################################################################

#GLOBAL VARIABLES
readonly RED="\\033[1;31m"
readonly GREEN="\\033[1;32m"
readonly YELLOW="\\033[1;33m"
readonly MAGENTA="\\033[1;35m"
readonly GRAS="\033[1m"
readonly END="\\033[1;00m"

ALL_PARAMS=$@
FS="/bw"
BW_ADMIN_USER=bwadmin
BW_ADMIN_PATH=$FS/admin/$BW_ADMIN_USER

usage() {
cat <<-EOF
    usage $0 [OPTIONS]

    OPTIONS :
    =========
        -u      Admin user name (par default is : bwadmin)
	    -p      Path to download BW project script (default is : /bw/admin/bwadmin)

EOF
}

#                __
#   ____   _____/  |_  ____ ______  ______
#  / ___\_/ __ \   __\/  _ \\____ \/  ___/
# / /_/  >  ___/|  | (  <_> )  |_> >___ \
# \___  / \___  >__|  \____/|   __/____  >
#/_____/      \/            |__|       \/
#

while getopts hu:p: arg; do
    case $arg in
    u)
       BW_ADMIN_USER=$OPTARG
       ;;
    p)
       BW_ADMIN_PATH=$OPTARG
       HAS_FORCE_BW_ADMIN_PATH=1
       ;;
    ?|h)
        usage
        exit 2
        ;;
    esac
done

log_error() {
	echo -e "$RED [ERROR] $* $END" >&2
}

log_error_and_exit() {
	echo -e "$RED [ERROR] $*\n $END" >&2 && exit 1
}


check_required_fs () {
    [[ -d $FS ]] || log_error_and_exit "The required file system for installation : $FS doesn't exist ! "
}

ensure_sudo_right() {
    local userId=$(id -u)
    if [[ $userId -ne 0 ]]; then
        log_error "You don't have right to write this script ! Permission denied"
        log_error_and_exit "Try to run as sudo right : $END sudo $0 $ALL_PARAMS"
    fi
}

#             _
#  _ __  __ _(_)_ _
# | '  \/ _` | | ' \
# |_|_|_\__,_|_|_||_|
#

[[ -z HAS_FORCE_BW_ADMIN_PATH ]] && check_required_fs
ensure_sudo_right
