#!/bin/bash 

BRANCH="master"
WORKSPACE="."
BUILDDIR=$WORKSPACE/build
TMSRC="$WORKSPACE/tm"
PACKAGE="ZeroConfig"
BUILD_PROPERTIES="/opt/app/ngt/support/.jenkins/workspace/ZeroConfig/Projects/ZeroConfig/3_Code/build.properties"

if [ -f /etc/profile ]; then
    . /etc/profile
fi

BUILD_VARIABLE="version.build"
VERSION_BUILD=$(/bin/grep $BUILD_VARIABLE $BUILD_PROPERTIES| /bin/grep -v version.major)
BUILD_NUMBER=$(cut -d'=' -f1)
echo $BUILD_NUMBER
NEW_BUILD_NUMBER=$BUILD_NUMBER + 1;
NEW_VERSION_BUILD="$BUILD_VARIABLE=$NEW_BUILD_NUMBER"
echo $NEW_VERSION_BUILD
sed -i.bak s/$VERSION_BUILD/$NEW_VERSION_BUILD/g $BUILD_PROPERTIES

echo "Attempting to commit build.properties"
/usr/bin/git commit -m "Incremented build version number"

echo "Attempting to push build.properties"
/usr/bin/git push
