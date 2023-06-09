
# this shell (*not* bash) script automates the build phase for the Dockerfile
set -e

downloadInstall() {
  repoPath=$1
  pkgName=$(basename $repoPath)
  shift
  repoVersion=$1
  pkgTar=downloads/${pkgName}-${repoVersion}.tar.gz
  shift
  cmakeOpts=$*

  echo ""
  echo "-----------------------------------------------------------------------"
  echo "building: $repoPath"
  echo "-----------------------------------------------------------------------"
  echo ""

  mkdir -p downloads
  mkdir -p local

  curl --location --output $pkgTar https://github.com/$repoPath/archive/refs/tags/${repoVersion}.tar.gz
  
  mkdir -p $pkgName
  tar xf $pkgTar --strip-components=1 --directory=$pkgName

  cd $pkgName
  mkdir build
  cd build
  
  cmake \
    $cmakeOpts \
    -D CMAKE_GENERATOR=Ninja \
    -D CMAKE_PREFIX_PATH=../../local \
    -D CMAKE_INSTALL_PREFIX=../../local \
    ..
  
  ninja -j$(nproc) install
  
  cd ../..
}

echo ""
echo "-----------------------------------------------------------------------"
echo "updating apt package information (build)"
echo "-----------------------------------------------------------------------"
echo ""

apt-get update

echo ""
echo "-----------------------------------------------------------------------"
echo "apt installing build tools (build)"
echo "-----------------------------------------------------------------------"
echo ""

apt-get --yes install gcc g++ cmake ninja-build git curl pkgconf tree

echo ""
echo "-----------------------------------------------------------------------"
echo "apt installing dependent libraries (build)"
echo "-----------------------------------------------------------------------"
echo ""

apt-get --yes install libssl-dev uuid-dev libsodium-dev libbsd-dev

# we need to compile and install cppzmq, libzmq, nl-json, xeus, xeus-zmq, and xtl

downloadInstall zeromq/libzmq v4.3.4 -DBUILD_TESTS=OFF -DBUILD_SHARED=OFF

downloadInstall zeromq/cppzmq v4.9.0 -DCPPZMQ_BUILD_TESTS=OFF

downloadInstall nlohmann/json v3.11.2 -DJSON_BuildTests=OFF

downloadInstall xtensor-stack/xtl 0.7.5

downloadInstall jupyter-xeus/xeus 3.0.5 -DXEUS_BUILD_SHARED_LIBS=OFF

downloadInstall jupyter-xeus/xeus-zmq 1.0.2 -DXEUS_ZMQ_BUILD_SHARED_LIBS=OFF

echo ""
echo "-----------------------------------------------------------------------"
echo "Contents of local"
echo "-----------------------------------------------------------------------"
echo ""

tree local

echo ""
echo "-----------------------------------------------------------------------"
echo "DONE (build phase)"
echo "-----------------------------------------------------------------------"
echo ""
