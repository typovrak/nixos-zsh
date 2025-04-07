# nixos-zsh

nixos-zsh = fetchGit {
	url = "https://github.com/typovrak/nixos-zsh.git";
	ref = "main";
};


(import "${nixos-zsh}/configuration.nix")
