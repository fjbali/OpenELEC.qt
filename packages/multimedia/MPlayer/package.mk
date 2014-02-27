################################################################################
#
##  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  #  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#  #
#  This Program is distributed in the hope that it will be useful,
#  #  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  #  GNU General Public License for more details.
#
##  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  #  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
#  ################################################################################

PKG_NAME="MPlayer"
PKG_VERSION="1.1.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://qt-project.org"
PKG_URL="http://www.mplayerhq.hu/MPlayer/releases/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS="bcm2835-driver bzip2 Python zlib:host zlib libpng tiff dbus glib fontconfigeglibc liberation-fonts-ttf font-util font-xfree86-type1 font-misc-misc gstreamer gst-plugins-base gst-plugins-good gst-omx gst-plugins-bad alsa"
PKG_BUILD_DEPENDS_TARGET="bcm2835-driver bzip2 Python zlib:host zlib libpng tiff dbus glib fontconfig mysql openssl linux-headers eglibc gstreamer gst-plugins-base gst-plugins-good gst-omx gst-plugins-bad alsa"

PKG_PRIORITY="optional"
PKG_SECTION="lib"
PKG_SHORTDESC="MPlayer; video player"
PKG_LONGDESC="MPlayer; video player"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

case $PROJECT in
	Generic)
		PKG_CONFIGURE_OPTS="\
			--prefix=/usr \
			--enable-vaapi"
	;;
	RPi)
	;;
esac

unpack() {

	pushd $BUILD
	
		if [ ! -d ${PKG_NAME}-${PKG_VERSION} ]; then
			git clone -b hwaccel-vaapi https://git.gitorious.org/vaapi/mplayer.git ${PKG_NAME}-${PKG_VERSION}
		fi
		
#		tar -xzf $SOURCES/${PKG_NAME}/qt-everywhere-opensource-src-${PKG_VERSION}.tar.gz -C $BUILD/
#		mv $BUILD/qt-everywhere-opensource-src-${PKG_VERSION} $BUILD/${PKG_NAME}-${PKG_VERSION}
	popd
}


pre_configure_target() {

	pushd $ROOT/$BUILD/${PKG_NAME}-${PKG_VERSION}
		sed -i -e "/read tmp/d" configure
	popd
}

configure_target() {

	case $PROJECT in
		Generic)
			CPPFLAGS_SAVE=${CPPFLAGS}
			CFLAGS_SAVE=${CFLAGS}
			LDFLAGS_SAVE=${LDFLAGS}
			YASMFLAGS_SAVE=${YASMFLAGS}

			unset CPPFLAGS
			unset CFLAGS
			unset LDFLAGS
			unset YASMFLAGS

			pushd ${ROOT}/${BUILD}/${PKG_NAME}-${PKG_VERSION}
			./configure ${PKG_CONFIGURE_OPTS}
			popd

			CPPFLAGS=${CPPFLAGS_SAVE}
			CFLAGS=${CFLAGS_SAVE}
			LDFLAGS=${LDFLAGS_SAVE}
			YASMFLAGS=${YASMFLAGS_SAVE}

		;;
		RPi)
		;;
	esac
}

make_target() {
	case $PROJECT in
		Generic)
			pushd $ROOT/$BUILD/${PKG_NAME}-${PKG_VERSION}
				make
			popd
		;;
		RPi)
		;;
	esac
}

makeinstall_target() {
	case $PROJECT in
		Generic)
			pushd ${ROOT}/${PKG_BUILD}
				mkdir .install_pkg || true
				DESTDIR=.install_pkg/ make install
			popd
		;;
		RPi)
		;;
	esac
}

#pre_install() {
#}

#post_install() {
#}

