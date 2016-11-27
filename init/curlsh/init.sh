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
readonly MAGENTA="\\033[1;35m"
readonly GRAS="\033[1m"
readonly END="\\033[1;00m"

info() {
	echo -e "$GREEN [INFO] $* $END"
}

info " Attemp to download necessary files to setup BW environment ..."
echo " "

#FIXME : Must change , scp right now for project understanding


cat <<-EOF
    Welcome to

    ___.          ___.
    \_ |____  _  _\_ |____  _  __
     | __ \ \/ \/ /| __ \ \/ \/ /
     | \_\ \     / | \_\ \     /
     |___  /\/\_/  |___  /\/\_/
         \/            \/

     ---- (c)$(date +%Y) bwnyasse

     +-----------------------------------------------------------------------------+
     | Create admin user with the following command                                |
     +-----------------------------------------------------------------------------+
     | \$ sudo ./install/init-bwadmin.sh                                            |
     ------------------------------------------------------------------------------+
EOF




