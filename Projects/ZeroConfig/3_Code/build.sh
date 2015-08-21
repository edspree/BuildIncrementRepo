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
echo $VERSION_BUILD
CURRENT_BUILD_NUMBER=$(echo $VERSION_BUILD | cut -d \= -f 2)
echo $CURRENT_BUILD_NUMBER
NEW_BUILD_NUMBER=$($CURRENT_BUILD_NUMBER + 1);
echo $NEW_BUILD_NUMBER
NEW_VERSION_BUILD="$BUILD_VARIABLE=$NEW_BUILD_NUMBER"
echo $NEW_VERSION_BUILD
sed -i.bak s/$VERSION_BUILD/$NEW_VERSION_BUILD/g $BUILD_PROPERTIES
echo $(cat $BUILD_PROPERTIES)
echo "Adding build.properties to staging"
/usr/bin/git add $BUILD_PROPERTIES

echo "Commit build.properties"
/usr/bin/git commit -m "Incremented build version number"

echo "Attempting to push build.properties"
/usr/bin/git push https://github.com/edspree/BuildIncrementRepo.git --force --all
