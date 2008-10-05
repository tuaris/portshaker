# $Id$

BINDIR?=	/bin
ETCDIR?=	/etc
.if defined(DESTDIR)
SHAREDIR?=	/share
MANDIR?=	/man/man
.endif

SCRIPTS=	portshaker.sh
VERSION=	0.0.2

MAN5=		portshaker.conf.5 portshaker.d.5
MAN8=		portshaker.8

FILES=		portshaker.conf.sample portshaker.subr
FILESDIR_portshaker.conf.sample=	${ETCDIR}
FILESDIR_portshaker.subr=		${SHAREDIR}/portshaker

CLEANFILES+=	portshaker.conf.5 portshaker.d.5 portshaker.8 portshaker.sh portshaker.subr

.SUFFIXES:	.5.in .5 .8.in .8 .sh.in .sh .subr.in .subr

.5.in.5 .8.in.8 .sh.in.sh .subr.in.subr:
	sed -e "s|@@DESTDIR@@|${DESTDIR}|" \
		-e "s|@@ETCDIR@@|${DESTDIR}${ETCDIR}|" \
		-e "s|@@SHAREDIR@@|${DESTDIR}${SHAREDIR}|" \
		< ${.IMPSRC} \
		> ${.TARGET}

beforeinstall:
	if [ ! -d "${DESTDIR}${SHAREDIR}/portshaker" ]; then mkdir -p "${DESTDIR}${SHAREDIR}/portshaker"; fi
	if [ ! -d "${DESTDIR}${ETCDIR}/portshaker.d" ]; then mkdir -p "${DESTDIR}${ETCDIR}/portshaker.d"; fi

.include <bsd.prog.mk>
