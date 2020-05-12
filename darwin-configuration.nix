{ config, pkgs, lib, ... }:


let
  sources = import ./nix/sources.nix;
  comma = import sources.comma {};
  all-hies = import sources.all-hies {};
  hie = all-hies.selection { selector = p: { inherit (p) ghc865; }; };
  username = builtins.getEnv "USER";
  homeDir = "/Users/${username}";
in

{

  imports = [ <home-manager/nix-darwin> ];

  home-manager.useUserPackages = true;


  users.users.${username} = {
    home = homeDir;
    description = "${username}'s account";
    shell = pkgs.zsh;
  };

  home-manager.users.${username} = import ./home.nix { inherit config; inherit pkgs; inherit lib; inherit username; inherit homeDir; };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs; [
      adoptopenjdk-hotspot-bin-11
      awscli
      aws-iam-authenticator
      aws-sam-cli
      bat
      cabal-install
      cabal2nix
      cachix
      cloudflared
      curl
      dep
      direnv
      emacs
      git
      ghc
      fzf
      eksctl
      gettext
      go
      gitAndTools.hub
      gitAndTools.gh
      haskellPackages.policeman
      jq
      kubectl
      kubectx
      kustomize
      lastpass-cli
      lorri
      nix-prefetch-git
      oh-my-zsh
      python
      pre-commit
      sbt
      skopeo
      starship
      stylish-haskell
      telnet
      tree
      vim
      zsh-autosuggestions
      zsh-syntax-highlighting
      hie
      comma
      wget
    ];

  environment.variables = {
    EDITOR = "vim";
  };

  programs.nix-index.enable = true;
  nix.package = pkgs.nix;

  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;


  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  system.defaults.trackpad.Clicking = false;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh.enable = true;
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 8;
  nix.buildCores = 1;
  nix.trustedUsers = [ "@root" username ];

  nix.binaryCaches = [
    "https://cache.nixos.org"
    "https://cache.dhall-lang.org"
    "https://static-haskell-nix.cachix.org"
    "https://nix-tools.cachix.org"
    "https://amarrella.cachix.org"
  ];

  nix.binaryCachePublicKeys = [
    "cache.dhall-lang.org:I9/H18WHd60olG5GsIjolp7CtepSgJmM2CsO813VTmM="
    "static-haskell-nix.cachix.org-1:Q17HawmAwaM1/BfIxaEDKAxwTOyRVhPG5Ji9K3+FvUU="
    "nix-tools.cachix.org-1:ebBEBZLogLxcCvipq2MTvuHlP7ZRdkazFSQsbs0Px1A="
    "amarrella.cachix.org-1:zmoz1peEmIyOEUCAcvODHB3PzbTtDT9qDZFFa0YBIck="
  ];

  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "nix-docker";
      sshUser = "root";
      sshKey = "/etc/nix/docker_rsa";
      systems = [ "x86_64-linux" ];
      maxJobs = 6;
      buildCores = 6;
    }
  ];

  nixpkgs.config.allowUnfree = true;


}
