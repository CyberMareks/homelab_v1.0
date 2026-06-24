# 🖥️ Homelab — Personal Infrastructure Project

> A self-hosted infrastructure project documenting my hands-on experience with Linux systems, virtualisation, networking, containerisation, and AI/LLM integration. Built and maintained as part of my development as a **Fachinformatiker Systemintegrator**.

***

## 🧰 Core Skills Demonstrated

| Domain | Technologies |
|---|---|
| **Virtualisation** | Proxmox VE, KVM/QEMU, GPU Passthrough (PCIe) |
| **Containerisation** | Docker, Docker Compose |
| **Networking** | VLAN isolation, VPN mesh (Tailscale/WireGuard), DNS filtering, Firewall (OPNsense) |
| **Linux Administration** | CachyOS (Arch), Debian, Ubuntu — systemd, package management, hardening |
| **Monitoring & Alerting** | Uptime Kuma, Telegram notifications, status dashboards |
| **Security** | Vaultwarden (self-hosted password manager), network segmentation, Tailscale ACLs |
| **AI / LLM Integration** | Ollama, Hermes Agent, local model routing, GPU-accelerated inference |
| **Remote Access** | Tailscale VPN, SSH, RDP (xrdp/RustDesk), MobaXterm |

***

## 🏗️ Infrastructure Overview

```
ISP
 │
 ▼
Office FritzBox (WAN uplink)
 │
 └─── Home FritzBox 7520 (isolated LAN)
           │
           └─── Proxmox Host
                 │   Intel Xeon E5-1650 v3 | 32GB RAM
                 │   GeForce GTX 1660 SUPER (GPU passthrough)
                 │
                 ├── Homepage Dashboard (Docker)
                 ├── Vaultwarden (Docker)
                 ├── Uptime Kuma (Docker)
                 ├── AdGuard Home (Docker)
                 ├── Tailscale (VPN mesh)
                 └── Ollama + Hermes Agent (GPU VM)
```

**Network isolation:** Home network is separated from the office/ISP network via the FritzBox 7520. All services are accessible remotely through Tailscale without exposing ports to the public internet.

***

## 📦 Services

### Homepage Dashboard
- **Purpose:** Central landing page for all homelab services
- **Stack:** [gethomepage.dev](https://gethomepage.dev) running in Docker
- **Skills:** Docker, service API integration, YAML configuration

### Vaultwarden
- **Purpose:** Self-hosted password manager (Bitwarden-compatible)
- **Stack:** Docker + reverse proxy
- **Skills:** Docker, secrets management, HTTPS/TLS, data persistence

### Uptime Kuma
- **Purpose:** Service monitoring and uptime tracking with alerting
- **Stack:** Docker
- **Skills:** Monitoring, alerting pipelines, Telegram webhook integration

### AdGuard Home
- **Purpose:** Network-wide DNS filtering and ad blocking
- **Stack:** Docker
- **Skills:** DNS configuration, network-level filtering, private reverse DNS

### Tailscale
- **Purpose:** Zero-config VPN mesh for secure remote access
- **Stack:** WireGuard-based, installed on all nodes
- **Skills:** VPN, network segmentation, ACL policy, remote access

### Ollama + Hermes Agent
- **Purpose:** Local LLM inference with intelligent model routing
- **Stack:** Ollama on a dedicated VM with GTX 1660 SUPER GPU passthrough
- **Skills:** GPU passthrough (PCIe), Linux GPU drivers, LLM orchestration, AI agent configuration

***

## 🖥️ Hardware

| Component | Spec |
|---|---|
| **CPU** | Intel Xeon E5-1650 v3 (6C/12T) |
| **RAM** | 32 GB DDR4 ECC |
| **GPU** | GeForce GTX 1660 SUPER (passed through to LLM VM) |
| **Storage** | 83 GB SSD (OS) + HDD expansion planned |
| **Hypervisor** | Proxmox VE |
| **OS (daily driver)** | CachyOS (Arch Linux) |

***

## 🗂️ Repository Structure

```
homelab/
├── README.md
├── docs/
│   ├── CHANGELOG-v1.5.md
│   └── architecture.md
├── docker/
│   ├── homepage/
│   ├── vaultwarden/
│   ├── uptime-kuma/
│   └── adguard/
└── scripts/
    └── update-models.sh
```

***

## 📋 Changelog

| Version | Highlights |
|---|---|
| **v1.5** | Homepage dashboard · Uptime Kuma alerting · Ollama + Hermes Agent LLM stack |
| **v1.0** | Proxmox setup · Tailscale · Vaultwarden · Uptime Kuma · AdGuard Home |

***

## 🔜 Roadmap (v2.0)

- [ ] Immich — self-hosted photo management
- [ ] Nextcloud — file sync and collaboration
- [ ] n8n — workflow automation and AI agent pipelines
- [ ] HDD expansion for NAS storage
- [ ] Hermes Agent internet research integration

***

## 📌 About

This project is built and documented as part of my **Fachinformatiker Systemintegrator** training (Umschulung). Every component is deliberately chosen to reflect real-world enterprise IT skills: virtualisation, containerisation, network security, monitoring, and modern AI infrastructure.
