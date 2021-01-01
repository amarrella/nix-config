# Nix Configuration

This is my personal nix configuration and might not work for anyone else but feel free to fork it :) 

## How to install
1. Install Nix (if on Catalina see https://github.com/NixOS/nix/issues/2925#issuecomment-539570232) 
2. Start a nix-shell in this repository (or install [direnv](https://direnv.net/))
3. [Use amarrella cache](https://app.cachix.org/cache/amarrella).
4. Install [nix-darwin](https://github.com/LnL7/nix-darwin/) 
5. Install [home-manager](https://rycee.gitlab.io/home-manager/index.html#sec-install-nix-darwin-module) as nix-darwin module
6. `git clone https://github.com/amarrella/nix-config ~/.nixpkgs`
7. `echo -n "your_email@your_provider.tld" > ~/.nixpkgs/local/userEmail.txt`
8. `echo -n "YOUR_SIGNING_KEY" > ~/.nixpkgs/local/signingKey.txt`
9. `darwin-rebuild switch`
