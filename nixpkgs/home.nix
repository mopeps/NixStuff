{ config, pkgs, lib,  ...}:

{

	nixpkgs.overlays = [
  		(import (builtins.fetchTarball {
    			url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
			}))
	];
	nixpkgs.config.allowUnfree = true;
	imports = [
		./languagePakgs.nix
		./terminalConfigs/oh-my-zsh.nix
		./appPkgs.nix
		./neovim.nix
		./terminalConfigs/kitty.nix
		./terminalConfigs/picom.nix
	];

	# Let Home Manager install and manage itself
	programs.home-manager.enable = true;
	
	# Home Manager needs a bit of info from you and the paths it should manage
	home.username = "mopeps";
	home.homeDirectory = "/home/mopeps";


	programs.git = {
		enable = true;
		userName = "mopeps";
		userEmail = "lucagiabbani@amalgama.co";
	};

	home.stateVersion = "21.05";
	
	#Theme
	gtk = {
		enable = true;
		theme.name = "Dracula-theme";
		theme.package = pkgs.dracula-theme;
	};

	# Fonts
	fonts = {
		fontconfig = {	
			enable = true;
		};
	};
}
