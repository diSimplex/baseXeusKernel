
# this shell (*not* bash) script automates the "image" phase for the Dockerfile
set -e

echo ""
echo "-----------------------------------------------------------------------"
echo "updating apt package information (image)"
echo "-----------------------------------------------------------------------"
echo ""

apt-get update

echo ""
echo "-----------------------------------------------------------------------"
echo "apt installing build tools (image)"
echo "-----------------------------------------------------------------------"
echo ""

apt-get --yes install gcc g++ ninja-build git curl pkgconf tree rsync

echo ""
echo "-----------------------------------------------------------------------"
echo "apt installing dependent libraries (image)"
echo "-----------------------------------------------------------------------"
echo ""

apt-get --yes install libssl-dev uuid-dev libsodium-dev libbsd-dev

echo ""
echo "-----------------------------------------------------------------------"
echo "rsyncing xeusTools (image phase)"
echo "-----------------------------------------------------------------------"
echo ""

rsync -av /xeusTools/ /usr/local

tree /usr/local

echo ""
echo "-----------------------------------------------------------------------"
echo "DONE (image phase)"
echo "-----------------------------------------------------------------------"
echo ""
