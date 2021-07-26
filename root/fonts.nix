{ config, pkgs, lib, ...}:
{	
	console.packages = with pkgs; [
		scientifica
	];
	fonts = {
		enableDefaultFonts = true;
		fontDir.enable = true;
		fonts = with pkgs; [
			scientifica
			nerdfonts
			emacs-all-the-icons-fonts
			curie
			terminus_font
			twemoji-color-font
			sarasa-gothic
			font-awesome
		];
		fontconfig = {
			enable = true;
			defaultFonts = {
				serif = [
					"Sarasa Gothic C"
				];
				sansSerif = [
          				"Sarasa Gothic C"
     				        "Sarasa Gothic J"
          				"Sarasa Gothic K"
					];

				emoji = [
					"Noto Emoji Nerd Font"
					"Twitter Color Emoji"
					"FontAwesome"
				];
				monospace = ["Iosevka" ];
			};
			dpi = 132;
		};
	};
}
