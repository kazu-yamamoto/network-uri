# -----------------------------------------------------------------------------
# $Id: Makefile,v 1.23 2005/03/02 16:39:57 ross Exp $

TOP=..
include $(TOP)/mk/boilerplate.mk

SUBDIRS		= include

ALL_DIRS	= Network
PACKAGE		= network
VERSION		= 1.0
PACKAGE_DEPS	= base parsec

SRC_HC_OPTS	+= -Iinclude -\#include HsNet.h
SRC_CC_OPTS     += -Iinclude -I. -I$(GHC_INCLUDE_DIR)
SRC_HSC2HS_OPTS += -Iinclude

Network/Socket_HC_OPTS += -cpp

EXTRA_SRCS += cbits/HsNet.c

# Only bother with cbits/initWinSock.c when it's really needed.
ifeq "$(TARGETPLATFORM)" "i386-unknown-mingw32"
EXTRA_SRCS += cbits/initWinSock.c cbits/winSockErr.c cbits/asyncAccept.c
Network/Socket_HC_OPTS += -DCALLCONV=stdcall
else
EXTRA_SRCS += cbits/ancilData.c
Network/Socket_HC_OPTS += -DCALLCONV=ccall
endif

SRC_HADDOCK_OPTS += -t "Haskell Core Libraries (network package)"

DIST_CLEAN_FILES += network.buildinfo config.cache config.status 
LATE_DIST_CLEAN_FILES += config.mk

include $(TOP)/mk/target.mk

