{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.bat.enable = true;
  programs.zsh = {
    enable = true;
    history = {
      size = 50000;
      save = 50000;
    };
    oh-my-zsh = {
      plugins = [
        "zsh-autosuggestions"
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
