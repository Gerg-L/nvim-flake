# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  autopairs = {
    pname = "autopairs";
    version = "ae5b41ce880a6d850055e262d6dfebd362bb276e";
    src = fetchgit {
      url = "https://github.com/windwp/nvim-autopairs";
      rev = "ae5b41ce880a6d850055e262d6dfebd362bb276e";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-bu+WpW5Wfk3pS74mzVvehl7dVMHgrttmV4ZSlfwbai4=";
    };
    date = "2023-07-14";
  };
  bufdelete-nvim = {
    pname = "bufdelete-nvim";
    version = "07d1f8ba79dec59d42b975a4df1c732b2e4e37b4";
    src = fetchgit {
      url = "https://github.com/famiu/bufdelete.nvim";
      rev = "07d1f8ba79dec59d42b975a4df1c732b2e4e37b4";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-UubYRfRAXZ89WOc3QFMvAMjNjLW6bV4nDgSa1CRZkIM=";
    };
    date = "2023-06-29";
  };
  bufferline-lua = {
    pname = "bufferline-lua";
    version = "417b303328118b6d836ae330142e88771c48a8a3";
    src = fetchgit {
      url = "https://github.com/akinsho/bufferline.nvim";
      rev = "417b303328118b6d836ae330142e88771c48a8a3";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-jsjT56YWsFb9Qr/mjmwpOm9thYkScnSCOZ+MPzaz1DM=";
    };
    date = "2023-08-11";
  };
  cinnamon = {
    pname = "cinnamon";
    version = "c406ffda3a0302f32c23b24ab756ea20467d6578";
    src = fetchgit {
      url = "https://github.com/declancm/cinnamon.nvim";
      rev = "c406ffda3a0302f32c23b24ab756ea20467d6578";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-JglXQhoPgN9sQ3yuv0+VQxmKMvoQTu5lbGLSRaQkytI=";
    };
    date = "2022-12-04";
  };
  cmp = {
    pname = "cmp";
    version = "51f1e11a89ec701221877532ee1a23557d291dd5";
    src = fetchgit {
      url = "https://github.com/hrsh7th/nvim-cmp";
      rev = "51f1e11a89ec701221877532ee1a23557d291dd5";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-sdsfd+JxEEZI/JpCPW7v6wO0JuPzwBdbkPq0ajYgaYc=";
    };
    date = "2023-08-12";
  };
  cmp-buffer = {
    pname = "cmp-buffer";
    version = "3022dbc9166796b644a841a02de8dd1cc1d311fa";
    src = fetchgit {
      url = "https://github.com/hrsh7th/cmp-buffer";
      rev = "3022dbc9166796b644a841a02de8dd1cc1d311fa";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-dG4U7MtnXThoa/PD+qFtCt76MQ14V1wX8GMYcvxEnbM=";
    };
    date = "2022-08-10";
  };
  cmp-nvim-lsp = {
    pname = "cmp-nvim-lsp";
    version = "44b16d11215dce86f253ce0c30949813c0a90765";
    src = fetchgit {
      url = "https://github.com/hrsh7th/cmp-nvim-lsp";
      rev = "44b16d11215dce86f253ce0c30949813c0a90765";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-mU0soCz79erJXMMqD/FyrJZ0mu2n6fE0deymPzQlxts=";
    };
    date = "2023-06-23";
  };
  cmp-path = {
    pname = "cmp-path";
    version = "91ff86cd9c29299a64f968ebb45846c485725f23";
    src = fetchgit {
      url = "https://github.com/hrsh7th/cmp-path";
      rev = "91ff86cd9c29299a64f968ebb45846c485725f23";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-thppiiV3wjIaZnAXmsh7j3DUc6ceSCvGzviwFUnoPaI=";
    };
    date = "2022-10-03";
  };
  cmp-spell = {
    pname = "cmp-spell";
    version = "60584cb75e5e8bba5a0c9e4c3ab0791e0698bffa";
    src = fetchgit {
      url = "https://github.com/f3fora/cmp-spell";
      rev = "60584cb75e5e8bba5a0c9e4c3ab0791e0698bffa";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-e6nHT+5xEXDFkWes89R85FdriPSP0fPiuoXwgBdH+9M=";
    };
    date = "2022-10-10";
  };
  cmp-treesitter = {
    pname = "cmp-treesitter";
    version = "389eadd48c27aa6dc0e6b992644704f026802a2e";
    src = fetchgit {
      url = "https://github.com/ray-x/cmp-treesitter";
      rev = "389eadd48c27aa6dc0e6b992644704f026802a2e";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-WOcg6w4M20gpMCZjZ3DpPIA55SGLjV75fhckefiVfU0=";
    };
    date = "2023-04-06";
  };
  cmp-vsnip = {
    pname = "cmp-vsnip";
    version = "989a8a73c44e926199bfd05fa7a516d51f2d2752";
    src = fetchgit {
      url = "https://github.com/hrsh7th/cmp-vsnip";
      rev = "989a8a73c44e926199bfd05fa7a516d51f2d2752";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-2mkN03noOr5vBvRbSb35xZKorSH+8savQNZtgM9+QcM=";
    };
    date = "2022-11-22";
  };
  crates = {
    pname = "crates";
    version = "d5caf28aba49e81ac4099426231f3cf3c151013a";
    src = fetchgit {
      url = "https://github.com/saecki/crates.nvim";
      rev = "d5caf28aba49e81ac4099426231f3cf3c151013a";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-09tqoU9zo32+zpP/ybo6bbDxmdzAcr3a0xU7ZKuN3pg=";
    };
    date = "2023-08-08";
  };
  gitsigns = {
    pname = "gitsigns";
    version = "bae45ef449d8811061cc940459e70e883a3aa83a";
    src = fetchgit {
      url = "https://github.com/lewis6991/gitsigns.nvim";
      rev = "bae45ef449d8811061cc940459e70e883a3aa83a";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-+pERMBPBpPjuMiLU3rXgGEZDdSOHmNGNtl26dDjERls=";
    };
    date = "2023-08-09";
  };
  indent-blankline = {
    pname = "indent-blankline";
    version = "4541d690816cb99a7fc248f1486aa87f3abce91c";
    src = fetchgit {
      url = "https://github.com/lukas-reineke/indent-blankline.nvim";
      rev = "4541d690816cb99a7fc248f1486aa87f3abce91c";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-efMRkxjbr6o7kSKAEn0Kaw8lsDubRmc1N0Kd1BZ3A7k=";
    };
    date = "2023-07-07";
  };
  lspkind = {
    pname = "lspkind";
    version = "57610d5ab560c073c465d6faf0c19f200cb67e6e";
    src = fetchgit {
      url = "https://github.com/onsails/lspkind.nvim";
      rev = "57610d5ab560c073c465d6faf0c19f200cb67e6e";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-S+qZm51hw/cRujIfHV/1x1fYyCKI4XQ0utSL8uy4l6I=";
    };
    date = "2023-05-05";
  };
  lualine = {
    pname = "lualine";
    version = "45e27ca739c7be6c49e5496d14fcf45a303c3a63";
    src = fetchgit {
      url = "https://github.com/nvim-lualine/lualine.nvim";
      rev = "45e27ca739c7be6c49e5496d14fcf45a303c3a63";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-v8finXk+sLNaFMA7pSHhEu0WF5mhPYWHEKhl0IKBv8c=";
    };
    date = "2023-08-03";
  };
  moonfly = {
    pname = "moonfly";
    version = "fc2bb33f847de9a63c49472adb1ef870b2b7f8a1";
    src = fetchgit {
      url = "https://github.com/bluz71/vim-moonfly-colors";
      rev = "fc2bb33f847de9a63c49472adb1ef870b2b7f8a1";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-+tHHwjGS7ZCWy5yOfKzD5znv9BUWU9A1+6f3mqSr/ao=";
    };
    date = "2023-08-09";
  };
  noice = {
    pname = "noice";
    version = "894db25ec726d32047799d4d0a982b701bec453b";
    src = fetchgit {
      url = "https://github.com/folke/noice.nvim";
      rev = "894db25ec726d32047799d4d0a982b701bec453b";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-Zca6meJkfF4fl17Y+6s77GYrqnhkkzIYW73vAhKg7e4=";
    };
    date = "2023-07-25";
  };
  nui = {
    pname = "nui";
    version = "9e3916e784660f55f47daa6f26053ad044db5d6a";
    src = fetchgit {
      url = "https://github.com/MunifTanjim/nui.nvim";
      rev = "9e3916e784660f55f47daa6f26053ad044db5d6a";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-nSUs9zAX7hQ3PuFrH4zQblMfTY6ALDNggmqaQnkbR5E=";
    };
    date = "2023-07-20";
  };
  null-ls = {
    pname = "null-ls";
    version = "0010ea927ab7c09ef0ce9bf28c2b573fc302f5a7";
    src = fetchgit {
      url = "https://github.com/jose-elias-alvarez/null-ls.nvim";
      rev = "0010ea927ab7c09ef0ce9bf28c2b573fc302f5a7";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-cWA0rzkOp/ekVKaFee7iea1lhnqKtWUIU+fW5M950wI=";
    };
    date = "2023-08-11";
  };
  nvim-colorzier = {
    pname = "nvim-colorzier";
    version = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6";
    src = fetchgit {
      url = "https://github.com/norcalli/nvim-colorizer.lua";
      rev = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-6YrnItxExL2C8pNIdLd+hXCjsB2MbZANwWkah6dreD8=";
    };
    date = "2020-06-11";
  };
  nvim-lspconfig = {
    pname = "nvim-lspconfig";
    version = "a981d4447b92c54a4d464eb1a76b799bc3f9a771";
    src = fetchgit {
      url = "https://github.com/neovim/nvim-lspconfig";
      rev = "a981d4447b92c54a4d464eb1a76b799bc3f9a771";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-krHh6YI3svFimxv+U0oJZNHv4HguR/ljLLu0kMvPji0=";
    };
    date = "2023-08-11";
  };
  plenary = {
    pname = "plenary";
    version = "267282a9ce242bbb0c5dc31445b6d353bed978bb";
    src = fetchgit {
      url = "https://github.com/nvim-lua/plenary.nvim";
      rev = "267282a9ce242bbb0c5dc31445b6d353bed978bb";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-oRtNcURQzrIRS3D88tWAl3HuFHxVJr8m/zzL7xoa/II=";
    };
    date = "2023-07-17";
  };
  rust-tools = {
    pname = "rust-tools";
    version = "0cc8adab23117783a0292a0c8a2fbed1005dc645";
    src = fetchgit {
      url = "https://github.com/simrat39/rust-tools.nvim";
      rev = "0cc8adab23117783a0292a0c8a2fbed1005dc645";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-jtfyDxifchznUupLSao6nmpVqaX1yO0xN+NhqS9fgxg=";
    };
    date = "2023-07-10";
  };
  telescope = {
    pname = "telescope";
    version = "2d92125620417fbea82ec30303823e3cd69e90e8";
    src = fetchgit {
      url = "https://github.com/nvim-telescope/telescope.nvim";
      rev = "2d92125620417fbea82ec30303823e3cd69e90e8";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-BU6LFfuloNDhGSFS55sehZAX6mIqpD+R4X+sfu8aZwQ=";
    };
    date = "2023-08-10";
  };
  toggle-term = {
    pname = "toggle-term";
    version = "12cba0a1967b4f3f31903484dec72a6100dcf515";
    src = fetchgit {
      url = "https://github.com/akinsho/toggleterm.nvim";
      rev = "12cba0a1967b4f3f31903484dec72a6100dcf515";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-VFTnDLGy8U3x5ldMUW6okQjQ78qEFPb1n3pcbS2znNY=";
    };
    date = "2023-08-03";
  };
  tree-lua = {
    pname = "tree-lua";
    version = "0a54dcb76b02f3a4e2da370c7a3f6f2b7b43ef01";
    src = fetchgit {
      url = "https://github.com/nvim-tree/nvim-tree.lua";
      rev = "0a54dcb76b02f3a4e2da370c7a3f6f2b7b43ef01";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-6Le7rt1JlksX/T7NGrFfNneFCkjX4F2Ukkix0fMx7zU=";
    };
    date = "2023-08-13";
  };
  treesitter-context = {
    pname = "treesitter-context";
    version = "3d4ab25056dcaf6dd11ebacf1da8525c8df6550f";
    src = fetchgit {
      url = "https://github.com/nvim-treesitter/nvim-treesitter-context";
      rev = "3d4ab25056dcaf6dd11ebacf1da8525c8df6550f";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-gOf7ZwExcZePJp9o0z4fXaTsdBKfow/AAwT5X00nvgk=";
    };
    date = "2023-08-03";
  };
  vsnip = {
    pname = "vsnip";
    version = "7753ba9c10429c29d25abfd11b4c60b76718c438";
    src = fetchgit {
      url = "https://github.com/hrsh7th/vim-vsnip";
      rev = "7753ba9c10429c29d25abfd11b4c60b76718c438";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-ehPnvGle7YrECn76YlSY/2V7Zeq56JGlmZPlwgz2FdE=";
    };
    date = "2023-03-12";
  };
  web-devicons = {
    pname = "web-devicons";
    version = "ab899311f8ae00a47eae8e0879506cead8eb1561";
    src = fetchgit {
      url = "https://github.com/nvim-tree/nvim-web-devicons";
      rev = "ab899311f8ae00a47eae8e0879506cead8eb1561";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-1qOM8ezmNAdLvhRwBe/yFKdjZep9zNto6NlKMF5vZps=";
    };
    date = "2023-08-10";
  };
  which-key = {
    pname = "which-key";
    version = "7ccf476ebe0445a741b64e36c78a682c1c6118b7";
    src = fetchgit {
      url = "https://github.com/folke/which-key.nvim";
      rev = "7ccf476ebe0445a741b64e36c78a682c1c6118b7";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-B1+EHd2eH/EbD5Kip9PfhdPyyGfIkD6rsx0Z3rXvb5w=";
    };
    date = "2023-07-28";
  };
}
