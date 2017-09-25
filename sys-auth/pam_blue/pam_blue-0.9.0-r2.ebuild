# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit pam autotools multilib

DESCRIPTION="Linux PAM module to authenticate via a bluetooth device"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/pam
	net-wireless/bluez"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

PATCHES=(
"${FILESDIR}/${P}-char-locales.patch" #412941
"${FILESDIR}/${P}-bad-log.patch"
)

src_prepare() {
	default
	mv configure.{in,ac} || die
	eautoreconf
}

src_configure() {
	econf --libdir="$(getpam_mod_dir)"
}

src_install() {
	# manual install to avoid sandbox violation and installing useless .la file
	dopammod src/.libs/pam_blue.so
	newpamsecurity . data/sample.conf bluesscan.conf.sample

	dodoc AUTHORS NEWS README ChangeLog
	doman doc/${PN}.7
}

pkg_postinst() {
	elog "For configuration info, see /etc/security/bluesscan.conf.sample"
	elog "Edit the file as required and copy/rename to bluesscan.conf when done."
}
