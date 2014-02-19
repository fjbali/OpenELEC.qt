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

PKG_NAME="qt5"
PKG_VERSION="5.2.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://qt-project.org"
PKG_URL="http://download.qt-project.org/official_releases/qt/5.2/5.2.1/single/qt-everywhere-opensource-src-5.2.1.tar.gz"

case $TARGET_ARCH in
	i386)
		PKG_DEPENDS="bzip2 Python zlib-host zlib libpng tiff dbus glib fontconfigeglibc liberation-fonts-ttf font-util font-xfree86-type1 font-misc-misc gstreamer gst-plugins-base gst-plugins-good gst-ffmpeg gst-omx gst-plugins-bad alsa"
		PKG_BUILD_DEPENDS="bzip2 Python zlib-host zlib libpng tiff dbus glib fontconfig mysql openssl linux-headers eglibc gstreamer gst-plugins-base gst-plugins-good gst-ffmpeg gst-omx gst-plugins-bad alsa"
	;;
	x86_64)
		PKG_DEPENDS="bzip2 Python zlib-host zlib libpng tiff dbus glib fontconfigeglibc liberation-fonts-ttf font-util font-xfree86-type1 font-misc-misc gstreamer gst-plugins-base gst-plugins-good gst-omx gst-plugins-bad alsa"
		PKG_BUILD_DEPENDS="bzip2 Python zlib-host zlib libpng tiff dbus glib fontconfig mysql openssl linux-headers eglibc gstreamer gst-plugins-base gst-plugins-good gst-omx gst-plugins-bad alsa"
	;;
	arm)
#		PKG_DEPENDS_HOST="bcm2835-driver bzip2 Python zlib-host zlib libpng tiff dbus glib fontconfigeglibc liberation-fonts-ttf font-util font-xfree86-type1 font-misc-misc gstreamer gst-plugins-base gst-plugins-good gst-omx gst-plugins-bad alsa"
#		PKG_BUILD_DEPENDS_HOST="bcm2835-driver bzip2 Python zlib-host zlib libpng tiff dbus glib fontconfig mysql openssl linux-headers eglibc gstreamer gst-plugins-base gst-plugins-good gst-omx gst-plugins-bad alsa"
		PKG_DEPENDS_HOST="bcm2835-driver bzip2 Python zlib:host zlib libpng tiff dbus glib fontconfig eglibc liberation-fonts-ttf font-util font-xfree86-type1 font-misc-misc"
		PKG_BUILD_DEPENDS_HOST="bcm2835-driver bzip2 Python zlib:host zlib libpng tiff dbus glib fontconfig mysql openssl linux-headers eglibc"
	;;
esac

PKG_PRIORITY="optional"
PKG_SECTION="lib"
PKG_SHORTDESC="qt5 library"
PKG_LONGDESC="qt5 library and components"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

#pre_unpack(){
#}

unpack(){
	tar -xzf $SOURCES/${PKG_NAME}/qt-everywhere-opensource-src-${PKG_VERSION}.tar.gz -C $BUILD/
	mv $BUILD/qt-everywhere-opensource-src-${PKG_VERSION} $BUILD/${PKG_NAME}-${PKG_VERSION}
}

#post_unpack){
#}
#pre_patch){
#}
#post_patch){
#}

#pre_build_target() {
#}

#pre_configure_target(){
#}

configure_host(){

	cd $ROOT/$BUILD/${PKG_NAME}-${PKG_VERSION}
	
	export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$SYSROOT_PREFIX/lib/pkgconfig"
	
	unset CC CXX AR OBJCOPY STRIP CFLAGS CXXFLAGS CPPFLAGS LDFLAGS LD RANLIB
	export QT_FORCE_PKGCONFIG=yes
	unset QMAKESPEC
	
	mkdir -p $SYSROOT_PREFIX/usr
	
	case $TARGET_ARCH in
		i386)
			export QMAKE_INCDIR_OPENGL=$SYSROOT_PREFIX/
			export QMAKE_LIBDIR_OPENGL=$SYSROOT_PREFIX/
			#QMAKE_LIBS_OPENGL=$SYSROOT_PREFIX/
	
			./configure  	-prefix $SYSROOT_PREFIX/usr \
					-release \
					-opensource \
					-confirm-license \
					-opengl \
					-no-pch \
					-optimized-qmake \
					-make libs \
					-make examples \
					-nomake tests 
		;;
		x86_64)
			export QMAKE_INCDIR_OPENGL=$SYSROOT_PREFIX/usr/include/GL
			export QMAKE_LIBDIR_OPENGL=$SYSROOT_PREFIX/usr/lib
			#QMAKE_LIBS_OPENGL=$SYSROOT_PREFIX/
	
			./configure  	-prefix $SYSROOT_PREFIX/usr \
					-release \
					-opensource \
					-confirm-license \
					-no-pch \
					-opengl \
					-optimized-qmake \
					-make libs \
					-make examples \
					-nomake tests 
		;;
		arm)
			# need to copy platform_types.h to be recognized by EGL tests
			cp $SYSROOT_PREFIX/usr/include/interface/vcos/pthreads/vcos_platform_types.h $SYSROOT_PREFIX/usr/include/interface/vcos/
			cp $SYSROOT_PREFIX/usr/include/interface/vcos/pthreads/vcos_platform.h $SYSROOT_PREFIX/usr/include/interface/vcos/
			cp $SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux/vchost_config.h $SYSROOT_PREFIX/usr/include/interface/vmcs_host/
	
			#./configure  	-prefix $SYSROOT_PREFIX/usr \
			./configure  	\
					-release \
					-opensource \
					-confirm-license \
					-no-pch \
					-optimized-qmake \
					-compile-examples \
					-skip qtwebkit \
					-silent \
					-device linux-rasp-pi-g++ \
					-opengl \
					-device-option CROSS_COMPILE=$ROOT/$TOOLCHAIN/bin/armv6zk-openelec-linux-gnueabi- \
					-I $SYSROOT_PREFIX/usr/include/interface/vmcs_host \
					-make libs \
					-nomake examples \
					-nomake tests 
		;;
	esac
	
	
	
	#cd qtbase
	#make && make INSTALL_ROOT=$SYSROOT_PREFIX install
	
	#cd ../qtactiveqt
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtdoc
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtmultimedia
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtscript
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtserialport
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qttranslations
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtimageformats
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtsvg
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtjsbackend
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtscript
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtxmlpatterns
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtdeclarative
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtsensors
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qt3d
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtgraphicaleffects
	#../qtbase/bin/qmake && make && make install
	
	# does not exists yet
	#cd ../qtjsondb
	#../qtbase/bin/qmake && make && make install
	
	# missing qtgui and qtcore yet
	#cd ../qtlocation
	#../qtbase/bin/qmake && make && make install
	
	# does not exists yet
	#cd ../qtdocgallery
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtquick1
	#../qtbase/bin/qmake && make && make install
	
	#cd ../qtquickcontrols
	#../qtbase/bin/qmake && make && make install
	
	#$MAKEINSTALL


}

#post_configure_target(){
#}

#pre_make_target(){
#}

make_host(){

	cd $ROOT/$BUILD/${PKG_NAME}-${PKG_VERSION}
	make -j1 && make INSTALL_ROOT=$SYSROOT_PREFIX install
}

#post_make_target(){
#}

#pre_makeinstall_target(){
#}

makeinstall_host(){

	cd $ROOT/$BUILD/${PKG_NAME}-${PKG_VERSION}
	make INSTALL_ROOT=$SYSROOT_PREFIX install
}

#post_makeinstall_target(){
#}

