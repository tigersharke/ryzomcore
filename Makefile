PORTNAME=	ryzomcore
DISTVERSION=    g20220609
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

USES=		lua:51-54 shebangfix cmake compiler:c++11-lang iconv pgsql sqlite jpeg gnome qt:5 xorg gl pkgconfig
#USES=		lua:51-54 shebangfix cmake compiler:c++14-lang iconv pgsql sqlite jpeg gnome qt:5 xorg gl pkgconfig
#USES=		shebangfix linux cmake compiler:c++14-lang iconv:wchar_t pgsql sqlite jpeg gnome qt:5 xorg gl pkgconfig
#USE_LINUX=	icu dri libdrm libglvnd xorglibs
USE_GL=		gl
USE_XORG=	xxf86vm x11
USE_GNOME=	gvfs libxml2
#USE_LDCONFIG=   yes

BUILD_DEPEND=	cpptest>0:devel/cpptest
USE_GITHUB=     nodefault
GH_ACCOUNT=     ryzom
GH_PROJECT=     ryzomcore
GH_TAGNAME=     ad20f0cb92797c1e9e8a7c67bd0802369459a552

CMAKE_ARGS=	-DBUILD_UNITTESTS="OFF" \
		-DWITH_GUI="ON" \
		-DWITH_QT5="ON" \
                -DCMAKE_BUILD_TYPE="MinSizeRel" \
                -DOPENGL_xmesa_INCLUDE_DIR="${PREFIX}/lib" \
		-DWITH_EXTERNAL="ON" \
		-DWITH_INSTALL_LIBRARIES="ON" \
		-DWITH_NEL="ON" \
		-DWITH_NEL_SAMPLES="OFF" \
		-DWITH_NEL_TESTS="OFF" \
		-DWITH_NEL_TOOLS="OFF" \
		-DWITH_RYZOM_SERVER="OFF" \
		-DWITH_RYZOM_TOOLS="OFF" \
		-DFINAL_VERSION="ON" \
		-DWITH_3D="ON" \
		-DWITH_DRIVER_OPENGL="ON" \
		-DWITH_SOUND="ON" \
		-DWITH_DRIVER_OPENAL="ON" \
		-DWITH_RYZOM_CLIENT="ON" \
		-DWITH_RYZOM="ON" \
		-Wno-dev
CMAKE_ARGS+=	-DCMAKE_BUILD_TYPE=Release \
		-DWITH_LUA54="ON" \
		-DWITH_3D="OFF"
#CONFIGURE_ENV=	OPENGL_GL_PREFERENCE "GLVND"

WRKSRC=	${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

#CFLAGS+=	-lexecinfo
#CPPFLAGS+=	-I/usr/include -Wno-error=null-dereference -Wno-error=tautological-constant-out-of-range-compare -Wno-error=implicit-const-int-float-conversion
#CPPFLAGS+=	-std=gnu++11 -I/usr/include -Wno-error=null-dereference -Wno-error=tautological-constant-out-of-range-compare \
CPPFLAGS+=	-I/usr/include -Wno-error=null-dereference -Wno-error=tautological-constant-out-of-range-compare \
		-Wno-error=implicit-const-int-float-conversion -Wno-error=deprecated-register \
		-Wnoerror=no-unused-parameter -Wnoerror=no-unused-variable -Wnoerror=no-unused-function \
		-Wnoerror=no-unused-value -Wnoerror=no-unused-private-field -Wnoerror=no-unused-local-typedef
LDFLAGS+=	-L/usr/lib -I/usr/include -lpthread -lm
#LDFLAGS+=	-lexecinfo -lpthread
#LIBS+=          -lexecinfo

MAKE_JOBS_UNSAFE=yes

post-patch:
	@${REINPLACE_CMD} -e 's|<sys/vfs.h>|<sys/statvfs.h>|g' ${WRKSRC}/nel/src/misc/system_info.cpp
	@${REINPLACE_CMD} -e 's|statfs|statvfs|g' ${WRKSRC}/nel/src/misc/system_info.cpp
##	@${REINPLACE_CMD} -e 's|/proc|/compat/linux/proc|g' ${WRKSRC}/nel/src/misc/system_info.cpp
##	@${REINPLACE_CMD} -e 's|<sys/vfs.h>|<sys/statvfs.h>|g' ${WRKSRC}/nel/src/misc/system_info.cpp
##	@${REINPLACE_CMD} -e 's|<sys/vfs.h>|<sys/statvfs.h>|g' ${WRKSRC}/src/gui_main.c

# first two to test
# c++11-lib c++11-lang c++14-lang c++17-lang c11 features env nestedfct c++0x gcc-c++11-lib
#FAILS: nestedfct compiler:gcc-c++11-lib
#
# Regardless of above compiler option it seems to use c++17?
#Portion of warning message: storage class specifier is deprecated and incompatible with C++17
#
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

.include <bsd.port.mk>
