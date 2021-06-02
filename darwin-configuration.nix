{ config, pkgs, lib, ... }:
let
  sources = import ./nix/sources.nix;
  niv = import sources.niv { };
  neuron = import sources.neuron { };
  comma = import sources.comma { };
  username = builtins.getEnv "USER";
  homeDir = "/Users/${username}";
  nix-direnv = import sources.nix-direnv { };
in
{

  imports = [ <home-manager/nix-darwin> ];

  home-manager.useUserPackages = true;

  users.nix.configureBuildUsers = true;
  users.knownGroups = [ "nixbld" ];

  users.users.${username} = {
    home = homeDir;
    description = "${username}'s account";
    shell = pkgs.zsh;
  };

  home-manager.users.${username} = import ./home.nix { inherit config;inherit pkgs;inherit lib;inherit username;inherit homeDir;inherit nix-direnv; };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs; [
      adoptopenjdk-hotspot-bin-11
      awscli
      aws-iam-authenticator
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
      comma
      wget
      pinentry_mac
      niv.niv
      nixpkgs-fmt
      nix
      source-code-pro
      coreutils
      neuron
      ripgrep
      fd
      coreutils
      pandoc
      shellcheck
      fontconfig
      coreutils-prefixed
      tmux
      stack
    ];

  fonts.enableFontDir = true;
  fonts.fonts = with pkgs; [
    source-code-pro
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
    "https://amarrella.cachix.org"
  ];

  nix.binaryCachePublicKeys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "amarrella.cachix.org-1:zmoz1peEmIyOEUCAcvODHB3PzbTtDT9qDZFFa0YBIck="
  ];

  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "nix-docker";
      sshUser = "root";
      sshKey = "/etc/nix/docker_rsa";
      port = 3022;
      systems = [ "x86_64-linux" ];
      maxJobs = 6;
      buildCores = 6;
    }
  ];

  nixpkgs.config.allowUnfree = true;

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
    experimental-features = nix-command
  '';

  documentation.enable = false;
}
