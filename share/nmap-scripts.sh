#!/usr/bin/env bash

get-physical-ifaces() {
  local iface
  iface=''

  for nm in /sys/class/net/*; do
    if readlink "$nm" | grep -qv 'virtual' &>/dev/null; then
      iface="$(basename -- "$nm")"
      # ip -4 -o address show dev "$iface" | awk '{ split($4, 
      printf '%s\n' "$iface"
    fi
  done
}

get-target-pattern-few() {
  local ipaddr="$1"

  # Confirm it's private IPv4 space
  case "$ipaddr" in
    192.168.*)
      ;;
    172.{16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}.*)
      ;;
    10.*)
      ;;
    *)
      fatal 'ERROR: LAN is not in the private IPv4 address space'
      ;;
  esac

  printf '%s\n' "$ipaddr" | awk '{ split($1, a, "."); print a[1] "." a[2] "." a[3] ".0-255" }'
}

get-target-pattern-many() {
  local ipaddr="$1"

  case "$ipaddr" in
    192.168.*)
      printf '192.168.0-255.0-255\n'
      ;;
    172.{16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}.*)
      printf '172.16-31.0-255.0-255\n'
      ;;
    10.*)
      printf '10.0-255.0-255.0-255\n'
      ;;
    *)
      fatal 'ERROR: LAN is not in the private IPv4 address space'
      ;;
  esac
}

log() {
  # printf '>>> %b\n' "$*"
  printf '>>> %s\n' "$*"
}

error() {
  log "$*" 1>&2
}

fatal() {
  error "$*"
  exit 1
}
