#!/usr/bin/env bash
#
################################################################################
# @description  : Download bwbw to setup initialisation
# @version      : 0.0.1-SNAPSHOT
# @script       : init
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

ACTUAL_INIT_REPO=vagrant@192.168.33.10:/vagrant/bwbw/init
BW_INIT_DIRECTORY=.bw-init

# _ __  __ _(_)_ _
#| '  \/ _` | | ' \
#|_|_|_\__,_|_|_||_|

log_info() {
	echo -e "$BLUE [INFO] $* $END"
}

log_warn() {
	echo -e "$YELLOW [WARN] $* $END"
}

if [[ -d $BW_INIT_DIRECTORY ]]; then
    log_warn " Find a previous init installation directory, it will be deleted !"
    echo ""
    #TODO: Ask confirmation
    rm -rf $BW_INIT_DIRECTORY
fi

log_info " Attemp to download necessary files to setup BWBW environment ..."
echo " "
#FIXME : Must change , scp right now for project understanding
scp -rpq -o LogLevel=QUIET $ACTUAL_INIT_REPO $BW_INIT_DIRECTORY
#TODO Handle error !

find $BW_INIT_DIRECTORY/ -type f -name "*.sh" -exec chmod +x {} \;

cat <<-EOF
    Welcome to
     _           _
    | |____ __ _| |____ __ __
    | '_ \ V  V / '_ \ V  V /
    |_.__/\_/\_/|_.__/\_/\_/

     ---- (c)$(date +%Y) bwnyasse

     +-----------------------------------------------------------------------------+
     | Create admin user with the following command                                |
     +-----------------------------------------------------------------------------+
     | \$ sudo .bw-init/install/init-bwadmin.sh -u <USER_NAME>                      |
     ------------------------------------------------------------------------------+
EOF




