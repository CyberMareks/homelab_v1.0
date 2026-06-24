# Changelog — Version 1.5

## Homepage Dashboard

**Technology:** [gethomepage.dev](https://gethomepage.dev) via Docker

- Deployed central landing page aggregating all homelab services into a single dashboard
- Configured service tiles with live API status indicators for Vaultwarden, Uptime Kuma, AdGuard, Tailscale, and Ollama
- Services organised into logical groups: Security, Monitoring, AI, Network
- Accessible remotely via Tailscale VPN

```yaml
# docker-compose.yml excerpt
services:
  homepage:
    image: ghcr.io/gethomepage/homepage:latest
    container_name: homepage
    ports:
      - "3000:3000"
    volumes:
      - ./config:/app/config
      - /var/run/docker.sock:/var/run/docker.sock
    restart: unless-stopped
```

***

## Uptime Kuma — Telegram Alerting

**Technology:** Uptime Kuma + Telegram Bot API

- Configured real-time Telegram notifications for service state changes (DOWN / RECOVERY)
- Added TLS certificate expiry monitoring (7-day warning threshold)
- All monitored services connected to notification channel

***

## Ollama + Hermes Agent — Local LLM Stack

**Technology:** Ollama · Hermes Agent · GTX 1660 SUPER GPU passthrough

- Deployed dedicated VM on Proxmox with PCIe GPU passthrough for hardware-accelerated inference
- Installed and configured Ollama as the local model runtime
- Integrated Hermes Agent as orchestration harness with task-based model routing
- Models updated and maintained via automated one-liner

```bash
# Update all Ollama models
ollama list | tail -n +2 | awk '{print $1}' | xargs -I {} ollama pull {}
```

**Model routing:** Hermes Agent selects the appropriate model based on task type — coding, research, or admin tasks — without manual intervention.

***

## AdGuard Home — DNS Tuning

- Resolved high-volume reverse DNS flood (`192.168.x.in-addr.arpa`) by configuring FritzBox as private reverse DNS resolver
- Reduced unnecessary upstream DNS queries for local subnet lookups
