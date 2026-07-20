---
type: reference
created: 2026-06-04
updated: 2026-06-04
---

# Arch Packages — Recommended

## Priority: Critical (install first)

```
obs-studio kdenlive gimp ffmpegthumbs
```

## By Category

### Development (Web)

- `bun` — Extra — Faster JS runtime
- `deno` — Extra — Modern TS/JS runtime for automation
- `pnpm` — Extra — Better package manager than npm
- `turbo` — AUR — Turborepo for Vercel monorepos
- `vercel-cli` — AUR — Direct CLI deploys

### Content Creation

- `kdenlive` — Extra — Pro video editor, native KDE
- `obs-studio` — Extra — Streaming & recording
- `gimp` — Extra — Image editing & thumbnails
- `inkscape` — Extra — Vector design
- `blender` — Extra — 3D & motion graphics
- `krita` — Extra — Digital painting
- `audacity` — Extra — Audio editing
- `handbrake` — Extra — Video transcoding
- `ffmpegthumbs` — Extra — Video thumbnails in Dolphin

### Terminal & Productivity

- `fastfetch` — Extra — Modern neofetch for Wayland
- `tmux` — Extra — Terminal multiplexer
- `fzf` — Extra — Fuzzy search
- `zoxide` — Extra — Smart cd
- `ripgrep` — Extra — Fast file search
- `fd` — Extra — Better find
- `bat` — Extra — cat with highlighting
- `eza` — Extra — Modern ls
- `delta` — Extra — Beautiful git diffs
- `starship` — Extra — Fast minimal prompt
- `flameshot` — Extra — Annotated screenshots

### DevOps

- `docker-compose` — Extra — Multi-container
- `lazydocker` — AUR — Docker TUI
- `trivy` — Extra — Container security scanner

### Security

- `firejail` — Extra — Sandbox apps
- `gpg` — Extra — Encryption & git signing
- `pass` — Extra — Terminal password manager
- `ufw` — Extra — Firewall

### System

- `reflector` — Extra — Optimize mirrors
- `paccache` — Extra — Clean pacman cache
- `pkgfile` — Extra — File-to-package lookup
- `flatpak` — Extra — Sandboxed apps
- `fwupd` — Extra — Firmware updates

## Quick Install

```bash
sudo pacman -S --needed kdenlive obs-studio gimp inkscape blender krita \
  audacity handbrake ffmpegthumbs fastfetch tmux fzf zoxide ripgrep fd \
  bat eza delta starship flameshot docker-compose reflector pkgfile \
  flatpak fwupd lm_sensors firejail gpg pass ufw imagemagick
```

```bash
paru -S vercel-cli turbo lazydocker
```
