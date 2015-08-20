#!/bin/bash 

#if [ -z $WORKSPACE ]; then
#	echo "Error: the 'WORKSPACE' environment variable is not set."
#	exit 1
#fi

BRANCH="master"
WORKSPACE="."
BUILDDIR=$WORKSPACE/build
TMSRC="$WORKSPACE/tm"
PACKAGE="ZeroConfig"
BUILD_PROPERTIES="build.properties"

if [ -f /etc/profile ]; then
    . /etc/profile
fi

#if [ -z $1 ]; then
#    echo "The BRANCH variable is not set."
#    exit 1
#else
#    BRANCH=$1
#fi
#
#if [ -z $2 ]; then
#	echo "The BUILD_NUMBER variable is not set."
#	exit 2
#else
#	BUILD_NUMBER=$2
#fi
#
#if [ -z $3 ]; then
#	echo "The GIT variable is not set."
#	exit 3
#else
#	GIT=$3
#fi

#if [ -d $TMSRC ]; then
#    cd $TMSRC && /usr/bin/git pull
#    /usr/bin/git checkout $BRANCH
#    /usr/bin/git pull
#else
#    if [ ! -d $WORKSPACE/tm ]; then
#	/bin/mkdir $WORKSPACE/tm
#    fi

cd $WORKSPACE
/usr/bin/git clone https://github.com/edspree/BuildIncrementRepo.git
/usr/bin/git checkout $BRANCH
#fi

BUILD_VARIABLE="version.build"
VERSION_BUILD=$(/bin/grep $BUILD_VARIABLE $BUILD_PROPERTIES| /bin/grep -v version.major)
BUILD_NUMBER=$(cut -d'=' -f1)
NEW_BUILD_NUMBER=$BUILD_NUMBER + 1;
NEW_VERSION_BUILD="$BUILD_VARIABLE=$NEW_BUILD_NUMBER"
echo $NEW_VERSION_BUILD
sed -i.bak s/$VERSION_BUILD/$NEW_VERSION_BUILD/g $BUILD_PROPERTIES

/usr/bin/git commit $BUILD_PROPERTIES
/usr/bin/git push $BUILD_PROPERTIES

#TAR="${PACKAGE}-${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}.${BUILD_NUMBER}.tar"
#RPM="${PACKAGE}-${VERSION}-${BUILD_NUMBER}.x86_64.rpm"


