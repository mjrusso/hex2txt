{
  description = "Nix-Flake-based development environment for hex2txt";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        elixir = pkgs.elixir;
        elixir-ls = pkgs.elixir-ls;
        next-ls = pkgs.next-ls;
        node = pkgs.nodejs_20;

        base-packages = [ elixir pkgs.git node pkgs.just ];

        elixir-language-servers = [ elixir-ls next-ls ];

        base-scripts = [ ];

      in {

        # A stripped-down dev shell, for use in CI environments.
        #
        # Example usage:
        #
        #     nix develop .#ci -c COMMAND
        #
        # This shell is faster to build than the default, because it doesn't
        # include the Elixir language servers and other dependencies that are
        # only useful for development.
        devShells.ci =
          pkgs.mkShell { packages = base-packages ++ base-scripts; };

        devShells.default = pkgs.mkShell {
          packages = base-packages ++ elixir-language-servers ++ base-scripts

            ++ pkgs.lib.optionals pkgs.stdenv.isLinux
            (with pkgs; [ inotify-tools libnotify ])

            ++ pkgs.lib.optionals pkgs.stdenv.isDarwin
            (with pkgs.darwin.apple_sdk.frameworks; [
              pkgs.terminal-notifier
              CoreFoundation
              CoreServices
            ]);

          shellHook = ''
            export PATH=$PWD/assets/node_modules/.bin:$PATH

            # Store configuration files and scripts used by Mix in this local directory.
            mkdir -p .nix-shell/.mix
            export MIX_HOME=$PWD/.nix-shell/.mix
            export PATH=$MIX_HOME/bin:$PATH
            export PATH=$MIX_HOME/escripts:$PATH

            # Store cache and configuration files used by Hex in this local directory.
            mkdir -p .nix-shell/.hex
            export HEX_HOME=$PWD/.nix-shell/.hex
            export PATH=$HEX_HOME/bin:$PATH

            # Enable shell history for IEx.
            export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$PWD/.nix-shell/.erlang-history\"'"
          '';

        };
      });

}
