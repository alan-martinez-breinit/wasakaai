# MS912x USB Display Driver

## Overview

Driver DRM kernel para adaptadores USB display MacroSilicon MS9132 (VID `345f`, PID `9132`). Permite usar un tercer monitor vía USB en Linux.

## Hardware

| Field | Value |
|-------|-------|
| Chip | MacroSilicon MS9132 |
| USB ID | `345f:9132` |
| USB Version | 3.0 (5 Gbps) |
| Serial | `77360123` |
| Interfaces | 5 (HID, Audio x2, Vendor Specific, Mass Storage) |
| Max Resolution | 1920×1080 (1080p) |
| Output | HDMI |
| Windows Driver | `/run/media/wasakabe/USBDISPLAY/WinUSBDisplay_Windows_V3.1.5.75.exe` |
| Android Driver | `MSUSBDisplay_Android_V2.0.5.5.apk` (libusb-based) |

## Driver Installation

### Source
- **Repo**: `https://github.com/yxmicha/ms912x`
- **Local**: `~/build/ms912x/`
- **Driver**: `yxmicha/ms912x` — DRM kernel module derivado del código oficial MacroSilicon con optimizaciones:
  - Damage tracking (solo envía cambios, no todo el framebuffer)
  - Double-buffered async USB submission
  - Cursor plane support para Wayland/Mutter
  - Scatter-gather URBs
- **License**: GPL-2.0-only
- **Kernel modules**: `usbdisp_drm.ko`, `usbdisp_usb.ko`
- **Built at**: `~/build/ms912x/src/drm/*.ko`

### Build & Load Commands

```bash
# Compilar
cd ~/build/ms912x/src && make clean && make

# Cargar módulos
sudo insmod ~/build/ms912x/src/drm/usbdisp_drm.ko
sudo insmod ~/build/ms912x/src/drm/usbdisp_usb.ko

# Descargar módulos
sudo rmmod usbdisp_drm usbdisp_usb

# Verificar
lsmod | grep usbdisp
dmesg | grep -i "usbdisp\|ms91\|345f" | tail -20
ls /sys/class/drm/
```

### Dependencies
- `linux-headers` (matching kernel version)
- `dkms` (for automatic rebuilds on kernel updates)
- `base-devel`, `git`

### Install Script
- `~/build/install-ms912x.sh` — Automated installation script (built during session 2026-06-11)

## DKMS Setup (PENDING)

DKMS aún no está configurado. Para que los módulos se reconstruyan automáticamente al actualizar el kernel:

```bash
sudo cp -r ~/build/ms912x /usr/src/ms912x-0.1.0
# Crear dkms.conf (ver install script)
sudo dkms add ms912x/0.1.0
sudo dkms build ms912x/0.1.0
sudo dkms install ms912x/0.1.0
```

Auto-carga al inicio: `/etc/modules-load.d/ms912x.conf`

## Windows Compatibility

**El adaptador NO fue modificado.** El driver Linux es un módulo kernel que se comunica vía USB — no flashea ni altera el firmware. Al arrancar Windows, el `.exe` original funcionará igual que siempre.

## Troubleshooting

- Si el monitor no se detecta: `sudo rmmod usbdisp_drm usbdisp_usb` y recargar
- Si falla la compilación: verificar que `linux-headers` coincida con `uname -r`
- Si no aparece en KDE: ir a Configuración del Sistema → Pantallas
- Si falla después de actualizar kernel: recompilar con `cd ~/build/ms912x/src && make clean && make` y recargar

## Alternate Drivers (NOT recommended)

- `fathonix/ms9132-drm-linux` — Mirror del driver oficial MacroSilicon. Inusablemente lento (envía framebuffer completo cada frame).
- `rhgndf/ms912x` — Reverse-engineered para MS912x (VID `534d:6021`). **No funciona** con nuestro chip `345f:9132` porque usa protocolo de painting diferente.
- Driver oficial Android — Usa libusb, no es un driver kernel. Solo referencia de protocolo.

---

*Installed: 2026-06-11*