# Finally
After much struggling I've figured out how to make a neovim flake which works how I want it too

# Test it out

```console
nix run github:Gerg-L/nvim-flake
```

# Install
## Import this flake
### Flakes
Add a this flake as an input
```nix
{
  inputs = {
    nvim-flake = {
      url = "github:Gerg-L/nvim-flake";
      inputs.nixpkgs.follows = "unstable";
    };
...
```
(Make sure you're passing inputs to your [modules](https://blog.nobbz.dev/posts/2022-12-12-getting-inputs-to-modules-in-a-flake/))
### Legacy
```nix
let
  nvim-flake = builtins.getFlake "github:Gerg-L/nvim-flake/<latest revision>";
in
{
...
```
## Add to user environment
Then add 
```nix
inputs.nvim-flake.packages.${pkgs.system}.default
```
to ``environment.systemPackages`` and/or ``home.packages``

# Forking usage guide
Update the flake like any other ``nix flake update``

Extra runtime dependancies can be added [here](https://github.com/Gerg-L/nvim-flake/blob/7e9667d7b3cc2fd5d8a4b5d17ac8af2519e9b3ea/flake.nix#L74)

Add/remove plugins [here](https://github.com/Gerg-L/nvim-flake/blob/master/plugins/nvfetcher.toml)

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
