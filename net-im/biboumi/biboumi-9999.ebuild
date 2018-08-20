# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="An XMPP gateway that connects to IRC servers"
HOMEPAGE="https://lab.louiz.org/louiz/biboumi"
LICENSE="ZLIB"
SLOT="0"
IUSE="postgres sqlite"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://lab.louiz.org/louiz/biboumi.git"
	inherit git-r3
else
	SRC_URI="https://lab.louiz.org/louiz/${PN}/-/archive/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DEPEND="
	dev-libs/expat
	net-dns/c-ares:=
	net-dns/libidn:=
	net-im/jabber-base
	dev-libs/botan:=
	net-libs/udns
	virtual/libiconv
	postgres? ( dev-db/postgresql:= )
	sqlite? ( dev-db/sqlite:3 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_POSTGRESQL="$(usex postgres)"
		-DWITHOUT_POSTGRESQL="$(usex !postgres)"
		-DWITH_SQLITE3="$(usex sqlite)"
		-DWITHOUT_SQLITE3="$(usex !sqlite)"
		-DSERVICE_USER="jabber"
		-DSERVICE_GROUP="jabber"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	newinitd "${FILESDIR}/${PN}".initd "${PN}"
	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}".logrotate "${PN}"

	for dir in /var/log/biboumi /var/lib/biboumi
	do
		keepdir $dir
		fowners jabber:jabber $dir
		fperms u=rwx,g=rx,o= $dir
	done
}
