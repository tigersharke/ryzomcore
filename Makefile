PORTNAME=	ryzomcore
DISTVERSION=	g20220124
CATEGORIES=	games
PKGNAMESUFFIX=	-dev
DISTNAME=	${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=	${PORTNAME}${PKGNAMESUFFIX}

MAINTAINER=	nope@nothere
COMMENT=	Massively multiplayer online role-playing "sandbox" game (MMORPG)

LICENSE=	AGPLv3

LIB_DEPENDS=	libpng.so:graphics/png \
		libluabind.so:devel/luabind \
		libluajit-5.1.so:lang/luajit-openresty \
		libcurl.so:ftp/curl \
		libfreetype.so:print/freetype2 \
		libogg.so:audio/libogg \
		libvorbis.so:audio/libvorbis \
		libvorbisfile.so:audio/libvorbis \
		librrd.so:databases/rrdtool \
		libboost_system.so:devel/boost-libs

#USES=		linux cmake compiler:c++14-lang
#USES=		cmake compiler:c++14-lang gnome pathfix
#USES=		linux cmake compiler:c++14-lang gnome pathfix libtool shebangfix desktop-file-utils gettext iconv localbase
USES=		cmake compiler:c++14-lang gnome pathfix libtool shebangfix desktop-file-utils gettext iconv localbase
#USE_LINUX=	icu dri libdrm libglvnd xorglibs openssl libpciaccess devtools
USE_GL=		gl
USE_XORG=	xxf86vm x11
USE_GNOME=	gvfs libxml2 gtk20 introspection gnomeprefix dconf
USE_LDCONFIG=   yes

BUILD_DEPEND=	cpptest>0:devel/cpptest
USE_GITHUB=     nodefault
GH_ACCOUNT=     ryzom
GH_PROJECT=     ryzomcore
GH_TAGNAME=	3f1f46bc7d006d6518a45aa9c6dde36cdf1039b1

CMAKE_ARGS=	-DWITH_GUI="ON" \
		-DWITH_QT5="OFF" \
		-DCMAKE_BUILD_TYPE="MinSizeRel" \
		-DOPENGL_xmesa_INCLUDE_DIR="${PREFIX}/lib" \
		-DWITH_EXTERNAL="ON" \
		-DWITH_INSTALL_LIBRARIES="ON" \
		-DWITH_NEL="ON" \
		-DWITH_NEL_SAMPLES="OFF" \
		-DWITH_NEL_TESTS="ON" \
		-DWITH_NEL_TOOLS="ON" \
		-DWITH_RYZOM_SERVER="ON" \
		-DWITH_RYZOM_TOOLS="ON" \
		-DFINAL_VERSION="OFF" \
		-DWITH_3D="ON" \
		-DWITH_DRIVER_OPENGL="ON" \
		-DWITH_SOUND="OFF" \
		-DWITH_DRIVER_OPENAL="OFF" \
		-DWITH_RYZOM_CLIENT="ON" \
		-DWITH_RYZOM="ON" \
		-DWITH_LUA51="OFF"
CONFIGURE_ARGS+=--with-lib-prefix=${LOCALBASE}
CONFIGURE_ENV=	OpenGL_GL_PREFERENCE="GLVND" EXTRA_LIBS="-lexecinfo"

WRKSRC=	${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

CFLAGS+=	-I${LOCALBASE}/include
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib -I${LOCALBASE}/include -lexecinfo -lpthread -lm
LIBS+=          -L${LOCALBASE}/lib -I${LOCALBASE}/include -lexecinfo

post-patch:
	@${REINPLACE_CMD} -e 's|<sys/vfs.h>|<sys/statvfs.h>|g' ${WRKSRC}/nel/src/misc/system_info.cpp
	@${REINPLACE_CMD} -e 's|statfs|statvfs|g' ${WRKSRC}/nel/src/misc/system_info.cpp
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
