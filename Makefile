prefix = /usr/local
modulesdir = $(prefix)/share/eselect/modules

install:
	install -m 644 net.eselect $(DESTDIR)$(modulesdir)/
	mkdir -vp /etc/eselect/net/devs
	mkdir -vp /etc/eselect/net/conf.d
