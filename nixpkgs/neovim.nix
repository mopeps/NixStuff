{ config, pkgs, lib,  ... }:

let 
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
    plugin = pluginGit "HEAD";  
in {
    programs.neovim = {
        enable = true;
        extraPackages = with pkgs; [
                # used to compile tree-sitter grammar
                tree-sitter

                # installs different langauge servers for neovim-lsp
            # have a look on the link below to figure out the ones for your languages
                # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
                nodePackages.typescript nodePackages.typescript-language-server
                gopls
                nodePackages.pyright
                rust-analyzer
            ];
        plugins = with pkgs.vimPlugins; [
            vim-polyglot  
            vim-easy-align
            nerdtree
            vimagit
            vimwiki
            vim-airline
            vim-commentary
            (plugin "kovetskiy/sxhkd-vim")
            (plugin "ap/vim-css-color")
            goyo

        ];
        extraConfig = ''
            filetype plugin indent on
            " show existing tab with 4 spaces width
            set tabstop=4
            " when indenting with '>', use 4 spaces width
            set shiftwidth=4
            " On pressing tab, insert 4 spaces
            set expandtab

            set go=a
            set mouse=a
            set nohlsearch
            set clipboard +=unnamedplus

            let mapleader = ','
            "Splits open at the bottom and right,which is non-retarded,unlike vim defaults
            set splitbelow splitright

            "Algo basiquinho
            nnoremap c "_c
            set nocompatible
            filetype plugin on
            syntax on
            set encoding=utf-8
            set number 
            " Nerd tree
            map <leader>n :NERDTreeToggle<CR>
            autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
            if has('nvim')
                let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
            else
                 let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
            endif

            "Enable autocompletion:
                set wildmode=longest,list,full
            "sets asm files to nasm files
            autocmd FileType asm set ft=nasm


        '';
    };
    
}
