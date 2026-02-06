# Contributing to Daily Verse Reading

## GitHub is the standard repo

**https://github.com/Luknarz/DailyVerse** is the single source of truth. All work should go through this repo so everyone always has the latest code.

## Workflow: always stay in sync

### Before you start working

```bash
git pull origin main
```

Pull the latest changes so you're never working on an outdated copy.

### While working

- Make your changes as usual
- Commit with clear messages: `git add -A && git commit -m "Short description"`

### When you're done

```bash
git push origin main
```

Push so your collaborator(s) get your changes and the repo stays up to date.

## Quick reference

| Goal              | Command               |
|------------------|-----------------------|
| Get latest code  | `git pull origin main` |
| Send your changes| `git push origin main` |
| Check status     | `git status`          |

## Branch

We use **main** as the only branch. Everyone pulls from and pushes to `origin main`.

## If you get "diverged" or merge conflicts

1. Pull first: `git pull origin main`
2. Resolve any conflicts in the reported files
3. Then push: `git push origin main`

This keeps the GitHub repo the standard for everyone.
