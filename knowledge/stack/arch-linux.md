---
type: reference
created: 2026-06-04
updated: 2026-06-11
---

# Arch Linux — System & Setup

## Current System

- **OS**: Arch Linux (rolling release)
- **DE**: KDE Plasma 6 (Wayland)
- **Packages**: 756 installed
- **Languages**: Node.js 26.2, Python 3.14, Rust (via rustup)
- **Containers**: Docker 29.5
- **Media**: ffmpeg 8.1
- **Gaming**: Steam (multilib enabled)
- **Camera**: Kamoso (KDE camera app), Integrated Webcam HD `0c45:6730`
- **VCS**: Git 2.54
- **Editor**: Vim 9.2, OpenCode 1.15
- **Security**: gocryptfs, intel-ucode

## Recommended Packages

See [[Arch Packages]] for full recommended list.

### Installed Key Stack

```
nodejs 26.2 | npm 11.16 | python 3.14 | docker 29.5
ffmpeg 8.1 | git 2.54 | vim 9.2 | opencode 1.15
```

### Package Manager

- `pacman` — official repos
- AUR helper: TBD (recommend `paru` or `yay`)

## Arch-specific Notes

- Use `reflector` to keep mirrors fast
- Use `paccache` to clean cache periodically
- Consider `timeshift` or `btrfs` snapshots before major updates
- Always check `archlinux.org/news` before `pacman -Syu`