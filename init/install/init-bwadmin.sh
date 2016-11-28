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
readonly BLUE="\\033[1;34m"
readonly MAGENTA="\\033[1;35m"
readonly GRAS="\033[1m"
readonly END="\\033[1;00m"

ALL_PARAMS=$@
DEFAULT_INSTALL_PATH="$HOME/.bwbw"
BW_ADMIN_USER=bwadmin
BW_ADMIN_PATH=$DEFAULT_INSTALL_PATH/admin/$BW_ADMIN_USER

usage() {
cat <<-EOF
    usage $0 [OPTIONS]

    OPTIONS :
    =========
        -u      Admin user name (par default is : bwadmin)
EOF
}

#                __
#   ____   _____/  |_  ____ ______  ______
#  / ___\_/ __ \   __\/  _ \\____ \/  ___/
# / /_/  >  ___/|  | (  <_> )  |_> >___ \
# \___  / \___  >__|  \____/|   __/____  >
#/_____/      \/            |__|       \/
#

while getopts hu: arg; do
    case $arg in
    u)
       BW_ADMIN_USER=$OPTARG
       ;;
    *|h)
        usage
        exit 2
        ;;
    esac
done

lcase() {
	local text=$1
	echo $(echo "$text" | tr '[:upper:]' '[:lower:]')
}

ucase() {
	local text=$1
	echo $(echo "$text" | tr '[:lower:]' '[:upper:]')
}

ask() {
	local question=$1
	local fonc=$2
	local rep

	echo -e "$MAGENTA" "$question (yes/no)" "$END"
	read rep
	if [[ $(lcase "$rep") == "yes" ]]
	then
		$fonc
	else
		echo -e "$GREEN" "..." "$END"
	fi
}

log_info() {
	echo -e "$BLUE [INFO] $* $END"
}

log_success() {
	echo -e "$GREEN [INFO] $* $END"
}

log_warn() {
	echo -e "$YELLOW [WARN] $* $END"
}

log_error() {
    echo ""
	echo -e "$RED [ERROR] $* $END" >&2
}

log_error_and_exit() {
    echo ""
	echo -e "$RED [ERROR] $*\n $END" >&2 && exit 1
}


ensure_sudo_right() {
    local userId=$(id -u)
    if [[ $userId -ne 0 ]]; then
        log_error "Permission denied : You don't have right to run this script ! "
        log_error_and_exit "Try to run with sudo right : $END sudo $0 $ALL_PARAMS"
    fi
}

ensure_user_not_already_exist() {
    log_info "Check BWBW admin username ..."
    if id $BW_ADMIN_USER >/dev/null 2>&1
    then
        log_error_and_exit " KO : The user $END$BW_ADMIN_USER$RED already exists !"
    fi
}

install_user() {
    mkdir -p $DEFAULT_INSTALL_PATH

    #TODO: ensure free space

    #TODO Effective user installation must go here
    mkdir -p ${BW_ADMIN_PATH%/*}
    /usr/sbin/useradd -c "Admin BWBW" -m -d $BW_ADMIN_PATH -s /bin/bash -p "\$1\$zMF9TLy9\$82mKGpg.zve4XI4JiucVB0" $BW_ADMIN_USER >/dev/null
    [[ $? -ne 0 ]] && log_error_and_exit "Enable to create user $BW_ADMIN_USER !"
    chmod 755 $BW_ADMIN_PATH
    echo "CREATED=$(date)" > $BW_ADMIN_PATH/bw-info.conf
}

#             _
#  _ __  __ _(_)_ _
# | '  \/ _` | | ' \
# |_|_|_\__,_|_|_||_|
#
ensure_sudo_right
ensure_user_not_already_exist

if [[ -d $DEFAULT_INSTALL_PATH ]]; then
 ask "The installation folder already exists at $DEFAULT_INSTALL_PATH. Continue to override it ? " install_user
else
    install_user
fi

