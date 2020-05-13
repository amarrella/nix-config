# Nix Configuration

This is my personal nix configuration and might not work for anyone else but feel free to fork it :) 

## How to install
1. Install Nix (if on Catalina see https://github.com/NixOS/nix/issues/2925#issuecomment-539570232) 
2. [Install cachix and use amarrella cache](https://app.cachix.org/cache/amarrella).
3. Install [nix-darwin](https://github.com/LnL7/nix-darwin/) 
4. Install [home-manager](https://rycee.gitlab.io/home-manager/index.html#sec-install-nix-darwin-module) as nix-darwin module
5. `git clone https://github.com/amarrella/nix-config ~/.nixpkgs`
6. `echo -n "your_email@your_provider.tld" > ~/.nixpkgs/local/userEmail.txt`
7. `echo -n "YOUR_SIGNING_KEY" > ~/.nixpkgs/local/signingKey.txt`
8. `darwin-rebuild switch`
