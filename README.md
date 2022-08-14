eselect-net
===========

eselect-net helps to define configuration profiles for netifrc and switch 
between interface configurations.


Usage
------

To define a new configuration use *make* command:

	root # eselect net make eth-dhcpcd

One can make several configurations.  Let *list* defined configurations:

	root # eselect net list
	Available network configurations:
	  [1]   wireless-wpa-supplicant
	  [2]   3g-dongle-at
	  [3]   3g-dongle-comcast
	  [4]   eth-static-ip
	  [5]   eth-dhcpcd
	  [6]   wireless-ap

These configurations are stored in `/etc/eselect/net/conf.d`.  Let edit
`eth-dhcpcd` configurations:

	root # $EDITOR /etc/eselect/net/conf.d/eth-dhcpcd

	# -*- gentoo-conf-d -*- vim: ft=gentoo-conf-d
	#
	# This is a netifrc network configuration.  It will be processed to make config
	# file.  _iface_ in labels is a placeholder for interface, so modules__iface_
	# will be modules_eth0 in produced config file.

	config__iface_="dhcpcd"
	dhcpcd__iface_=( "-S domain_name_servers='8.8.8.8 8.8.4.4'" )

Now to configure `eth0` by `eth-dhcpcd` use *set* command:

	root # eselect net set eth0 5

It's done by making link `/etc/conf.d/net.eth0` to `/etc/eselect/net/devs/net.eth0`.
Current interface configurations can be queried by *show* command:

	root # eselect net show
	Network devices configurations:
	  eth0                      eth-dhcpcd
	  lo                        not configured by eselect
	  ppp0                      3g-dongle-at

**Notice**: eselect-net is not aware of configurations in `/etc/conf.d/net` and
will show `not configured` for those interfaces.  Also if `/etc/conf.d/net.iface`
exist but not linked to `eselect-net` managed configurations, It will be shown
as `not configured by eselect`.

Now let change `eth-dhcpcd` to ask dhcpcd do its job in background:

	root # $EDITOR /etc/eselect/net/conf.d/eth-dhcpcd

	# -*- gentoo-conf-d -*- vim: ft=gentoo-conf-d
	#
	# This is a netifrc network configuration.  It will be processed to make config
	# file.  _iface_ in labels is a placeholder for interface, so modules__iface_
	# will be modules_eth0 in produced config file.

	config__iface_="dhcpcd"
	dhcpcd__iface_=( "-S domain_name_servers='8.8.8.8 8.8.4.4' -b" )

*check* command will show which interface is using current profile configuration
and which one is not:

	root # eselect net check

	Network configurations status:
	  eth0                      outdated
	  ppp0                      ok

To apply latest `dhcpcd-eth0` change to `eth0` configuration, use *update*:

	root # eselect net update eth1

To make `eth0` don't use `dhcpcd-eth0`, use *unset* command:

	root # eselect net unset eth0


Installation
------------

There is _eselect-net_ package in [mv overlay](https://cgit.gentoo.org/user/mv.git) made and maintained by Martin Väth.

Also you can install it manually by make:

	make prefix=/usr install
