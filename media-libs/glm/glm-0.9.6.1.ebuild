# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="OpenGL Mathematics"
HOMEPAGE="http://glm.g-truc.net/"
SRC_URI="mirror://sourceforge/ogl-math/${P}.zip"

S="${WORKDIR}/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

src_install() {
	dodoc readme.txt doc/${PN}.pdf
	cd ${PN} || die
	insinto /usr/include/${PN}
	doins -r *.hpp detail gtc gtx
	rm "${ED}"usr/include/${PN}/detail/*.cpp || die
}
