# NeoVim Flake
Using my own [Minimal NeoVim Wrapper](https://github.com/Gerg-L/mnw)

# Test it out
With flakes enabled
```console
nix run github:Gerg-L/nvim-flake
```
Legacy (may seem like it stalls)
```console
nix-shell -p '(import (builtins.fetchTarball "https://github.com/Gerg-L/nvim-flake/archive/master.tar.gz")).packages.${builtins.currentSystem}.default' --run nvim
```
# To install

I'd recommend [forking](#forking-usage-guide) and modifiying to your use-case rather than using this as-is in your own config...

But if you want do use it anyways or install your fork here's how


## Flakes
Add this flake as an input
```nix
#flake.nix
{
  inputs = {
    nvim-flake = {
      url = "github:Gerg-L/nvim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
...
```
(Make sure you're passing inputs to your [modules](https://blog.nobbz.dev/posts/2022-12-12-getting-inputs-to-modules-in-a-flake))
### Add to user environment
```nix
#anyModule.nix
# add system wide
  environment.systemPackages = [
    inputs.nvim-flake.packages.${pkgs.system}.neovim
  ];
# add per-user
  users.users."<name>".packages = [
    inputs.nvim-flake.packages.${pkgs.system}.neovim
  ];
```

## Legacy
Use fetchTarball
```nix
let
  nvim-flake = import (builtins.fetchTarball {
  # Get the revision by choosing a version from https://github.com/Gerg-L/nvim-flake/commits/master
  url = "https://github.com/Gerg-L/nvim-flake/archive/<revision>.tar.gz";
  # Get the hash by running `nix-prefetch-url --unpack <url>` on the above url
  sha256 = "<hash>";
});
in
{
# add system wide
  environment.systemPackages = [
    nvim-flake.packages.${pkgs.system}.neovim
  ];
# add per-user
  users.users."<name>".packages = [
    nvim-flake.packages.${pkgs.system}.neovim
  ];
```

# Forking usage guide

Update the flake like any other `nix flake update`

Add/remove/update plugins via [npins](https://github.com/andir/npins) 
Example of adding a plugin: `npins add github nvim-treesitter nvim-treesitter-context --branch main`
Example of updated all plugins: `npins update --full`

All lua configuration is done in the /gerg directory and added to plugins

My lua config is not very good so I recommend writing your own

## Inspiration
- [@the-argus's](https://github.com/the-argus) [nvim-config](https://github.com/the-argus/nvim-config)
- [@fufexan's](https://github.com/fufexan) [dotfiles](https://github.com/fufexan/dotfiles/tree/main/home/editors/neovim)
- [@NotAShelf's](https://github.com/NotAShelf) [neovim-flake](https://github.com/NotAShelf/nvf)
- [@wiltaylor's](https://github.com/wiltaylor) [neovim-flake](https://github.com/wiltaylor/neovim-flake)
- [@jordanisaacs's](https://github.com/jordanisaacs) [neovim-flake](https://github.com/jordanisaacs/neovim-flake)
- [@gvolpe's](https://github.com/gvolpe) [neovim-flake](https://github.com/gvolpe/neovim-flake)

