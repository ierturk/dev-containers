#!/bin/bash -l

WAYLAND_USER=${WAYLAND_USER:-ierturk}
WESTON_ARGS=${WESTON_ARGS:---current-mode}

HAS_GPU=true
HAS_DPU=false

echo "SoC has GPU: $HAS_GPU"
echo "SoC has DPU: $HAS_DPU"

#
# Set desktop defaults.
#

function init_xdg()
{
    if test -z "${XDG_RUNTIME_DIR}"; then
        export XDG_RUNTIME_DIR=/tmp/$(id -u ${WAYLAND_USER})-runtime-dir
    fi

    echo "XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR}" >> /etc/environment

    if ! test -d "${XDG_RUNTIME_DIR}"; then
        mkdir -p "${XDG_RUNTIME_DIR}"
    fi

    chown "${WAYLAND_USER}" "${XDG_RUNTIME_DIR}"
    chmod 0700 "${XDG_RUNTIME_DIR}"

    # Create folder for XWayland Unix socket
    export X11_UNIX_SOCKET="/tmp/.X11-unix"
    if ! test -d "${X11_UNIX_SOCKET}"; then
        mkdir -p ${X11_UNIX_SOCKET}
    fi

    chown ${WAYLAND_USER}:video ${X11_UNIX_SOCKET}
}

init_xdg

#
# Execute the weston compositor.
#

function init()
{
    SWITCH_VT_CMD=""
    # Weston misses to properly change VT when using weston-launch. Work around
    # by manually switch VT before Weston starts. This avoid keystrokes ending
    # up on the old VT (e.g. tty1).
    # Use bash built-in regular exprssion to find tty device
    VT=""
    if [[ "$1" == "weston-launch" && "$@" =~ --tty=/dev/tty([^ ][0-9]*) ]]; then
        VT=${BASH_REMATCH[1]}
        # Make process a session leader and switch to a new VT. Always wait
        # on the child processes until they terminate (-w).
        SWITCH_VT_CMD="setsid -w -f openvt -w -f -s -c ${VT} -e"
    fi

    # echo error message, when executable file doesn't exist.
    if CMD=$(command -v "$1" 2>/dev/null); then
        shift
        CMD="${CMD} $@"
        if [ "${SWITCH_VT_CMD}" != "" ]; then
            STDOUT="/proc/$$/fd/1"
            STDERR="/proc/$$/fd/2"
            exec ${SWITCH_VT_CMD} -- bash -c "${CMD} > >(tee ${STDOUT}) 2> >(tee ${STDERR})" &
            child=$!
            # Remap signals so that weston-launch also gets them
            for signal in SIGINT SIGTERM SIGHUP SIGABRT SIGKILL; do trap "kill -$signal $child" $signal; done
            wait "$child"
        else
            sh -c "${CMD}"
        fi
    else
        echo "Command not found: $1"
        exit 1
    fi
}

if [ $# -gt 0 ]; then
    options=$(getopt -l "developer:" -- "$@" 2>/dev/null)

    while true
    do
        case $1 in
        --developer)
            export XDG_CONFIG_HOME=/etc/xdg/weston-dev/
            echo "XDG_CONFIG_HOME=/etc/xdg/weston-dev/" >> /etc/environment
            ;;
        *)
            break;;
        esac
        shift
    done
fi

$HAS_GPU || $HAS_DPU || {
    echo "Fallbacking to software renderer."
    WESTON_ARGS="${WESTON_ARGS} --use-pixman"
}

CONFIGURATION_FILE=/etc/xdg/weston/weston.ini
CONFIGURATION_FILE_DEV=/etc/xdg/weston-dev/weston.ini

if [ "$IGNORE_X_LOCKS" != "1" ]; then
    echo "Removing previously created '.X*-lock' entries under /tmp before starting Weston. Pass 'IGNORE_X_LOCKS=1' environment variable to Weston container to disable this behavior."
    rm -rf /tmp/.X*-lock
fi

function cleanup()
{
    if [ "$IGNORE_VT_SWITCH_BACK" != "1" ]; then
        # switch back to tty1, otherwise the console screen is not displayed.
        chvt 1
    fi
}

trap cleanup EXIT

dos2unix $CONFIGURATION_FILE
dos2unix $CONFIGURATION_FILE_DEV

if test -z "$1"; then
    init weston-launch --tty=/dev/tty7 --user="${WAYLAND_USER}" -- ${WESTON_ARGS}
else
    init "$@"
fi
