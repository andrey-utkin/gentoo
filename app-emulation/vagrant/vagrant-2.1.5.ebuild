# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
USE_RUBY="ruby24 ruby25"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"
RUBY_FAKEGEM_GEMSPEC="vagrant.gemspec"
RUBY_FAKEGEM_EXTRAINSTALL="keys plugins templates version.txt"
RUBY_FAKEGEM_TASK_DOC=""

inherit bash-completion-r1 ruby-fakegem

DESCRIPTION="A tool for building and distributing development environments"
HOMEPAGE="https://vagrantup.com/"
SRC_URI="https://github.com/hashicorp/vagrant/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+virtualbox"
RESTRICT="test"

RDEPEND="${RDEPEND}
	app-arch/libarchive
	net-misc/curl
	virtualbox? ( || ( app-emulation/virtualbox app-emulation/virtualbox-bin ) )"

ruby_add_rdepend "
	>=dev-ruby/childprocess-0.6.0
	>=dev-ruby/erubis-2.7.0
	<dev-ruby/i18n-0.8.0:*
	>=dev-ruby/listen-3.1.5
	>=dev-ruby/hashicorp-checkpoint-0.1.5
	>=dev-ruby/log4r-1.1.9 <dev-ruby/log4r-1.1.11
	>=dev-ruby/net-ssh-5.0.0:*
	>=dev-ruby/net-sftp-2.1
	>=dev-ruby/net-scp-1.2.0
	dev-ruby/rest-client:2
	<dev-ruby/mime-types-3:*
"

# upstream specifies rake>=12 but it apparently doesn't need something this
# recent. Because vagrant builds fine with rake 10 and because stabilizing rake
# is tricky, we specify a lower dependency requirement here. This way, we'll be
# able to stabilize vagrant sooner.
ruby_add_bdepend "
	>=dev-ruby/rake-10.0.0
"

all_ruby_prepare() {
	# remove bundler support
	sed -i '/[Bb]undler/d' Rakefile || die
	rm Gemfile || die

	# loosen dependencies
	sed -e '/hashicorp-checkpoint\|listen\|net-ssh\|net-scp\|rake\|childprocess/s/~>/>=/' \
		-e '/ruby_dep/s/<=/>=/' \
		-i ${PN}.gemspec || die

	# remove windows-specific gems
	sed -e '/wdm\|winrm/d' \
		-i ${PN}.gemspec || die

	# remove bsd-specific gems
	sed -e '/rb-kqueue/d' \
		-i ${PN}.gemspec || die

	sed -e "s/@VAGRANT_VERSION@/${PV}/g" "${FILESDIR}/${PN}.in" > "${PN}" || die
}

all_ruby_install() {
	newbashcomp contrib/bash/completion.sh ${PN}
	all_fakegem_install

	# provide executable similar to upstream:
	# https://github.com/hashicorp/vagrant-installers/blob/master/substrate/modules/vagrant_installer/templates/vagrant.erb
	dobin "${PN}"

	# directory for plugins.json
	keepdir /var/lib/vagrant
}
