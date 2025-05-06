{ pkgs, inputs, config, ... } :
let
  ## vscode keybindings (common to all profiles)
  keybindings = [
    {
      "key" = "shift+space";
      "command" = "workbench.action.focusActiveEditorGroup";
      "when" = "terminalFocus";
    }
    {
      "key" = "space";
      "command" = "vspacecode.space";
      "when" = "activeEditorGroupEmpty && focusedView == '' && !whichkeyActive && !inputFocus";
    }
    {
      "key" = "space";
      "command" = "vspacecode.space";
      "when" = "sideBarFocus && !inputFocus && !whichkeyActive";
    }
    {
      "key" = "tab";
      "command" = "extension.vim_tab";
      "when" = "editorFocus && vim.active && !inDebugRepl && vim.mode != 'Insert' && editorLangId != 'magit'";
    }
    {
      "key" = "tab";
      "command" = "-extension.vim_tab";
      "when" = "editorFocus && vim.active && !inDebugRepl && vim.mode != 'Insert'";
    }
    {
      "key" = "x";
      "command" = "magit.discard-at-point";
      "when" = "editorTextFocus && editorLangId == 'magit' && vim.mode =~ /^(?!SearchInProgressMode|CommandlineInProgress).*$/";
    }
    {
      "key" = "k";
      "command" = "-magit.discard-at-point";
    }
    {
      "key" = "-";
      "command" = "magit.reverse-at-point";
      "when" = "editorTextFocus && editorLangId == 'magit' && vim.mode =~ /^(?!SearchInProgressMode|CommandlineInProgress).*$/";
    }
    {
      "key" = "v";
      "command" = "-magit.reverse-at-point";
    }
    {
      "key" = "shift+-";
      "command" = "magit.reverting";
      "when" = "editorTextFocus && editorLangId == 'magit' && vim.mode =~ /^(?!SearchInProgressMode|CommandlineInProgress).*$/";
    }
    {
      "key" = "shift+v";
      "command" = "-magit.reverting";
    }
    {
      "key" = "shift+o";
      "command" = "magit.resetting";
      "when" = "editorTextFocus && editorLangId == 'magit' && vim.mode =~ /^(?!SearchInProgressMode|CommandlineInProgress).*$/";
    }
    {
      "key" = "shift+x";
      "command" = "-magit.resetting";
    }
    {
      "key" = "x";
      "command" = "-magit.reset-mixed";
    }
    {
      "key" = "ctrl+u x";
      "command" = "-magit.reset-hard";
    }
    {
      "key" = "y";
      "command" = "-magit.show-refs";
    }
    {
      "key" = "y";
      "command" = "vspacecode.showMagitRefMenu";
      "when" = "editorTextFocus && editorLangId == 'magit' && vim.mode == 'Normal'";
    }
    {
      "key" = "ctrl+j";
      "command" = "workbench.action.quickOpenSelectNext";
      "when" = "inQuickOpen";
    }
    {
      "key" = "ctrl+k";
      "command" = "workbench.action.quickOpenSelectPrevious";
      "when" = "inQuickOpen";
    }
    {
      "key" = "ctrl+j";
      "command" = "selectNextSuggestion";
      "when" = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
    }
    {
      "key" = "ctrl+k";
      "command" = "selectPrevSuggestion";
      "when" = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
    }
    {
      "key" = "ctrl+l";
      "command" = "acceptSelectedSuggestion";
      "when" = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
    }
    {
      "key" = "ctrl+j";
      "command" = "showNextParameterHint";
      "when" = "editorFocus && parameterHintsMultipleSignatures && parameterHintsVisible";
    }
    {
      "key" = "ctrl+k";
      "command" = "showPrevParameterHint";
      "when" = "editorFocus && parameterHintsMultipleSignatures && parameterHintsVisible";
    }
    {
      "key" = "ctrl+h";
      "command" = "file-browser.stepOut";
      "when" = "inFileBrowser";
    }
    {
      "key" = "ctrl+l";
      "command" = "file-browser.stepIn";
      "when" = "inFileBrowser";
    }
    {
      "key" = "shift+q";
      "command" = "hideSuggestWidget";
      "when" = "suggestWidgetVisible && textInputFocus";
    }
  ];
  userSettings = {
    # don't notify about updates (?)
    "update.mode" = "none";
    # set theme
    "workbench.colorTheme" = "Catppuccin Mocha";
    # show a column ruler:
    "editor.rulers" = [92];
    # I think I did these to enhance wayland experience:
    "window.enableMenuBarMnemonics" = false;
    "window.menuBarVisibility"= "visible";
    "window.titleBarStyle" = "custom";
    "window.customMenuBarAltFocus" = false;
    # Terminal settings
    #terminal.integrated.inheritEnv = true;
    "terminal.integrated.scrollback" = 1000;
    "terminal.integrated.fontFamily" = "'ComicShannsMono Nerd Font', monospace";
    "workbench.editor.revealIfOpen" = true;
    "git.enableSmartCommit" = true;   # commit all changes if nothing is manually staged
    "keyboard.dispatch" = "keyCode";  # important for Neo2 layout to work
    "vim.easymotion" = true;
    "vim.useSystemClipboard" = true;
    "vim.normalModeKeyBindingsNonRecursive" = [
      {
        "before" = [
          "<space>"
        ];
        "commands" = [
          "vspacecode.space"
        ];
      }
      {
        "before" = [
          ","
        ];
        "commands" = [
          "vspacecode.space"
          {
            "command" = "whichkey.triggerKey";
            "args" = "m";
          }
        ];
      }
    ];
    "vim.visualModeKeyBindingsNonRecursive" = [
      {
        "before" = [
          "<space>"
        ];
        "commands" = [
          "vspacecode.space"
        ];
      }
      {
        "before" = [
          ","
        ];
        "commands" = [
          "vspacecode.space"
          {
            "command" = "whichkey.triggerKey";
            "args" = "m";
          }
        ];
      }
    ];
    # Make dev containers use `podman` instead of `docker`
    #"dev.containers.dockerPath" = "podman";
    #"dev.containers.dockerSocketPath" = "/var/run/podman/podman.sock";
    #"dev.containers.dockerComposePath" = "podman-compose";
  };

  userSettings-julia = {
    julia = {
      cellDelimiters = [
        "^#(\\s?)%%"
        "^#-"
      ];
      #"executablePath" = "julia";
      "symbolCacheDownload" = true;
      "enableTelemetry" = false;
      "useRevise" = true;
    };
    "terminal.integrated.commandsToSkipShell" = [
      "language-julia.interrupt"
    ];
  };

  userSettings-python = {
    python = {
      venvFolders = [
        "~/.cache/pypoetry/virtualenvs"
      ];
    };
  };
  userSettings-jupyter = userSettings-python // {
    jupyter = {
      "kernels.trusted" = [
        "${config.home.homeDirectory}/.local/share/jupyter/kernels"
      ];
    };
  };
 
  # extension sets shortcuts
  extset-nixpkgs = pkgs.vscode-extensions;
  extset-marketplace = inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
  extset-manual = pkgs.vscode-utils.extensionsFromVscodeMarketplace;

  exts-common = with extset-marketplace; [
    # Spacemacs and Vim-Mode
    vspacecode.whichkey
    vspacecode.vspacecode
    vscodevim.vim
    # Random word generator
    thmsrynr.vscode-namegen
    # Catppuccin Theme
    catppuccin.catppuccin-vsc
    # Nix language extension
    jnoortheen.nix-ide
    # direnv chooser:
    mkhl.direnv
  ];

  exts-julia = extset-manual [
        {
      name = "language-julia";
      publisher = "julialang";
      version = "1.127.1";
      hash = "sha256-GDbxC8B6Cu+yBoa0qPURMf1M3imtSSm100ZI0CA78aI=";
    }
  ];

  exts-latex = with extset-marketplace; [ 
    james-yu.latex-workshop
    valentjn.vscode-ltex
  ];

  exts-python = with extset-nixpkgs; [
    # change python interpreter::
    # (ms-python.python.overrideAttrs (final: prev: { python3 = pkgs.python39; }))
    # (ms-python.python.override { python3 = (pkgs.python3.withPackages my-python-packages); })
    ms-python.python
  ];

  exts-jupyter = exts-python ++ (with extset-marketplace; [
    ms-toolsai.jupyter
    ms-toolsai.jupyter-renderers
    ms-toolsai.jupyter-keymap
    ms-toolsai.vscode-jupyter-cell-tags
  ]);

in
{
  home.packages = [
    pkgs.ltex-ls    # LaTeX language server
  ];
  programs.vscode = {
    enable = true;
    # manage all extenions with home-manager only:
    mutableExtensionsDir = false;
    profiles = {
      default = {
        inherit keybindings userSettings;
        extensions = exts-common;
      };
      latex = {
        inherit keybindings;
        extensions = exts-common ++ exts-latex;
        userSettings = userSettings;
      };
      julia = {
        inherit keybindings;
        extensions = exts-common ++ exts-julia;
        userSettings = userSettings // userSettings-julia;
      };
      jupyter = {
        inherit keybindings;
        extensions = exts-common ++ exts-jupyter;
        userSettings = userSettings // userSettings-jupyter; 
      };
    };
  };
}
