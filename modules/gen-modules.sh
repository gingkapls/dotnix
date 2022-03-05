#!/bin/sh

printf "%s\n\n%s\n  %s\n%s\n  %s\n%s\n" "{ config, ...}:" "{" "imports = [" "$(find ./*/* -type f -name "*.nix" -printf "    %p\n")" "];" "}"  > module-list.nix

