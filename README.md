# Finally
After much struggling I've figured out how to make a neovim flake which works how I want it too

# Test it out
With flakes enabled
```console
nix run github:Gerg-L/nvim-flake
```
Legacy
```console
nix-shell -p 'with import <nixpkgs> {}; builtins.fetchTarball "https://github.com/Gerg-L/nvim-flake/archive/master.tar.gz" ' --run nvim
```
# To install

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
(Make sure you're passing inputs to your [modules](https://blog.nobbz.dev/posts/2022-12-12-getting-inputs-to-modules-in-a-flake/))
### Add to user environment
```nix
#anyModule.nix
{inputs, pkgs, ...}:
{

# add system wide
  environment.systemPackages = [
    inputs.nvim-flake.packages.${pkgs.system}.neovim
  ];
# add per-user
  users.users."<name>".packages = [
    inputs.nvim-flake.packages.${pkgs.system}.neovim
  ];
}
```

## Legacy
Use fetchTarball
```nix
#anyModule.nix
{pkgs, ...}:
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
}
```

# Forking usage guide
Update the flake like any other ``nix flake update``

Extra runtime dependancies can be added [here](https://github.com/Gerg-L/nvim-flake/blob/367075ba580bc1af6b3acd8237ee56c3cef07840/flake.nix#L38)

Add/remove plugins through /plugins/nvfetcher.toml

Use ``nvfetcher`` to update the list.

All plugins added will be fetched and installed.

All lua configuration is done in the /lua directory, and imported and ordered through /lua/default.nix.

## Inspiration
- [@the-argus's](https://github.com/the-argus) [nvim-config](https://github.com/the-argus/nvim-config)
- [@fufexan's](https://github.com/fufexan) [dotfiles](https://github.com/fufexan/dotfiles/tree/main/home/editors/neovim)
- [@NotAShelf's](https://github.com/NotAShelf) [neovim-flake](https://github.com/NotAShelf/neovim-flake)
- [@wiltaylor's](https://github.com/wiltaylor) [neovim-flake](https://github.com/wiltaylor/neovim-flake)
- [@jordanisaacs's](https://github.com/jordanisaacs) [neovim-flake](https://github.com/jordanisaacs/neovim-flake)
- [@gvolpe's](https://github.com/gvolpe) [neovim-flake](https://github.com/gvolpe/neovim-flake)
