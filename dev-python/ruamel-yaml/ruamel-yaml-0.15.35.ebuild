# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="YAML parser/emitter that supports roundtrip comment preservation"
HOMEPAGE="https://pypi.python.org/pypi/ruamel.yaml https://bitbucket.org/ruamel/yaml"
MY_PN="${PN//-/.}"
SRC_URI="https://bitbucket.org/${MY_PN/.//}/get/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libyaml test"
REQUIRED_USE="${PYTHON_REQUIRED_USE} test? ( libyaml )"
# ^ tests can't be properly unbundled from the libyaml c-extension

RDEPEND="
	${PYTHON_DEPS}
	libyaml? ( dev-libs/libyaml )
	$(python_gen_cond_dep 'dev-python/ruamel-ordereddict[${PYTHON_USEDEP}]' python2_7)
"
DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/ruamel-std-pathlib[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_PN}-${PV}"

python_configure_all() {
	use libyaml || sed -i -e 's|\(ext_modules\)|no_\1|' __init__.py || die
}

python_install() {
	distutils-r1_python_install --single-version-externally-managed
	find "${ED}" -name '*.pth' -delete || die
}

python_test() {
	py.test -v _test/test_*.py || die
}
