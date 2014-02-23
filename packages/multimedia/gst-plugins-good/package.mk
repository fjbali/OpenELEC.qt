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

PKG_NAME="gst-plugins-good"
PKG_VERSION="master"
PKG_VERSION="1.2.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://gstreamer.freedesktop.org/gstreamer"
PKG_URL="http://gstreamer.freedesktop.org/src/gst-plugins-good/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS="glib gstreamer gst-plugins-base libjpeg-turbo pulseaudio"
PKG_BUILD_DEPENDS="glib gstreamer gst-plugins-base libjpeg-turbo pulseaudio"
PKG_PRIORITY="optional"
PKG_SECTION="lib"
PKG_SHORTDESC="gstreamer good plugins"
PKG_LONGDESC="gstreamer good plugins"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="	-prefix=/usr \
			-target=arm-none-linux-gnueabi \
			-host=arm-none-linux-gnueabi \
			--disable-maintainer-mode \
			--disable-dependency-tracking \
			--disable-silent-rules \
			--disable-examples \
			--disable-gst_v4l2 \
			--with-default-audiosink=oss4 \
			--with-default-videosink=autovideosink \
			CFLAGS=-Wno-error"

#pre_build_target() {
#}

#pre_configure_target(){
#}

configure_target(){

    echo `pwd`
	
	#pushd $ROOT/$BUILD/${PKG_NAME}-${PKG_VERSION}

	../configure \
		-prefix=/usr \
		-target=arm-none-linux-gnueabi \
		-host=arm-none-linux-gnueabi \
		--with-sysroot=$SYSROOT_PREFIX \
		--disable-maintainer-mode \
		--disable-dependency-tracking \
		--disable-silent-rules \
		--disable-examples \
		--disable-gst_v4l2 \
		--disable-mpegtsmux \
		--disable-shm \
		--disable-mfc \
		--disable-dvb \
		--disable-hls \
		--enable-eglgles \
		--with-egl-window-system=rpi \
		--with-default-audiosink=oss4 \
		--with-default-videosink=autovideosink \
		--without-x \
		CFLAGS="-Wno-error -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads/ -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"

	#popd
}

#post_configure_target(){
#}

#pre_make_target(){
#}

#make_target(){
#}

#post_make_target(){
#}

#pre_makeinstall_target(){
#}

#makeinstall_target(){
#}

#post_makeinstall_target(){
#}

