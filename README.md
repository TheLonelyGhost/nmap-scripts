# Nmap scripts

This is a compilation of scripts hand-written as a form of executable documentation for me as I'm learning about `nmap` and network protocols. Below is an index of each script and what it hopes to accomplish.

Most scripts will live in the `bin/` directory of the repository. Just add it to your PATH and continue on your merry way. Documentation for assumed built-in tools (e.g., netcat, awk, sysfs) may or may not be defined at this early of a stage.

## `port-is-open`

Using netcat (`nc`), this checks if the given port on the given IP is open.

## `get-lan-ip`

Prints out any and all non-virtual network interfaces using the `ip` command and `sysfs` (note for linux-based systems). Passing an argument of `ip` or `iface`/`interface` to this will print just the IPv4 or interface name, respectively.

## `list-lan-peers`

Find other hosts on the same subnet of a private IP address space. The only argument is how open you want the list of IPv4 addresses to be. `open`/`all`/`many` will scan the full private IP address space, `few`/`conservative`/`slim` will scan all IPv4 addresses in the last octet.

The intention is to list all hosts (IPv4 addresses) connected to the same network as this machine.
