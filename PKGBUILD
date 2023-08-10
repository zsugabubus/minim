pkgname=minim
pkgver=0
pkgrel=1
pkgdesc='Bare bones image viewer'
arch=(any)
license=(MIT)
depends=(luajit efl)
optdepends=('ffmpeg: more formats')
source=('git+https://github.com/zsugabubus/minim')
sha256sums=(SKIP)

pkgver() {
	git -C "$pkgname" log -1 --format=%cs+%h | tr -d -
}

package() {
	cd "$pkgname"
	DESTDIR="$pkgdir" PREFIX=/usr ./install
}
