{ config, pkgs, ...}:
{
	virtualisation.docker.enable = true;
	users.users.mopeps.extraGroups = [ "docker" ];
	environment.systemPackages = with pkgs; [
		docker-compose
		];
}
