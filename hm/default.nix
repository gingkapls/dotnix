{ config, pkgs, ... }: 

{
  imports = [
    ./desktop
    ./programs
    ./shells
  ];
}
