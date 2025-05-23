{ config, pkgs, ... }:

let 
	username = config.username;
	group = config.users.users.${username}.group or "users";
	home = config.users.users.${username}.home;
in {
	system.activationScripts.zsh = ''
		cp ${./.zshrc} ${home}/.zshrc
		chown ${username}:${group} ${home}/.zshrc
		chmod 600 ${home}/.zshrc

		touch ${home}/.zsh_history
		chown ${username}:${group} ${home}/.zsh_history
		chmod 600 ${home}/.zsh_history
	'';

	users.users.${username} = {
		shell = pkgs.zsh;
	};

	environment.systemPackages = with pkgs; [
		zsh
		zsh-autosuggestions
		zsh-syntax-highlighting
		starship
		openssh
		vim
		neovim
		eza
		fastfetch
		pnpm
	];

	services.openssh.enable = true;

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		promptInit = ''
			autoload -Uz compinit
			compinit

			source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
			source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
			eval "$(${pkgs.starship}/bin/starship init zsh)"

			if [ -z "$SSH_AUTH_SOCK" ]; then
				eval "$(${pkgs.openssh}/bin/ssh-agent -s)" &>/dev/null
			fi


			${pkgs.openssh}/bin/ssh-add ~/.ssh/typovrak_github &>/dev/null
			${pkgs.openssh}/bin/ssh-add ~/.ssh/typovrak_gitlab &>/dev/null

			${pkgs.openssh}/bin/ssh-add ~/.ssh/mscholz_dev_github &>/dev/null
			${pkgs.openssh}/bin/ssh-add ~/.ssh/mscholz_dev_gitlab &>/dev/null

			export PNPM_HOME="/home/typovrak/.local/share/pnpm"
			case ":$PATH:" in
  				*":$PNPM_HOME:"*) ;;
  				*) export PATH="$PNPM_HOME:$PATH" ;;
			esac

			export EDITOR=nvim
			
			alias v=nvim
			alias vi=nvim
			alias vim=nvim
			
			alias ls="eza -l --icons"

			${pkgs.fastfetch}/bin/fastfetch
		'';
	};
}
