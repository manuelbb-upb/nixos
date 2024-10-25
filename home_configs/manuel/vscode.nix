{ pkgs, inputs, ... } :
let
  marketplaceExtensionsInput = inputs.nix-vscode-extensions.extensions.${pkgs.system};
  marketplaceExtensions = marketplaceExtensionsInput.vscode-marketplace;
  marketplaceExtensionsRelease = marketplaceExtensionsInput.vscode-marketplace-release;

  nixpkgsExtensionList = with pkgs.vscode-extensions; [
#     sumneko.lua
#     # useful extensions for Python:
#     # (ms-python.python.overrideAttrs (final: prev: { python3 = pkgs.python39; }))
#     # (ms-python.python.override { python3 = (pkgs.python3.withPackages my-python-packages); })
#     ms-python.python
#     ms-toolsai.jupyter
#     ms-toolsai.jupyter-renderers
#     ms-toolsai.jupyter-keymap
#     ms-toolsai.vscode-jupyter-cell-tags
    # LaTeX
    james-yu.latex-workshop
    valentjn.vscode-ltex
  ];
  marketplaceExtensionList = with marketplaceExtensions; [
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
    # Devcontainers
    ms-vscode-remote.remote-containers
  ];
  marketplaceExtensionListRelease = with marketplaceExtensionsRelease; [
  ];

  fetchedExtensionList = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "language-julia";
      publisher = "julialang";
      version = "1.124.2";
      hash = "sha256-ZwZbR8EQdBlBZlGWeZ8uMSWJFCi8J6SmUCyGMK6Wluw=";
    }
  ];
in
  {
    home.packages = [
      pkgs.ltex-ls
    ];
    programs.vscode = {
      enable = true;
      # manage all extenions with home-manager only:
      mutableExtensionsDir = true;
      extensions = nixpkgsExtensionList ++ marketplaceExtensionList ++ marketplaceExtensionListRelease ++ fetchedExtensionList;

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
        # Make dev containers use `podman` instead of `docker`
        "dev.containers.dockerPath" = "podman";
        "dev.containers.dockerSocketPath" = "/var/run/podman/podman.sock";
        "dev.containers.dockerComposePath" = "podman-compose";
        "window.enableMenuBarMnemonics" = false;
        "window.menuBarVisibility"= "visible";
        "window.titleBarStyle" = "custom";
        "window.customMenuBarAltFocus" = false;
        #terminal.integrated.inheritEnv = true;
        "terminal.integrated.scrollback" = 1000;
        "terminal.integrated.fontFamily" = "'ComicShannsMono Nerd Font', monospace";
        "terminal.integrated.commandsToSkipShell" = [
          "language-julia.interrupt"
        ];
        julia.cellDelimiters = [
          "^#(\\s?)%%"
          "^#-"
        ];
        # "julia.executablePath" = "julia";
        "julia.symbolCacheDownload" = true;
        "julia.enableTelemetry" = false;
        "julia.useRevise" = true;
        #"jupyter.kernels.trusted" = ["/home/manuelbb/.local/share/jupyter/kernels"];
        "workbench.editor.revealIfOpen" = true;
        "editor.rulers" = [92];
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
       "python.venvFolders" = [
          "~/.cache/pypoetry/virtualenvs"
        ];
        "workbench.colorTheme" = "Catppuccin Mocha";
      };
    };
  }
