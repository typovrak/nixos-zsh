{ config, pkgs, ... }:

let 
	username = "typovrak";
	group = config.users.users.${username}.group or "users";
	home = config.users.users.${username}.home;
in {
	system.activationScripts.zsh = ''
		touch ${home}/.zshrc
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
		fastfetch
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

			fastfetch
		'';
	};
}
