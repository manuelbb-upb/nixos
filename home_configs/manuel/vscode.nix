{ pkgs, inputs, ... } :
let
  nixExtensions = with pkgs.vscode-extensions; [
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
  moreExtensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
    # Spacemacs and Vim-Mode
    vspacecode.whichkey
    vspacecode.vspacecode
    vscodevim.vim
    # Random word generator
    thmsrynr.vscode-namegen
    # Catppuccin Theme
    catppuccin.catppuccin-vsc
    # Julia language extension
    julialang.language-julia
    # Nix language extension
    jnoortheen.nix-ide
    # direnv chooser:
    mkhl.direnv
    # Devcontainers
    ms-vscode-remote.remote-containers
#     # Fortran
#     fortran-lang.linter-gfortran
#     goessner.mdmath
#     oijaz.unicode-latex
  ];
  marketPlaceExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
   #  {
   #    name = "quarto";
   #    publisher = "quarto";
   #    version = "1.113.0";
   #    hash = "sha256-PJnzfajjLWtrR4vSLugnq9Ke/84vi21au2wb+3bdpag=";
   #  }
  ];
in
  {
    # home.file.".vscode/argv.json".text = ''
    #   // This configuration file allows you to pass permanent command line arguments to VS Code.
    #   // Only a subset of arguments is currently supported to reduce the likelihood of breaking
    #   // the installation.
    #   //
    #   // PLEASE DO NOT CHANGE WITHOUT UNDERSTANDING THE IMPACT
    #   //
    #   // NOTE: Changing this file requires a restart of VS Code.
    #   {
    #           // Use software rendering instead of hardware accelerated rendering.
    #           // This can help in cases where you see rendering issues in VS Code.
    #           "disable-hardware-acceleration": true,

    #           // Allows to disable crash reporting.
    #           // Should restart the app if the value is changed.
    #           "enable-crash-reporter": true,

    #           // Unique id used for correlating crash reports sent from this instance.
    #           // Do not edit this value.
    #           "crash-reporter-id": "6032f65e-ee1c-4fe9-9d9a-eb504cee4fdc"
    #   }
    # '';
    home.packages = [
      pkgs.ltex-ls
    ];
    programs.vscode = {
      enable = true;
      # manage all extenions with home-manager only:
      mutableExtensionsDir = true;
      extensions = nixExtensions ++ moreExtensions ++ marketPlaceExtensions;

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
        # julia.cellDelimiters = [
        #   "^#(\\s?)%%"
        #   "^#-"
        # ];
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
