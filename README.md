# Kea DHCP server demo

Basic installation and configuration of Kea DHCP server.

Scaffolding code from [vagrant-shell-skeleton](https://github.com/bertvv/vagrant-shell-skeleton).

## Getting started

- Get started with `vagrant up`
- Make changes to the config file in `provisioning/files/keasrv/` and run `vagrant provision` to apply the changes

## Current config

- DHCPv4
  - Subnet 192.168.76.0/24
    - Range 192.168.76.101-253
    - No gateway/DNS (at this time)
    - IP address 192.168.76.12 reserved for 08:00:27:4F:D1:18

## License

Licensed under the 2-clause "Simplified BSD License". See [LICENSE.md](/LICENSE.md) for details.
