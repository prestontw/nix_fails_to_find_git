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
```
