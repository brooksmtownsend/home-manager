{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "brooks";
  home.homeDirectory = "/Users/brooks";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "vault"
    ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for ezample, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For ezample, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.act
    pkgs.bat
    pkgs.cargo-binstall
    pkgs.cargo-nextest
    pkgs.eksctl
    pkgs.eza
    pkgs.fd
    pkgs.gh
    pkgs.go
    pkgs.htop
    pkgs.jq
    pkgs.k6
    pkgs.kind
    pkgs.kubernetes-helm
    pkgs.nats-server
    pkgs.natscli
    pkgs.nodejs_23
    pkgs.redis
    pkgs.ripgrep
    pkgs.rustup
    pkgs.thefuck
    pkgs.tinygo
    pkgs.vault
    pkgs.zig
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/brooks/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Git and signing config
  programs.gpg = {
    enable = true;
  };

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
      ];
    };

    initExtra = ''
      export PATH="$PATH:$HOME/.cargo/bin"
      export PATH="$PATH:$HOME/go/bin"
      export AWS_PROFILE="enterprise-dev"
      bindkey "\e[1;3D" backward-word
      bindkey "\e[1;3C" forward-word
    '';

    shellAliases = {
      python = "/usr/local/bin/python3";
      ls = "eza";
      ll = "eza -alhF --group-directories-first";
      lt = "eza -lhaTF -L 2 --group-directories-first";
      api = "cd ~/github.com/cosmonic/cosmonic-api";
      ui = "cd ~/github.com/cosmonic/cosmonic-ui";
      be = "cd ~/github.com/cosmonic/cosmonic-backend";
      docs = "cd ~/github.com/cosmonic/cosmonic-docs";
      wasmbleach = "ps -ax | grep -i wasmcloud | awk '{print $1}' |xargs kill -9";
      cat = "bat --theme=gruvbox-dark";
      f = "fuck";
      p = "ps aux";
      c = "connect";
      t = "tmux -f ~/.config/tmux/tmux.conf";
      owash = "WASMCLOUD_CTL_HOST=100.117.106.124 WASMCLOUD_RPC_HOST=100.117.106.124 WASMCLOUD_LATTICE=brooks wash";
    };

    # plugins = [
    #   {
    #     name = "git";
    #   }
    # ];

  };

  # Install the super cool alacritty terminal
  programs.alacritty = {
    enable = true;
    settings = {
      live_config_reload = true;

      bell = {
        animation = "EaseOutExpo";
        color = "#111111";
        duration = 5;
      };

      colors.bright = {
        black = "#565656";
        blue = "#49a4f8";
        cyan = "#99faf2";
        green = "#c0e17d";
        magenta = "#a47de9";
        red = "#ec5357";
        white = "#ffffff";
        yellow = "#f9da6a";
      };
      colors.normal = {
        black = "#2e2e2e";
        blue = "#47a0f3";
        cyan = "#64dbed";
        green = "#abe047";
        magenta = "#7b5cb0";
        red = "#eb4129";
        white = "#e5e9f0";
        yellow = "#f6c744";
      };
      colors.primary = {
        background = "#212121";
        foreground = "#fffbf6";
      };

      font.size = 22.0;

      font.bold = {
        family = "FiraMono Nerd Font";
        style = "Bold";
      };
      font.bold_italic = {
        family = "FiraMono Nerd Font";
        style = "Bold Italic";
      };
      font.italic = {
        family = "FiraMono Nerd Font";
        style = "Italic";
      };
      font.normal = {
        family = "FiraMono Nerd Font";
        style = "Regular";
      };

      mouse.hide_when_typing = true;
      selection.save_to_clipboard = true;

      window = {
        decorations = "full";
        title = "Wanna buy some death sticks?";
        dimensions = {
          columns = 150;
          lines = 25;
        };
        padding = {
          x = 2;
          y = 2;
        };
      };
    };
  };

  # TMUX
  programs.tmux = {
    enable = true;

    keyMode = "vi";

    extraConfig = ''
    # Needed for good vim colors
    set -g default-terminal "xterm-256color"

    # Mouse options
    set -g mouse on
    # Don't jump to bottom with selection
    unbind -T copy-mode-vi MouseDragEnd1Pane

    # Required by MacOS Sierra and Sierra High to properly select and copy text
    # set -g default-command "reattach-to-user-namespace -l $SHELL"

    # Reload tmux config
    bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded..."

    # ~~Found on GitHub~~
    #------------
    # tabs
    #------------
    setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '
    setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

    #------------
    # status bar
    #------------
    set -g status-interval 5
    set -g status-fg green
    set -g status-bg black
    set -g status-left '#(exec pwd)'
    set -g status-left ""
    set -g status-left-length 100
    set -g status-right-length 60
    # TODO: figure out how to use the mixer and acpi
    set -g status-right '%a %m-%d %H:%M:%S'

    # Pane border
    set-option -g pane-border-style bg=default,fg=brightblack
    set-option -g pane-active-border-style bg=default,fg=brightblack
    setw -g pane-border-status bottom


    # ~~From chrism~~
    # ==================== Mappings ====================

    # remap prefix from 'C-b' to 'C-a'
    unbind C-b
    set -g prefix C-a
    bind C-a send-prefix

    # vim-tmux-navigator
    # Smart pane switching with awareness of Vim splits.
    # See: https://github.com/christoomey/vim-tmux-navigator
    is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
    bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
    bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
    bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
    bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
    tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
    if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
    if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

    bind-key -T copy-mode-vi 'C-h' select-pane -L
    bind-key -T copy-mode-vi 'C-j' select-pane -D
    bind-key -T copy-mode-vi 'C-k' select-pane -U
    bind-key -T copy-mode-vi 'C-l' select-pane -R
    bind-key -T copy-mode-vi 'C-\' select-pane -l

    # Resize panes
    bind -r C-h resize-pane -L 5
    bind -r C-j resize-pane -D 5
    bind -r C-k resize-pane -U 5
    bind -r C-l resize-pane -R 5

    # Split pane vertically
    bind | split-window -h -c "#{pane_current_path}"
    # Split pane horizontally
    bind - split-window -v -c "#{pane_current_path}"

    # Swap focused pane with the next one
    bind > swap-pane -D
    # Swap focused pane with the previous one
    bind < swap-pane -U
    # Move the focused pane to the previous window
    bind j join-pane -ht !
    # Move the focused pane to a new window
    bind N break-pane
    # Kill the focused pane
    bind K kill-pane -a

    # Send keys to all panes at the same time
    bind b set-window-option synchronize-panes
    '';
  };

  # Enable starship terminal prompt
  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      format = "$all$directory$username$character";

      # Replace the "❯" symbol in the prompt with "➜"
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      package.disabled = true;

      directory = {
        truncate_to_repo = false;
        truncation_length = 10;
        use_logical_path = true;
      };

      git_branch.symbol = "";

      custom.wash_ver = {
        symbol = "🛁";
        when = "true";
        command = "wash -V | grep wash | awk '{print $1, $2}'";
        format = "[$symbol $output]($style) ";
        style = "bold fg:#00C389";
        ignore_timeout = true; 
      };
    };
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      gruvbox
    ];
    extraConfig = ''
	" viminfo
	set viminfo+=n~/.config/vim/viminfo

	syntax enable
	filetype plugin indent on

	" Indentation Options
	set autoindent
	set expandtab
	set shiftwidth=2
	set tabstop=2

	" Search
	set hlsearch
	set ignorecase
	set incsearch
	set smartcase

	" UI
	set ruler
	set termguicolors
	set background=dark
	colorscheme gruvbox
	set cursorline
	set number
	set relativenumber
	set noerrorbells
	set title

	" Misc
	set history=100

	" Directory explorer settings
	let g:netrw_banner = 0
	let g:netrw_liststyle = 3
	let g:netrw_browse_split = 3
	let g:netrw_altv = 1
	let g:netrw_winsize = 25
	augroup ProjectDrawer
	  autocmd!
	augroup END
    '';
  };
}
