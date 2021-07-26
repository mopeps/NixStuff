{ config, lib, pkgs, ...}:
 

 { 
	 xdg.configFile."kitty/kitty.conf".text = ''
		background_opacity  0.8
		include /home/mopeps/.config/kitty/kitty-themes/themes/Dracula.conf
	'';
	 programs.kitty = {
		enable = true;
		settings = {
			allow_remote_control = true;
		};
		
	};
}
