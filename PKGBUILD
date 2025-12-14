# Maintainer: Your Name <your.email@example.com>
pkgname=pacboof
pkgver=1.0.0
pkgrel=1
pkgdesc="Simple rofi-based package manager for Arch Linux"
arch=('any')
url="https://github.com/benevolentshrine/pacboof"
license=('MIT')
depends=('bash' 'rofi' 'pacman' 'fzf' 'yay')
optdepends=(
    'paru: Alternative AUR helper'
)
source=("pacboof"
        "pacboof.rasi"
        "pacboof.desktop"
        "LICENSE")
sha256sums=('SKIP' 'SKIP' 'SKIP' 'SKIP')

package() {
    # Install main script
    install -Dm755 "$srcdir/pacboof" "$pkgdir/usr/bin/pacboof"
    
    # Install theme
    install -Dm644 "$srcdir/pacboof.rasi" "$pkgdir/usr/share/pacboof/pacboof.rasi"
    
    # Install desktop file
    install -Dm644 "$srcdir/pacboof.desktop" "$pkgdir/usr/share/applications/pacboof.desktop"
    
    # Install license
    install -Dm644 "$srcdir/LICENSE" "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
