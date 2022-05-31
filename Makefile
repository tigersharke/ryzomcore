PORTNAME=	ryzomcore
DISTVERSION=	g20220512
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

USES=		shebangfix linux cmake compiler:c++14-lang iconv:wchar_t pgsql sqlite jpeg gnome qt:5 xorg gl pkgconfig #localbase:ldflags #ssl zlib icu
USE_LINUX=	icu dri libdrm libglvnd xorglibs jpeg png
USE_GL=		gl
USE_XORG=	xxf86vm x11
USE_GNOME=	gvfs libxml2
#USE_LDCONFIG=   yes

BUILD_DEPEND=	cpptest>0:devel/cpptest
USE_GITHUB=     nodefault
GH_ACCOUNT=     ryzom
GH_PROJECT=     ryzomcore
GH_TAGNAME=	0ee0f897353f1d1ee24e184a0ae230bec5aa3b5a

#CMAKE_ARGS=	-DBUILD_UNITTESTS="OFF" \
#		-DWITH_GUI="ON" \
#		-DWITH_QT5="ON" \
#		-DCMAKE_BUILD_TYPE="MinSizeRel" \
#		-DOPENGL_xmesa_INCLUDE_DIR="${PREFIX}/lib" \
#		-DWITH_EXTERNAL="ON" \
#		-DWITH_INSTALL_LIBRARIES="OFF" \
#		-DWITH_NEL="OFF" \
#		-DWITH_NEL_SAMPLES="OFF" \
#		-DWITH_NEL_TESTS="OFF" \
#		-DWITH_NEL_TOOLS="OFF" \
#		-DWITH_RYZOM_SERVER="OFF" \
#		-DWITH_RYZOM_TOOLS="OFF" \
#		-DFINAL_VERSION="OFF" \
#		-DWITH_3D="ON" \
#		-DWITH_DRIVER_OPENGL="ON" \
#		-DWITH_SOUND="ON" \
#		-DWITH_DRIVER_OPENAL="ON" \
#		-DWITH_RYZOM_CLIENT="ON" \
#		-DWITH_RYZOM="ON"
#CMAKE_ARGS+=	-DWITH_RYZOM_CLIENT=ON \
#		-DWITH_STATIC=ON \
#		-DWITH_STATIC_DRIVERS=ON \
#		-DWITH_DRIVER_OPENGL=ON \
#		-DWITH_QT=OFF \
#		-DWITH_NEL_TESTS=OFF \
#		-DWITH_RYZOM_SERVER=OFF \
#		-DWITH_NEL_SAMPLES=OFF \
#		-DWITH_SNOWBALLS=OFF \
#		-DWITH_NEL_TOOLS=OFF \
#		-DWITH_RYZOM_TOOLS=OFF \
#		-DWITH_RYZOM_PATCH=ON
CMAKE_ARGS+=	-DCMAKE_BUILD_TYPE=Release \
		-DWITH_STATIC=ON \
		-DWITH_STATIC_DRIVERS=ON \
		-DWITH_NEL_TOOLS=OFF \
		-DWITH_NEL_SAMPLES=OFF \
		-DWITH_NEL_TESTS=OFF \
		-DWITH_RYZOM_SERVER=OFF \
		-DWITH_RYZOM_TOOLS=OFF \
		-DWITH_STATIC_EXTERNAL=ON \
		-DWITH_LUA53=ON \
		-DWITH_LUA51=OFF \
		-DWITH_RYZOM_PATCH=ON

# from https://forge.ryzom.com/wiki/Building_Ryzom_Client_On_Mac_OS_X
#-DCMAKE_BUILD_TYPE=Release -DWITH_STATIC=ON -DWITH_STATIC_DRIVERS=ON -DWITH_NEL_TOOLS=OFF -DWITH_NEL_SAMPLES=OFF
#-DWITH_NEL_TESTS=OFF -DWITH_RYZOM_SERVER=OFF -DWITH_RYZOM_TOOLS=OFF -DWITH_STATIC_EXTERNAL=ON -DWITH_LUA53=ON -DWITH_LUA51=OFF -DWITH_RYZOM_PATCH=ON
#
# from https://en.wiki.ryzom.com/wiki/Building_Ryzom_Client_On_Debian -- under building Ryzom dynamically linked
# -DWITH_RYZOM_CLIENT=ON -DWITH_STATIC=ON -DWITH_STATIC_DRIVERS=ON -DWITH_DRIVER_OPENGL=ON -DWITH_QT=OFF -DWITH_NEL_TESTS=OFF
# -DWITH_RYZOM_SERVER=OFF -DWITH_NEL_SAMPLES=OFF -DWITH_SNOWBALLS=OFF -DWITH_NEL_TOOLS=OFF -DWITH_RYZOM_TOOLS=OFF -DWITH_RYZOM_PATCH=ON

WRKSRC=	${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

CFLAGS+=	-I${LOCALBASE}/include -lexecinfo
CPPFLAGS+=	-I${LOCALBASE}/include -lexecinfo -I${LOCALBASE}/include/jpeglib.h
LDFLAGS+=	-L${LOCALBASE}/lib -I${LOCALBASE}/include -I${LOCALBASE}/include/jpeglib.h -lexecinfo -lpthread
LIBS+=		-L${LOCALBASE}/lib -I${LOCALBASE}/include -lexecinfo

#post-patch:
#	@${REINPLACE_CMD} -e 's|<sys/vfs.h>|<sys/statvfs.h>|g' ${WRKSRC}/nel/src/misc/system_info.cpp
#	@${REINPLACE_CMD} -e 's|statfs|statvfs|g' ${WRKSRC}/nel/src/misc/system_info.cpp
#	@${REINPLACE_CMD} -e 's|/proc|/compat/linux/proc|g' ${WRKSRC}/nel/src/misc/system_info.cpp
#	@${REINPLACE_CMD} -e 's|<sys/vfs.h>|<sys/statvfs.h>|g' ${WRKSRC}/nel/src/misc/system_info.cpp
#	@${REINPLACE_CMD} -e 's|<sys/vfs.h>|<sys/statvfs.h>|g' ${WRKSRC}/src/gui_main.c

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
