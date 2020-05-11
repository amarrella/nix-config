{ pkgs }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.bat.enable = true;
  home.file.".iterm2_shell_integration.zsh".source = ./home/.iterm2_shell_integration.zsh;
  programs.zsh = {
    enable = true;
    history = {
      size = 50000;
      save = 50000;
    };
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.6.3";
          sha256 = "1h8h2mz9wpjpymgl2p7pc146c1jgb3dggpvzwm9ln3in336wl95c";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
          sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
        };
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "aws"
        "docker"
        "kubectl"
      ];
      theme = "robbyrussell";
    };
    shellAliases = {
      git = "hub";
      gs = "git status";
      gc = "git commit";
      gl = "git log";
      ga = "git add";
      gb = "git checkout";
      p = "git pull";
      push = "git push";
      pr = "hub pull-request";
      okp = "okta-aws-login -p production -u $USER";
      okd = "okta-aws-login -p development -u $USER";
    };
    enableAutosuggestions = true;
    sessionVariables = {
      AWS_PROFILE = "development";
      EDITOR = "vim";
      VISUAL = "vim";
      GIT_EDITOR = "vim";
    };
    initExtraBeforeCompInit = builtins.readFile ./home/pre-compinit.zsh;
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.fzf.enable = true;
  programs.git = {
    enable = true;
    userName = "Alessandro Marrella";
    userEmail = builtins.readFile ./local/userEmail.txt;
    extraConfig = {
      user.signingKey = builtins.readFile ./local/signingKey.txt;
      commit.gpgsign = true;
      branch.autosetupmerge = "always";
      push.default = "current";

      hub.protocol = "ssh";
      github.user = "amarrella";
      color.ui = true;
      pull.rebase = true;
      core.commitGraph = true;
      core.excludesfile = "/Users/amarrella/.gitignore_global";
      core.editor = "vim";
    };
  };
}
