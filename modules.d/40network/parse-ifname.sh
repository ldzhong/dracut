#!/bin/sh
#
# Format:
#	ifname=<interface>:<mac>
#
#
# Examples:
# ifname=eth0:4a:3f:4c:04:f8:d7
#
# Note when using ifname= to get persistent interface names, you must specify
# an ifname= argument for each interface used in an ip= or fcoe= argument

parse_ifname_opts() {
    local IFS=:
    set $1

    case $# in
        7)
            ifname_if=$1
            # udev requires MAC addresses to be lower case
            ifname_mac=$(echo $2:$3:$4:$5:$6:$7 | tr '[:upper:]' '[:lower:]')
            ;;
        *)
            die "Invalid arguments for ifname="
            ;;
    esac
}

# check if there are any ifname parameters
if ! getarg ifname= >/dev/null ; then
    return
fi

# Check ifname= lines
for p in $(getargs ifname=); do
    parse_ifname_opts $p
done
