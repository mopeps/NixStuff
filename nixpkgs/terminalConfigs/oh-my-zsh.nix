{ config, lib, pkgs, ... }:
{
	home.packages = with pkgs; [
		oh-my-zsh
	];
	programs.zsh = {
		enable = true;
		autocd = true;
		dotDir = ".config/zsh";
		enableCompletion = true;
		enableAutosuggestions = true;
		oh-my-zsh = {
			custom = ".config/zsh";
			enable = true;
			#theme = "powerlevel10k/powerlevel10k";
			plugins = [ "git" "sudo" "docker"
				      "gradle" 	
				      "git-flow" "systemd"];
		};
		initExtra = ''
			export ANDROID_HOME=$HOME/Android/Sdk
			export PATH=$PATH:$ANDROID_HOME/emulator
			export PATH=$PATH:$ANDROID_HOME/tools
			export PATH=$PATH:$ANDROID_HOME/tools/bin
			export PATH=$PATH:$ANDROID_HOME/platform-tools
			export _JAVA_AWT_WM_NONREPARENTING=1
			export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"
			export PATH="$PATH:$HOME/.cache/"
			export PATH="$PATH:$HOME/.cache/Cypress/8.0.0/Cypress"
			#Adds scripts in statusbar
			export PATH="$PATH:$(du "$HOME/.cargo/bin" | cut -f2 | paste -sd ':')"
			#scripts
			export PATH="$PATH:$HOME/scripts"
			export GOPATH=$HOME/go
			#defaults	
			export BROWSER="brave"
			# sourcing theme,since zshrc is readOnly
			source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
			source /home/mopeps/.config/zsh/.p10k.zsh
		'';
	
	};
}
