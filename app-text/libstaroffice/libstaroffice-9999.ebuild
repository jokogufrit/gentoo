# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGIT_REPO_URI="https://github.com/fosnola/libstaroffice.git"

[[ ${PV} == 9999 ]] && GITECLASS="git-r3 autotools"
inherit eutils ${GITECLASS}
unset GITECLASS

DESCRIPTION="Import filter for old StarOffice documents"
HOMEPAGE="https://github.com/fosnola/libstaroffice"
[[ ${PV} == 9999 ]] || SRC_URI="http://dev-www.libreoffice.org/src/${P}.tar.bz2"

LICENSE="|| ( LGPL-2.1+ MPL-2.0 )"
SLOT="0"
[[ ${PV} == 9999 ]] || \
KEYWORDS="~amd64 ~x86"

IUSE="debug doc tools +zlib"

RDEPEND="
	dev-libs/librevenge
	zlib? ( sys-libs/zlib )
"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
"

src_prepare() {
	default
	[[ ${PV} == 9999 ]] && eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_with doc docs) \
		$(use_enable tools) \
		$(use_enable zlib zip)
}

src_install() {
	default
	prune_libtool_files --all
}
