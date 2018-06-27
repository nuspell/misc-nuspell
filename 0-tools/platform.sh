#!/usr/bin/env sh

uname="$(uname -s)"

case "${uname}" in
	Linux*)
	platform=linux;;
	FreeBSD*)
	platform=freebsd;;
	Darwin*)
	platform=macos;;
	CYGWIN*)
	platform=cygwin;;
	MINGW*)
	platform=mingw;;
	*)
	platform="unknown:${uname}"
esac

echo $platform
