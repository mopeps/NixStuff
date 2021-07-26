{ pkgs, ... }:
{
	home.packages = with pkgs; [
		brave
		discord
		pamixer
        mpv
		spotifyd
		spotify-tui
		xclip
		jetbrains.idea-ultimate
		jetbrains.webstorm
		jetbrains.clion
		vscode-with-extensions
		dracula-theme
		kitty
		flavours
		sxiv
		xcompmgr
		alsa-firmware
		alsaUtils
		gucharmap
		xorg.xfd
		spotify-tui
		font-manager
		imagemagick
		xdotool   
		light
		xorg.xbacklight
		android-studio
		
	];
}
