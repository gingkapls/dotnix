{ config, lib, ... }:

{
  programs = {

    fzf = {
      enable = true;
    };

    nix-index = { 
      enable = true;
    };

    starship = {
      enable = true;
      settings = {
        format = "$username";
        username = {
          format = "[$user]($style) ";
          show_always = true;
          disabled = false;
        };

        right_format = lib.concatStrings [
          # "$hostname" 
          "$localip" 
          "$shlvl" 
          "$singularity" 
          "$kubernetes" 
          "$directory" 
          "$vcsh" 
          "$fossil_branch" 
          "$git_branch" 
          "$git_commit" 
          "$git_state" 
          "$git_metrics" 
          "$git_status" 
          "$hg_branch" 
          "$pijul_channel" 
          "$docker_context" 
          "$package" 
          "$c" 
          "$cmake" 
          "$cobol" 
          "$daml" 
          "$dart" 
          "$deno" 
          "$dotnet" 
          "$elixir" 
          "$elm" 
          "$erlang" 
          "$fennel" 
          "$golang" 
          "$guix_shell" 
          "$haskell" 
          "$haxe" 
          "$helm" 
          "$java" 
          "$julia" 
          "$kotlin" 
          "$gradle" 
          "$lua" 
          "$nim" 
          "$nodejs" 
          "$ocaml" 
          "$opa" 
          "$perl" 
          "$php" 
          "$pulumi" 
          "$purescript" 
          "$python" 
          "$raku" 
          "$rlang" 
          "$red" 
          "$ruby" 
          "$rust" 
          "$scala" 
          "$solidity" 
          "$swift" 
          "$terraform" 
          "$vlang" 
          "$vagrant" 
          "$zig" 
          "$buf" 
          "$nix_shell" 
          "$conda" 
          "$meson" 
          "$spack" 
          "$memory_usage" 
          "$aws" 
          "$gcloud" 
          "$openstack" 
          "$azure" 
          "$env_var" 
          "$crystal" 
          "$custom" 
          "$sudo" 
          "$cmd_duration" 
          "$line_break" 
          "$jobs" 
          "$battery" 
          "$time" 
          "$status" 
          "$os" 
          "$container" 
          "$shell" 
        ];

      };
    };

    zoxide = {
      enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };

    };
  
  };


  imports = [
    ./env.nix
    # ./bin
    ./zsh.nix
    ./fish.nix
    ./nushell.nix
  ];


}
