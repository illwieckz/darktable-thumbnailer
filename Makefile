.DEFAULT_GOAL := build
.PHONY: build install checkinstall uninstall

PREFIX := /usr

build:

install:
	install -m +r,u+w src/darktable.thumbnailer ${PREFIX}/share/thumbnailers/darktable.thumbnailer
	install -m +rx,u+w src/darktable-thumbnailer ${PREFIX}/bin/darktable-thumbnailer

checkinstall:
	mkdir -p build
	fakeroot checkinstall \
		--default \
		--fstrans='yes' \
		--install='no' \
		--maintainer="$(whoami)" \
		--pkgname="darktable-thumbnailer" \
		--pkglicense='MIT' \
		--pkgversion="0~$(shell git log -1 --format=%at | xargs -I{} date -d '@{}' '+%Y%m%d-%H%M%S')~$(shell git log --format="%H" -n 1 | cut -c1-7)" \
		--pkgrelease="$(shell date --utc '+%Y%m%d-%H%M%S')" \
		--pkgsource="$(shell git remote get-url origin)" \
		--pakdir='build' \
		--nodoc \
		--backup='no'
uninstall:
	rm ${PREFIX}/share/thumbnailers/darktable.thumbnailer
	rm ${PREFIX}/bin/darktable-thumbnailer

update-db:
	update-mime-database ${PREFIX}/share/mime
