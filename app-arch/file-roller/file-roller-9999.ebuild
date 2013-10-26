# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2
if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

DESCRIPTION="Archive manager for GNOME"
HOMEPAGE="http://fileroller.sourceforge.net/"

LICENSE="GPL-2+ CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
IUSE="nautilus packagekit"
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~arm ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
fi

# gdk-pixbuf used extensively in the source
# cairo used in eggtreemultidnd.c
# pango used in fr-window
RDEPEND=">=dev-libs/glib-2.29.14:2
	sys-apps/file
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
	x11-libs/libSM
	x11-libs/libICE
	>=x11-libs/gtk+-3.4:3
	>=app-arch/libarchive-3:=
	>=x11-libs/libnotify-0.4.3:=
	>=dev-libs/json-glib-0.14
	nautilus? ( >=gnome-base/nautilus-3 )
	packagekit? ( app-admin/packagekit-base )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.0
	sys-devel/gettext
	virtual/pkgconfig"
# eautoreconf needs:
#	gnome-base/gnome-common

if [[ ${PV} = 9999 ]]; then
	DEPEND="${DEPEND}
		app-text/yelp-tools"
fi

src_prepare() {
	# --disable-debug because enabling it adds -O0 to CFLAGS
	G2CONF="${G2CONF}
		--disable-dependency-tracking
		--disable-run-in-place
		--disable-static
		--disable-debug
		--enable-magic
		--enable-libarchive
		--with-smclient=xsmp
		$(use_enable nautilus nautilus-actions)
		$(use_enable packagekit)"
	[[ ${PV} != 9999 ]] && G2CONF="${G2CONF} ITSTOOL=$(type -P true)"
	DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"

	gnome2_src_prepare

	# Use absolute path to GNU tar since star doesn't have the same
	# options. On Gentoo, star is /usr/bin/tar, GNU tar is /bin/tar
	epatch "${FILESDIR}"/${PN}-2.10.3-use_bin_tar.patch

	# File providing Gentoo package names for various archivers
	cp -f "${FILESDIR}/3.6.0-packages.match" data/packages.match || die
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog "${PN} is a frontend for several archiving utilities. If you want a"
	elog "particular achive format support, see ${HOMEPAGE}"
	elog "and install the relevant package."
	elog
	elog "for example:"
	elog "  7-zip   - app-arch/p7zip"
	elog "  ace     - app-arch/unace"
	elog "  arj     - app-arch/arj"
	elog "  cpio    - app-arch/cpio"
	elog "  deb     - app-arch/dpkg"
	elog "  iso     - app-cdr/cdrtools"
	elog "  jar,zip - app-arch/zip and app-arch/unzip"
	elog "  lha     - app-arch/lha"
	elog "  lzop    - app-arch/lzop"
	elog "  rar     - app-arch/unrar or app-arch/unar"
	elog "  rpm     - app-arch/rpm"
	elog "  unstuff - app-arch/stuffit"
	elog "  zoo     - app-arch/zoo"
}
