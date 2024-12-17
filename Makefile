PORTNAME=	ryzomcore
DISTVERSION=    g20240828
CATEGORIES=	games
MASTER_SITES=   GH
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

#USES=		lua:51-54 shebangfix cmake compiler:c++11-lang iconv pgsql sqlite jpeg gnome qt:5 xorg gl pkgconfig
USES=		lua:51-54 shebangfix cmake compiler:c++14-lang iconv pgsql sqlite jpeg gnome qt:5 xorg gl pkgconfig
#USES=		shebangfix linux cmake compiler:c++14-lang iconv:wchar_t pgsql sqlite jpeg gnome qt:5 xorg gl pkgconfig
#USE_LINUX=	icu dri libdrm libglvnd xorglibs
USE_GL=		gl
USE_XORG=	xxf86vm x11
USE_GNOME=	libxml2 #gvfs
#USE_LDCONFIG=   yes

BUILD_DEPEND=	cpptest>0:devel/cpptest
USE_GITHUB=     nodefault
GH_ACCOUNT=     ryzom
GH_PROJECT=     ryzomcore
GH_TAGNAME=     ab658856d6f26b73acf20387b96b0f56e17f5f8d

CMAKE_ARGS=	-DCMAKE_BUILD_TYPE="Release" \
			-DWITH_STATIC="OFF" \
			-DBUILD_UNITTESTS="OFF" \
			-DWITH_RYZOM_CORE="ON" \
			-DWITH_RYZOM_CLIENT="ON" \
			-DWITHDRIVER_OPENAL="ON" \
			-DWITH_DRIVER_OPENGL="ON" \
			-DWITH_NEL_TESTS="OFF" \
			-DWITH_RYZOM_SERVER="OFF" \
			-DWITH_NEL_SAMPLES="OFF" \
			-DWITH_SNOWBALLS="OFF" \
			-DWITH_NEL_TOOLS="OFF" \
			-DWITH_RYZOM_TOOLS="OFF" \
			-DWITH_RYZOM_PATCH="OFF" \
			-DWITH_FFMPEG="ON" \
			-DWITH_LUA54="ON" \
			-DWITH_3D="OFF" \
			-DWITH_GEORGES="OFF" \
			-DWITH_SOUND="ON" \
			-DWITH_STATIC_CURL="OFF" \
			-DWITH_STATIC_DRIVERS="OFF" \
			-DWITH_STATIC_EXTERNAL="OFF" \
			-DWITH_STATIC_LIBXML2="OFF" \
			-DWITH_STATIC_RUNTIMES="OFF"

CONFIGURE_ARGS+=--with-lib-prefix=${LOCALBASE}
WRKSRC=	${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

LDFLAGS+=	-L${LOCALBASE}/lib -I${LOCALBASE}/include -lpthread -lm

post-patch:
	@${REINPLACE_CMD} -e 's|<sys/vfs.h>|<sys/statvfs.h>|g' ${WRKSRC}/nel/src/misc/system_info.cpp
	@${REINPLACE_CMD} -e 's|statfs|statvfs|g' ${WRKSRC}/nel/src/misc/system_info.cpp
##	@${REINPLACE_CMD} -e 's|/proc|/compat/linux/proc|g' ${WRKSRC}/nel/src/misc/system_info.cpp
##	@${REINPLACE_CMD} -e 's|<sys/vfs.h>|<sys/statvfs.h>|g' ${WRKSRC}/nel/src/misc/system_info.cpp
##	@${REINPLACE_CMD} -e 's|<sys/vfs.h>|<sys/statvfs.h>|g' ${WRKSRC}/src/gui_main.c

#
# This will get to 15% compiled and throw another error related to things removed from clang which may be impossible to solve.
# Some of the patches cure the uint_t issue by converting to char16_t
.include <bsd.port.mk>
