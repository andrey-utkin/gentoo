# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 python3_5 )

inherit distutils-r1 versionator

DESCRIPTION="An interactive, SSL-capable, man-in-the-middle HTTP proxy"
HOMEPAGE="http://mitmproxy.org/"
SRC_URI="https://github.com/mitmproxy/mitmproxy/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-python/backports-ssl-match-hostname-3.5.0.1[${PYTHON_USEDEP}]
	>=dev-python/blinker-1.4[${PYTHON_USEDEP}]
	>=dev-python/brotlipy-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/certifi-2015.11.20.1[${PYTHON_USEDEP}]
	>=dev-python/click-6.2[${PYTHON_USEDEP}]
	>=dev-python/configargparse-0.10[${PYTHON_USEDEP}]
	>=dev-python/construct-2.5.2[${PYTHON_USEDEP}]
	>=dev-python/cryptography-1.3[${PYTHON_USEDEP}]
	>=dev-python/cssutils-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/flask-0.10.1[${PYTHON_USEDEP}]
	>=dev-python/hyper-h2-2.5.0[${PYTHON_USEDEP}]
	>=dev-python/html2text-2016.1.8[${PYTHON_USEDEP}]
	>=dev-python/hyperframe-4.0.1[${PYTHON_USEDEP}]
	>=dev-python/jsbeautifier-1.6.3[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/passlib-1.6.5[${PYTHON_USEDEP}]
	>=dev-python/pillow-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-16.0[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.1.3[${PYTHON_USEDEP}]
	>=dev-python/pyperclip-1.5.22[${PYTHON_USEDEP}]
	>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-1.5.4[${PYTHON_USEDEP}]
	>=dev-python/urwid-1.3.1[${PYTHON_USEDEP}]
	>=dev-python/watchdog-0.8.3[${PYTHON_USEDEP}]
	>=www-servers/tornado-4.3[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}
