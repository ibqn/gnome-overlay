# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="A weather application for GNOME"
HOMEPAGE="https://live.gnome.org/Design/Apps/Weather"

LICENSE="GPL-2+ LGPL-2+ MIT CC-BY-3.0 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="
	dev-libs/gjs
	>=dev-libs/libgweather-3.9.5
	>=dev-libs/glib-2.32:2
	>=dev-libs/gobject-introspection-1.35.9
	x11-libs/gdk-pixbuf
	>=x11-libs/gtk+-3.9.4:3
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.26
	virtual/pkgconfig
"

src_prepare() {

	gnome2_src_prepare
}
