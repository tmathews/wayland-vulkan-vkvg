export PKG_CONFIG_PATH=/usr/local/share/pkgconfig

FILES=$(shell find src -type f -iname *.c -o -iname *.h)
INCLUDES=$(shell pkg-config -cflags vkvg)
LIBS=$(shell pkg-config -libs wayland-client vkvg vulkan)

build:
	cc -g -o vkvg-wayland $(FILES) $(INCLUDES) $(LIBS) -lm

wayland:
	wayland-scanner private-code \
		< /usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml \
		> src/xdg-shell-protocol.c
	wayland-scanner client-header \
		< /usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml \
		> src/xdg-shell-client-protocol.h
	wayland-scanner private-code \
		< /usr/share/wayland-protocols/unstable/xdg-decoration/xdg-decoration-unstable-v1.xml \
		> src/xdg-decoration-protocol.c
	wayland-scanner client-header \
		< /usr/share/wayland-protocols/unstable/xdg-decoration/xdg-decoration-unstable-v1.xml \
		> src/xdg-decoration-client-protocol.h

clean:
	rm -f src/*-protocol vkvg-wayland 

.PHONY: build wayland clean
