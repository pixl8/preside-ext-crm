#!/bin/bash

GIT_BRANCH=${GIT_BRANCH:-unknown-branch}
ARTIFACTS_DIR=${ARTIFACTS_DIR:-artifacts/}
ARTIFACTS_SUBDIR=${ARTIFACTS_SUBDIR:-crm}
BRANCH_FOLDER=${GIT_BRANCH//origin\//}
BRANCH_FOLDER="${BRANCH_FOLDER##*/}"
BUILD_DIR=$ARTIFACTS_DIR$ARTIFACTS_SUBDIR/$BRANCH_FOLDER
BUILD_NUMBER=${BUILD_NUMBER:-1}
PADDED_BUILD_NUMBER=`printf %05d $BUILD_NUMBER`
ZIP_FILE=$BRANCH_FOLDER.zip

echo "Building Preside Extension: CRM"
echo "==============================="
echo "GIT Branch      : $GIT_BRANCH"
echo "Build directory : $BUILD_DIR"
echo "Build number    : $PADDED_BUILD_NUMBER"
echo

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR

echo "Compiling static files..."
cd assets
npm install && grunt
echo "Done."
cd ..

echo "Copying files to $BUILD_DIR..."
rsync -a ./ --exclude=".*" --exclude="$ARTIFACTS_DIR" --exclude="*.sh" --exclude="**/node_modules" --exclude="tests" "$BUILD_DIR"
echo "Done."

cd "$BUILD_DIR"
echo "Installing dependencies..."
box install --production save=false
echo "Done."

echo "Inserting build number..."
sed -i "s/BUILD_NUMBER/$PADDED_BUILD_NUMBER/" manifest.json
sed -i "s/BUILD_NUMBER/$PADDED_BUILD_NUMBER/" box.json
echo "Done."

echo "Zipping up..."
zip -r $ZIP_FILE *
mv $ZIP_FILE ../
cd ../
rm -rf $BRANCH_FOLDER
echo done

echo "Build complete :)"
