################################################################################
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="gstreamer"
PKG_VERSION="master"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://gstreamer.freedesktop.org/gstreamer"
#PKG_URL="http://gstreamer.freedesktop.org/src/gstreamer/$PKG_NAME-$PKG_VERSION.tar.xz"

case $TARGET_ARCH in
	i386)
		PKG_DEPENDS_TARGET="toolchain libpng tiff dbus fontconfig eglibc zlib"
		PKG_BUILD_DEPENDS_TARGET="toolchain libpng tiff dbus fontconfig eglibc zlib"
	;;
	x86_64)
		PKG_DEPENDS_TARGET="toolchain libpng tiff dbus fontconfig eglibc zlib"
		PKG_BUILD_DEPENDS_TARGET="toolchain libpng tiff dbus fontconfig eglibc zlib"
	;;
	arm)
		PKG_DEPENDS_TARGET="bcm2835-driver toolchain libpng tiff dbus fontconfig eglibc zlib"
		PKG_BUILD_DEPENDS_TARGET="bcm2835-driver toolchain libpng tiff dbus fontconfig eglibc zlib"
	;;
esac

PKG_PRIORITY="optional"
PKG_SECTION="lib"
PKG_SHORTDESC="gstreamer library"
PKG_LONGDESC="gstreamer library and components"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

case $PROJECT in
	Generic)
		PKG_CONFIGURE_OPTS="\
			-prefix=/usr \
			-target=$TARGET_NAME \
			-host=$TARGET_NAME \
			--disable-maintainer-mode \
			--disable-dependency-tracking \
			--disable-silent-rules \
			--disable-failing-tests \
			--disable-fatal-warnings \
			--disable-static"
	;;
	RPi)
		PKG_CONFIGURE_OPTS="\
			-prefix=/usr \
			-target=arm-none-linux-gnueabi \
			-host=arm-none-linux-gnueabi \
			--disable-maintainer-mode \
			--disable-dependency-tracking \
			--disable-silent-rules \
			--disable-failing-tests \
			--disable-fatal-warnings \
			--disable-static"
	;;
esac


unpack() {

	if [ ! -e $SOURCES/$1 ]; then
		mkdir -p $SOURCES/$1
	fi
	
	pushd $SOURCES/$1/
	
	if [ ! -e ${PKG_NAME}-${PKG_VERSION} ]; then
		git clone git://anongit.freedesktop.org/gstreamer/gstreamer gstreamer-master
	fi
	
	if [ ! -e $ROOT/$BUILD/${PKG_NAME}-${PKG_VERSION} ]; then
		cp -r ${PKG_NAME}-${PKG_VERSION} $ROOT/$BUILD/
	fi
	
	popd
}

configure_target() {

	pushd ${ROOT}/${BUILD}/${PKG_NAME}-${PKG_VERSION}

	if [ ! -e configure ]; then
		./autogen.sh --noconfigure
	fi

	case $PROJECT in
		Generic)
			./configure ${PKG_CONFIGURE_OPTS}
		;;
		RPi)
			./configure ${PKG_CONFIGURE_OPTS}
		;;
	esac
	
	popd
}

#make_target() {
#	case $PROJECT in
#		Generic)
#		;;
#		RPi)
#		;;
#	esac
#}

#makeinstall_target() {
#	case $PROJECT in
#		Generic)
#		;;
#		RPi)
#		;;
#	esac
#}

#pre_install() {
#	makeinstall_target
#}

post_install() {
	case $PROJECT in
		Generic)
		;;
		RPi)
			mkdir -p $INSTALL/usr/libexec/gstreamer-1.0
			cp -R $SYSROOT_PREFIX/usr/libexec/gstreamer-1.0/* $INSTALL/usr/libexec/gstreamer-1.0/
			cp -R $SYSROOT_PREFIX/usr/libexec/gstreamer-1.0/arm-none-linux-gnueabi-gst-plugin-scanner $INSTALL/usr/libexec/gstreamer-1.0/gst-plugin-scanner
			
			mkdir -p $INSTALL/usr/lib
			cp -R $SYSROOT_PREFIX/usr/lib/libgst* $INSTALL/usr/lib/
			
			mkdir -p $INSTALL/usr/lib/gstreamer-1.0
			cp -R $SYSROOT_PREFIX/usr/lib/gstreamer-1.0/* $INSTALL/usr/lib/gstreamer-1.0/
			
			mkdir -p $INSTALL/usr/bin
			cp -R $SYSROOT_PREFIX/usr/bin/arm-none-linux-gnueabi-gst-launch-1.0 $INSTALL/usr/bin/gst-launch
			cp -R $SYSROOT_PREFIX/usr/bin/arm-none-linux-gnueabi-gst-inspect-1.0 $INSTALL/usr/bin/gst-inspect
			cp -R $SYSROOT_PREFIX/usr/bin/arm-none-linux-gnueabi-gst-typefind-1.0 $INSTALL/usr/bin/gst-typefind
		;;
	esac
}

