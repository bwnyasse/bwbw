#!/usr/bin/env bash
#
################################################################################
# @description  : Create bwadmin user
# @version      : 0.0.1-SNAPSHOT
# @script       : init-bwnadmin
# @usage        : <syntax script>
################################################################################

# GLOBAL VARIABLES
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