prefix = /usr/local
modulesdir = $(prefix)/share/eselect/modules

.SILENT: all
all:
	echo "make install to install files"

install:
	install -m 644 net.eselect $(DESTDIR)$(modulesdir)/
	[[ -e /etc/eselect/net/devs ]] || install -d /etc/eselect/net/devs
	[[ -e /etc/eselect/net/conf.d ]] || install -d /etc/eselect/net/conf.d
