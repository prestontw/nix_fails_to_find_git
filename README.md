## Snapshot of not being able to use `git` inside of `nix develop`

```
nix_fails_to_find_git on  main
❯ nix develop
warning: creating lock file '/Users/preston/git/nix_fails_to_find_git/flake.lock'
warning: Git tree '/Users/preston/git/nix_fails_to_find_git' is dirty

nix_fails_to_find_git on  main via ❄️  impure (nix-shell-env)
❯ git status
error: tool 'git' not found

nix_fails_to_find_git on  main via ❄️  impure (nix-shell-env)
❯ nix --version
nix (Nix) 2.18.2

nix_fails_to_find_git on  main via ❄️  impure (nix-shell-env)
❯ which git
/usr/bin/git

nix_fails_to_find_git on  main via ❄️  impure (nix-shell-env)
❯ git status
error: tool 'git' not found
```

MacOS version: `14.6 (23G80)`

### GitHub links

- https://github.com/NixOS/nixpkgs/issues/355486

- https://github.com/NixOS/nixpkgs/pull/357132

### Attempted Resolutions

```
sudo xcode-select --reset
sudo xcode-select --install
```

Doesn't work.

---------

Specifying earlier nixpkgs commit doesn't work either:

```
nix_fails_to_find_git on  main [!]
❯ nix develop
warning: Git tree '/Users/preston/git/nix_fails_to_find_git' is dirty
warning: updating lock file '/Users/preston/git/nix_fails_to_find_git/flake.lock':
• Updated input 'nixpkgs':
    'github:NixOS/nixpkgs/22c3f2cf41a0e70184334a958e6b124fb0ce3e01' (2024-12-07)
  → 'github:NixOS/nixpkgs/5e4fbfb6b3de1aa2872b76d49fafc942626e2add' (2024-11-15)
warning: Git tree '/Users/preston/git/nix_fails_to_find_git' is dirty
[WARN] - (starship::utils): Executing command "/usr/bin/git" timed out.
[WARN] - (starship::utils): You can set command_timeout in your config to a higher value to allow longer-running commands to keep executing.
[WARN] - (starship::utils): Executing command "/usr/bin/git" timed out.
[WARN] - (starship::utils): You can set command_timeout in your config to a higher value to allow longer-running commands to keep executing.

nix_fails_to_find_git on  main via ❄️  impure (nix-shell-env)
❯ git status
error: tool 'git' not found
```

----------

Reverting to previous versions:

```
nix_fails_to_find_git on  main [⇡]
❯ nix develop

nix_fails_to_find_git on  main via ❄️  impure (nix-shell-env)
❯ command -v xcrun
/nix/store/3a99nvsn1jh7h3vklnd8py5jplls9q41-xcbuild-0.1.1-unstable-2019-11-20-xcrun/bin/xcrun

nix_fails_to_find_git on  main via ❄️  impure (nix-shell-env)
❯ echo $DEVELOPER_DIR/
/nix/store/amdympl4rz7kj93j82cva60v8007n4nv-apple-sdk-11.3/

# Checking out nixos-unstalbe again

nix_fails_to_find_git on  main [!⇡] took 12s
❯ nix develop
warning: Git tree '/Users/preston/git/nix_fails_to_find_git' is dirty
warning: updating lock file '/Users/preston/git/nix_fails_to_find_git/flake.lock':
• Updated input 'nixpkgs':
    'github:NixOS/nixpkgs/5e4fbfb6b3de1aa2872b76d49fafc942626e2add' (2024-11-15)
  → 'github:NixOS/nixpkgs/22c3f2cf41a0e70184334a958e6b124fb0ce3e01' (2024-12-07)
warning: Git tree '/Users/preston/git/nix_fails_to_find_git' is dirty

nix_fails_to_find_git on  main via ❄️  impure (nix-shell-env)
❯ command -v xcrun
/nix/store/kfbwmip99hgd4v7w2hzyba8wb13x3q9p-xcbuild-0.1.1-unstable-2019-11-20-xcrun/bin/xcrun

nix_fails_to_find_git on  main via ❄️  impure (nix-shell-env)
❯ echo $DEVELOPER_DIR/
/nix/store/bbwmxj5wv6nh3cydiyijp80zn30q5svf-apple-sdk-11.3/

# Check out previous rev

nix_fails_to_find_git on  main [!⇡] took 10s
❯ nix develop
warning: Git tree '/Users/preston/git/nix_fails_to_find_git' is dirty
warning: updating lock file '/Users/preston/git/nix_fails_to_find_git/flake.lock':
• Updated input 'nixpkgs':
    'github:NixOS/nixpkgs/22c3f2cf41a0e70184334a958e6b124fb0ce3e01' (2024-12-07)
  → 'github:NixOS/nixpkgs/345c263f2f53a3710abe117f28a5cb86d0ba4059' (2024-09-13)
warning: Git tree '/Users/preston/git/nix_fails_to_find_git' is dirty

nix_fails_to_find_git on  main [!⇡] via ❄️  impure (nix-shell-env)
❯ command -v xcrun
/usr/bin/xcrun

nix_fails_to_find_git on  main [!⇡] via ❄️  impure (nix-shell-env)
❯ echo $DEVELOPER_DIR/
/

nix_fails_to_find_git on  main [!⇡] via ❄️  impure (nix-shell-env)
❯ git status
On branch main
Your branch is ahead of 'origin/main' by 2 commits.
...
```

--------

### Final resolution

```
sudo xcode-select --reset
sudo xcode-select --switch /Library/Developer/CommandLineTools
```

I ran this from inside of a `nix develop` environment---I don't know if that matters or not.
