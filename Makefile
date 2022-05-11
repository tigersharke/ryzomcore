PORTNAME=	ryzomcore
DISTVERSION=	g20210913
CATEGORIES=	games
PKGNAMESUFFIX=	-dev
DISTNAME=	${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=	${PORTNAME}${PKGNAMESUFFIX}

MAINTAINER=	nope@nothere
COMMENT=	massively multiplayer online role-playing "sandbox" game (MMORPG)

LICENSE=	AGPLv3

LIB_DEPENDS=	libpng.so:graphics/png \
		libluabind.so:devel/luabind \
		libcurl.so:ftp/curl \
		libfreetype.so:print/freetype2 \
		libogg.so:audio/libogg \
                libvorbis.so:audio/libvorbis \
                libvorbisfile.so:audio/libvorbis \
		librrd.so:databases/rrdtool

USES=		linux cmake compiler:c++14-lang iconv:wchar_t pgsql sqlite jpeg gnome qt:5 xorg gl #ssl zlib icu
USE_LINUX=	icu dri libdrm libglvnd xorglibs
USE_GL=		gl
USE_XORG=	xxf86vm x11
USE_GNOME=	gvfs libxml2
#USE_LDCONFIG=   yes

BUILD_DEPEND=	cpptest>0:devel/cpptest
USE_GITHUB=     nodefault
GH_ACCOUNT=     ryzom
GH_PROJECT=     ryzomcore
GH_TAGNAME=	72ccfc9a0238a7aa114750840371928ae035abe6

CMAKE_ARGS=	-DBUILD_UNITTESTS="OFF" \
		-DWITH_GUI="ON" \
		-DWITH_QT5="ON" \
                -DCMAKE_BUILD_TYPE="MinSizeRel" \
                -DCUSTOM_EXAMPLE_CONF_DIR="${PREFIX}/etc" \
                -DCUSTOM_MANDIR="${PREFIX}/man" \
                -DOPENGL_xmesa_INCLUDE_DIR="${PREFIX}/lib" \
		-DWITH_EXTERNAL="ON" \
		-DWITH_INSTALL_LIBRARIES="OFF" \
		-DWITH_NEL="ON" \
		-DWITH_NEL_SAMPLES="OFF" \
		-DWITH_NEL_TESTS="OFF" \
		-DWITH_NEL_TOOLS="OFF" \
		-DWITH_RYZOM_SERVER="OFF" \
		-DWITH_RYZOM_TOOLS="OFF" \
		-DFINAL_VERSION="OFF" \
		-DWITH_3D="ON" \
		-DWITH_DRIVER_OPENGL="ON" \
		-DOPENGL_GL_PREFERENCE="GLVND" \
		-DWITH_SOUND="ON" \
		-DWITH_DRIVER_OPENAL="ON" \
		-DWITH_RYZOM_CLIENT="ON" \
		-DWITH_RYZOM="ON"
#CONFIGURE_ENV=

WRKSRC=	${WRKDIR}/${PORTNAME}-${GH_TAGNAME}/code

#post-patch:
#	@${REINPLACE_CMD} -e 's|/proc|/compat/linux/proc|g' \
#		${WRKSRC}/nel/src/misc/system_info.cpp

#USES=           compiler:c++11-lang gl qmake qt:5 xorg
#USE_GITHUB=     yes
#GH_ACCOUNT=     Fushko
#USE_GL=         gl
#USE_QT=         core dbus gui widgets \
#                buildtools_build qmake_build
#USE_XORG=       x11 xext xxf86vm
#
# curl freetype2 libx11 mesa libxxf86vm openal freealut libogg libvorbis \
# libxml2 cmake libpng libjpeg rrdtool bison libwww boost
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#-- The CXX compiler identification is Clang 13.0.0
#-- The C compiler identification is Clang 13.0.0
#-- Detecting CXX compiler ABI info
#-- Detecting CXX compiler ABI info - done
#-- Check for working CXX compiler: /usr/local/libexec/ccache/c++ - skipped
#-- Detecting CXX compile features
#-- Detecting CXX compile features - done
#-- Detecting C compiler ABI info
#-- Detecting C compiler ABI info - done
#-- Check for working C compiler: /usr/local/libexec/ccache/cc - skipped
#-- Detecting C compile features
#-- Detecting C compile features - done
#-- Using Clang 13.0.0 compiler
#-- Generating Ninja project
#Using RYZOM_LIVE urls
#-- Found external: /usr
#-- Looking for pthread.h
#-- Looking for pthread.h - found
#-- Found Threads: TRUE  
#-- Found ZLIB: /usr/lib/libz.so (found version "1.2.12") 
#-- Found LibXml2: /usr/local/lib/libxml2.so (found version "2.9.13") 
#-- Found PNG: /usr/local/lib/libpng.so (found version "1.6.37+apng") 
#-- Found OpenSSL: /usr/lib/libcrypto.so (found version "1.1.1n")  
#-- Found GIF: /usr/local/lib/libgif.so (found version "5.2.1") 
#-- Found Jpeg: /usr/local/lib/libjpeg.so
#CMake Deprecation Warning at CMakeModules/GetRevision.cmake:1 (CMAKE_MINIMUM_REQUIRED):
#  Compatibility with CMake < 2.8.12 will be removed from a future version of
#  CMake.
#
#  Update the VERSION argument <min> value or use a ...<max> suffix to tell
#  CMake that the project does not need compatibility with older versions.
#Call Stack (most recent call first):
#  CMakeModules/ConfigureChecks.cmake:2 (INCLUDE)
#  CMakeLists.txt:156 (NL_CONFIGURE_CHECKS)
#
#
#CMake Deprecation Warning at CMakeModules/FindHelpers.cmake:759 (CMAKE_MINIMUM_REQUIRED):
#  Compatibility with CMake < 2.8.12 will be removed from a future version of
#  CMake.
#
#  Update the VERSION argument <min> value or use a ...<max> suffix to tell
#  CMake that the project does not need compatibility with older versions.
#Call Stack (most recent call first):
#  CMakeLists.txt:241 (FIND_QT5)
#
#
#-- Found Qt 5.15.2 shared version
#-- Found Luabind: /usr/local/lib/libluabind.so
#-- Found Boost: /usr/local/include (found version "1.72.0")  
#-- Luabind is using Lua 5.1
#-- Found Lua51: /usr/local/lib/liblua-5.1.so;/usr/lib/libm.so (found version "5.1.5") 
#-- Found Luabind: /usr/local/lib/libluabind.so
#-- Found CURL: /usr/local/lib/libcurl.so (found version "7.83.0")  
#-- Found FreeType: /usr/local/lib/libfreetype.so
#-- Found Ogg: /usr/local/lib/libogg.so
#-- Found Vorbis: /usr/local/lib/libvorbis.so
#-- Found VorbisFile: /usr/local/lib/libvorbisfile.so
#-- Found PkgConfig: /usr/local/bin/pkg-config (found version "1.8.0") 
#-- Checking for module 'libavcodec'
#--   Found libavcodec, version 58.134.100
#-- Checking for module 'libavformat'
#--   Found libavformat, version 58.76.100
#-- Checking for module 'libavdevice'
#--   Found libavdevice, version 58.13.100
#-- Checking for module 'libavutil'
#--   Found libavutil, version 56.70.100
#-- Checking for module 'libswscale'
#--   Found libswscale, version 5.9.100
#-- Checking for module 'libswresample'
#--   Found libswresample, version 3.9.100
#-- Checking for module 'libpostproc'
#--   Found libpostproc, version 55.9.100
#-- Found FFmpeg: /usr/local/lib/libavcodec.so;/usr/local/lib/libavformat.so;/usr/local/lib/libavutil.so;/usr/local/lib/libswresample.so  
#-- Found OpenAL: /usr/local/lib/libopenal.so  
#-- Found X11: /usr/local/include   
#-- Looking for XOpenDisplay in /usr/local/lib/libX11.so;/usr/local/lib/libXext.so
#-- Looking for XOpenDisplay in /usr/local/lib/libX11.so;/usr/local/lib/libXext.so - found
#-- Looking for gethostbyname
#-- Looking for gethostbyname - found
#-- Looking for connect
#-- Looking for connect - found
#-- Looking for remove
#-- Looking for remove - found
#-- Looking for shmat
#-- Looking for shmat - found
#-- Looking for IceConnectionNumber in ICE
#-- Looking for IceConnectionNumber in ICE - found
#-- Warning: Unable to find XF86VidMode!
#CMake Warning (dev) at /usr/local/share/cmake/Modules/FindOpenGL.cmake:315 (message):
#  Policy CMP0072 is not set: FindOpenGL prefers GLVND by default when
#  available.  Run "cmake --help-policy CMP0072" for policy details.  Use the
#  cmake_policy command to set the policy and suppress this warning.
#
#  FindOpenGL found both a legacy GL library:
#
#    OPENGL_gl_LIBRARY: /usr/local/lib/libGL.so
#
#  and GLVND libraries for OpenGL and GLX:
#
#    OPENGL_opengl_LIBRARY: /usr/local/lib/libOpenGL.so
#    OPENGL_glx_LIBRARY: /usr/local/lib/libGLX.so
#
#  OpenGL_GL_PREFERENCE has not been set to "GLVND" or "LEGACY", so for
#  compatibility with CMake 3.10 and below the legacy GL library will be used.
#Call Stack (most recent call first):
#  nel/src/3d/driver/opengl/CMakeLists.txt:11 (FIND_PACKAGE)
#This warning is for project developers.  Use -Wno-dev to suppress it.
#
#-- Found OpenGL: /usr/local/lib/libOpenGL.so   
#-- Found MySQL: /usr/local/include/mysql, /usr/local/lib/mysql/libmysqlclient.so;/usr/lib/libssl.so;/usr/lib/libcrypto.so
#-- Configuring done
#CMake Warning at CMakeModules/nel.cmake:30 (ADD_LIBRARY):
#  Cannot generate a safe linker search path for target nelgui because files
#  in some directories may conflict with libraries in implicit directories:
#
#    link library [libssl.so] in /usr/lib may be hidden by files in:
#      /usr/local/lib
#    link library [libcrypto.so] in /usr/lib may be hidden by files in:
#      /usr/local/lib
#
#  Some of these libraries may not be found correctly.
#Call Stack (most recent call first):
#  nel/src/gui/CMakeLists.txt:7 (NL_TARGET_LIB)
#
#
#CMake Warning at ryzom/client/src/CMakeLists.txt:77 (ADD_EXECUTABLE):
#  Cannot generate a safe linker search path for target ryzom_client because
#  files in some directories may conflict with libraries in implicit
#  directories:
#
#    link library [libssl.so] in /usr/lib may be hidden by files in:
#      /usr/local/lib
#    link library [libcrypto.so] in /usr/lib may be hidden by files in:
#      /usr/local/lib
#
#  Some of these libraries may not be found correctly.
#
#
#-- Generating done
#CMake Warning:
#  Manually-specified variables were not used by the project:
#
#    BUILD_UNITTESTS
#    CMAKE_VERBOSE_MAKEFILE
#    CUSTOM_EXAMPLE_CONF_DIR
#    CUSTOM_MANDIR
#    ICONV_INCLUDE_DIR
#    ICONV_LIBRARIES
#    ICONV_LIBRARY
#    LIBICONV_INCLUDE_DIR
#    LIBICONV_LIBRARIES
#    LIBICONV_LIBRARY
#    OPENGL_GL_PREFERENCE

.include <bsd.port.mk>
