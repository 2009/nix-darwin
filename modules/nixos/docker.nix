{ pkgs, ... }:
{
  virtualisation.containers.enable = true;
  virtualisation.docker.enable = true;
  environment.systemPackages = [ pkgs.docker-compose ];
}
