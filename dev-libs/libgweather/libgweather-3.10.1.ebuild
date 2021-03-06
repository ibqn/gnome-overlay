# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgweather/libgweather-3.8.2.ebuild,v 1.3 2013/08/30 21:14:23 eva Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2 vala

DESCRIPTION="Library to access weather information from online services"
HOMEPAGE="https://live.gnome.org/LibGWeather"

LICENSE="GPL-2+"
SLOT="2/3-3" # subslot = 3-(libgweather-3 soname suffix)
IUSE="+introspection +vala"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"

COMMON_DEPEND="
	>=x11-libs/gtk+-2.90.0:3[introspection?]
	>=dev-libs/glib-2.35.1:2
	>=net-libs/libsoup-2.34:2.4
	>=dev-libs/libxml2-2.6.0
	>=sys-libs/timezone-data-2010k

	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
"
RDEPEND="${COMMON_DEPEND}
	!<gnome-base/gnome-applets-2.22.0
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-doc-am-1.11
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
	vala? ( $(vala_depend) ) 
"

src_configure() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS"
	gnome2_src_configure \
		--enable-locations-compression \
		--disable-static \
		$(use_enable introspection)
		$(use_enable vala)
}
