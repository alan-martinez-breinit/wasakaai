# ADR-003: USB Display Driver Selection

## Context

Alan uses a MacroSilicon MS9132 (345f:9132) USB-HDMI adapter as a third monitor. The adapter ships with Windows and Android drivers only. Linux support requires an out-of-tree kernel module.

## Decision

**Use `yxmicha/ms912x`** (https://github.com/yxmicha/ms912x) as the Linux driver.

## Alternatives Considered

| Driver | Verdict | Reason |
|--------|---------|--------|
| `yxmicha/ms912x` | ✅ Chosen | Correct protocol for 345f:9132, damage tracking, Wayland cursor support, actively maintained (2026-05) |
| `fathonix/ms9132-drm-linux` | ❌ Rejected | Official vendor mirror, sends full framebuffer per frame (~4MB/frame at 1080p), unusably laggy |
| `rhgndf/ms912x` | ❌ Rejected | Different protocol (for 534d:6021), frames display incorrectly on 345f:9132 |
| Kernel `udl` | ❌ N/A | DisplayLink (17e9:*) only, wrong vendor |

## Consequences

- **Positive**: Functional third monitor on Linux with good performance (damage-tracked partial updates)
- **Positive**: Wayland/Mutter cursor support via DRM cursor plane
- **Positive**: No modification to adapter hardware — Windows compatibility preserved 100%
- **Negative**: Out-of-tree kernel module requires rebuild on kernel updates (mitigated by DKMS)
- **Negative**: GPL-2.0-only, not upstream — may break on major kernel changes

## Date

2026-06-11