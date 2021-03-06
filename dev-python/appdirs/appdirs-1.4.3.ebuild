# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="Module for determining appropriate platform-specific dirs"
HOMEPAGE="https://github.com/ActiveState/appdirs"
SRC_URI="https://github.com/ActiveState/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x64-cygwin ~amd64-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

PATCHES=( "${FILESDIR}"/${PN}-1.4.3-distutils.patch )

python_test() {
	"${PYTHON}" test/test_api.py || die "Tests fail with ${EPYTHON}"
}

[[ ${PV} == 1.4.3 ]] || die "Please remove pkg_preinst from the ebuild"
pkg_preinst() {
	_remove_egg_info() {
		local pyver="$("${PYTHON}" -c 'import sys; print(sys.version[:3])')"
		local egginfo="${ROOT%/}$(python_get_sitedir)/${P}-py${pyver}.egg-info"
		if [[ -d ${egginfo} ]]; then
			einfo "Removing ${egginfo}"
			rm -r "${egginfo}" || die
		fi
	}
	python_foreach_impl _remove_egg_info
}
