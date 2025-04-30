# 🔧 NixOS Zsh

> Simple NixOS module to bootstrap and manage a full-featured Zsh environment with config, history, plugins, prompt, SSH agent, aliases and more.

## 📦 Features

- 🔒 **Secure dotfiles :** Installs ```.zshrc``` and initializes ```.zsh_history``` with `600` permissions and correct ownership.

- 🐚 **Default shell :** Sets zsh as the login shell for the configured user.

- ⚙️ **Essential plugins :** Installs and sources ```zsh-autosuggestions``` and ```zsh-syntax-highlighting```.

- ⭐ **Starship prompt :** Initializes [Starship](https://starship.rs/) for a modern and fast prompt without configuration.

- 🔑 **SSH agent :** Auto-starts ```ssh-agent``` and loads your SSH keys on login.

- ✏️ **Editor & aliases :** Sets ```EDITOR=nvim```, aliases ```v```, ```vi```, ```vim``` to Neovim and ```ls``` to ```eza```.

- 🚀 **Fastfetch :** Displays system info on shell startup.

- 📦 **Package management :** Ensures all required packages are in ```environment.systemPackages``` like ```zsh```, ```vim```, ```neovim```, ```eza``` and more.

## ⚙️ Prerequisites

### 1. NixOS version
Requires NixOS 24.11 or newer.

### 2. User validation
the target user must be defined in ```config.username```. See [typovrak main nixos configuration](https://github.com/typovrak/nixos) for more details.

### 3. Backup
Before proceeding, back up existing configuration if needed
```bash
cp ~/.zshrc{,.bak}
```
## 🚀 Installation
Fetch the module directly in your main nixos configuration at ```/etc/nixos/configuration.nix``` using fetchGit
```nix
# /etc/nixos/configuration.nix

let
  nixos-zsh = fetchGit {
    url = "https://github.com/typovrak/nixos-zsh.git";
    ref = "main";
    rev = "55181d862b8459851d8ec6b97fd48f2a8298bd4d"; # update to the desired commit
  };
in
{
  imports = [
    /etc/nixos/hardware-configuration.nix # system hardware settings
    /etc/nixos/variables.nix # defines config.username and other variables, see https://github.com/typovrak/nixos for more details
    (import "${nixos-zsh}/configuration.nix")
  ];
}
```

Once imported, rebuild your system to apply changes
```bash
sudo nixos-rebuild switch
```

## 🎬 Usage

Open a new terminal or reboot your system to see your new terminal setup.

## ❤️ Support

If this module saved you time, please ⭐️ the repo and share feedback.  
You can also support me on ☕ [Buy me a coffee](https://www.buymeacoffee.com/typovrak).

## 📝 License

Distributed under the [MIT license](LICENSE.md).

## 📜 Code of conduct

This project maintains a [code of conduct](.github/CODE_OF_CONDUCT.md) to ensure a respectful, inclusive and constructive community.

## 🛡️ Security

To report vulnerabilities or learn about supported versions and response timelines, please see our [security policy](.github/SECURITY.md).

---

<p align="center"><i>Made with 💜 by typovrak</i></p>
