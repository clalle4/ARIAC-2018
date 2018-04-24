#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ros/helloworld_ws/src/ariac_example"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ros/helloworld_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ros/helloworld_ws/install/lib/python2.7/dist-packages:/home/ros/helloworld_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ros/helloworld_ws/build" \
    "/usr/bin/python" \
    "/home/ros/helloworld_ws/src/ariac_example/setup.py" \
    build --build-base "/home/ros/helloworld_ws/build/ariac_example" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/ros/helloworld_ws/install" --install-scripts="/home/ros/helloworld_ws/install/bin"
