# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="Diagnostic and recovery tool for block devices"
HOMEPAGE="https://whdd.github.io"

if [[ ${PV} == 9999 ]]
then
	EGIT_REPO_URI="git://github.com/whdd/whdd.git"
	inherit git-r3
else
	SRC_URI="https://github.com/${PN}/${PN}/tarball/${PV} -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

	src_unpack() {
		default
		mv ${PN}-${PN}-* ${P}
		echo ${PV} > "${S}"/VERSION || die
	}
fi


LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-util/dialog
	sys-libs/ncurses[unicode]"
RDEPEND="${DEPEND}
	sys-apps/smartmontools"
