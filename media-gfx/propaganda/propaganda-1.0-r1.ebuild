# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
S="${WORKDIR}/Propaganda"
DESCRIPTION="Propaganda Volume 1-14 + E. Tiling images for your desktop"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SITE="mirror://gentoo/"
# Point to any required sources; these will be automatically
# downloaded by Portage.
SRC_URI="${SITE}Propaganda-Vol-01.tar.gz
	${SITE}Propaganda-Vol-02.tar.gz
	${SITE}Propaganda-Vol-03.tar.gz
	${SITE}Propaganda-Vol-04.tar.gz
	${SITE}Propaganda-Vol-05.tar.gz
	${SITE}Propaganda-Vol-06.tar.gz
	${SITE}Propaganda-Vol-07.tar.gz
	${SITE}Propaganda-Vol-08.tar.gz
	${SITE}Propaganda-Vol-09.tar.gz
	${SITE}Propaganda-Vol-10.tar.gz
	${SITE}Propaganda-Vol-11.tar.gz
	${SITE}Propaganda-Vol-12.tar.gz
	${SITE}Propaganda-13.tar.gz
	${SITE}Propaganda-14.tar.gz
	${SITE}Propaganda-For-E.tar.gz"

SLOT="0"
LICENSE="GPL-2+"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

src_compile() {
	mv "${S}/../Propaganda-Vol-11" "${S}/Vol11" || die
	mv "${S}/../Propaganda-Vol-12" "${S}/Vol12" || die

	rm -fr */.finderinfo */.resource || die
	rm */*.html || die
	rm COPYING */COPYING README-GPL */README-GPL || die
	rm "Vol2/@" || die

	for VOLUME in Vol* Propaganda-For-E; do
		pushd "$VOLUME" > /dev/null || die
		chmod -x * || die
		rename JPG jpg *.JPG
		chmod +x script.perl || die
		./script.perl *.jpg || die
		popd > /dev/null || die
	done
	chmod a-w,a+r -R "${S}" || die
}

src_install() {
	dodir /usr/share/pixmaps/
	gunzip magicbg.tar.gz || die
	dodoc README README-PROPAGANDA magicbg.tar
	mv -f "${S}" "${D}/usr/share/pixmaps" || die
}
