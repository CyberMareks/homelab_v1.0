# High-Availability Home-Lab DNS & Privacy Suite
A robust, multi-container DNS architecture hosted on Proxmox VE, featuring recursive resolution, network-wide ad-blocking, and secure remote access via Tailscale.

## 🏗 Architecture
The project follows a "Defense in Depth" strategy for DNS queries:
1. **Client**: Connects via Local LAN or Tailscale Mesh VPN.
2. **AdGuard Home (LXC 100)**: Primary DNS sinkhole filtering >200k rules (HaGeZi PRO Blocklist).
3. **Unbound (LXC 102)**: A private recursive resolver that contacts Root Servers directly, eliminating reliance on upstream providers (Google/Cloudflare).
4. **Tailscale (LXC 101)**: Acts as the secure gateway for remote mobile clients.



## 💻 Hardware: "The Workhorse"
- **Host**: Dell Precision Tower 5810
- **CPU**: Intel Xeon E5-1650 v3 (6C/12T)
- **RAM**: 32 GB DDR4 ECC
- **Storage**: Samsung SSD 850 EVO 250 GB (OS/LXCs)
- **Thermals**: Idle at 36°C (Thermal paste recently serviced)

## 🔧 Technical Implementation Details

### DNS Chain Configuration
- **AdGuard Home**: Configured to use Unbound as the sole upstream via `192.168.20.4:5335`.
- **Unbound**: Hardened configuration with `access-control` limited to the local subnet and Tailscale CGNAT range (`100.64.0.0/10`).
- **Optimization**: LXC resources tuned (2 vCPUs, 1GB RAM for AdGuard) to handle massive filter lists without API latency.

### Remote Access
- Utilizes **Tailscale Split-DNS**.
- Global Nameserver set to the AdGuard Tailscale IP with "Override Local DNS" enabled.
- Result: Mobile devices maintain ad-blocking and recursive privacy even on cellular data.

## 🚀 Key Features
- **Privacy**: No personal DNS data collection by third-party providers.
- **Performance**: Sub-1ms response times for cached queries.
- **Security**: DNSSEC validation enabled via Unbound.
- **Monitoring**: Real-time metrics via Netdata integration on the Proxmox host.
