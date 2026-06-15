<!-- Copyright (C) 2026 Nucora Linux By : Efe Enes -->
<!-- License: GNU General Public License v3.0 -->

<h1 align="center">nux-maker</h1>
<p align="center">
  Nucora Linux Nux Package Manager's Repo Builder App
</p>

<p align="center">
  <img src="https://img.shields.io/badge/version-4.5.0-blue">
  <img src="https://img.shields.io/badge/status-active-success">
  <img src="https://img.shields.io/badge/license-GPLv3-blue">
  <img src="https://img.shields.io/badge/platform-Debian%2013-red">
  <img src="https://img.shields.io/badge/language-Bash-green">
  <img src="https://img.shields.io/badge/nginx-supported-brightgreen">
</p>

<p align="center">
  <a href="https://nucoralinux.com.tr">Website</a> •
  <a href="https://forum.nucoralinux.com.tr">Forum</a> •
  <a href="https://instagram.com/nucoralinux">Instagram</a> •
  <a href="https://repo.nucoralinux.com.tr">Repository</a>
</p>

---

## 📖 About

**nux-maker** is the official repository management and package building tool for the [Nux Package Manager](https://github.com/nucoralinux/nux). It converts `.deb` packages into `.nux` format, automatically resolves dependencies from Debian repositories, classifies packages intelligently, sets up Nginx web server configuration, and generates repository indexes — all from a single command-line tool.

Whether you're building your own Nux repository for personal use or hosting a community package repository, nux-maker handles the entire pipeline from package conversion to web server deployment.

---

## ✨ Features

### 🚀 Interactive Setup Wizard
- Step-by-step guided repository setup
- Automatic Nginx configuration
- SSL support (Let's Encrypt / Self-signed / HTTP)
- Works with any domain or IP address
- Multi-language support (Turkish / English)

### 📦 Package Building
- `.deb` → `.nux` conversion with full metadata extraction
- Automatic dependency resolution from Debian 13 (Trixie) repositories
- Recursive dependency downloading and building
- Maintainer script wrapping (pre/post install/remove)
- Symlink creation for `/opt` binaries

### 🏷️ Smart Package Classification
Every package gets automatically classified:

| Class | Description | Upgrade Behavior |
|-------|-------------|-----------------|
| `app` | User applications (Discord, Zoom, Chrome) | ✅ Shown in upgrade |
| `base` | System dependencies (libxcb, gpg, dbus) | ❌ Hidden from upgrade |
| `tool` | Nucora system tools (nux, nucora-*) | ✅ Shown, protected |

### 🔒 Managed-By System
Each package metadata includes a `managed_by` field:
- `managed_by: nux` — Package is managed by nux package manager
- `managed_by: system` — Package is managed by system (dpkg/apt)

This prevents nux from accidentally upgrading critical system packages like `libc6`, `openssl`, or `python3`.

### 🌐 Nginx Integration
- Automatic Nginx virtual host configuration
- HTTP and HTTPS support
- Let's Encrypt automatic SSL certificate
- Self-signed certificate generation
- CORS headers for cross-origin access
- Proper MIME types for `.nux` files

### 📋 Built-in Index Generator
No separate script needed — nux-maker includes a full repository index generator:
- SHA256 hash calculation for every package
- Metadata caching for fast rebuilds
- Package count and class distribution
- Version tracking

### 🔍 Repository Management
- Dependency audit — find missing dependencies
- Auto-repair — download and build missing packages
- Ubuntu package scanner — detect and remove Ubuntu-origin packages
- Repository statistics and health checks
- Cache management

---

## 📥 Installation

### Requirements
- Debian 13 (Trixie) based system
- Root access
- Internet connection

### Quick Install

```bash
git clone https://github.com/nucoralinux/nux-maker.git
cd nux-maker
sudo ./install.sh
sudo nux-maker setup
