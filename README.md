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
## 🔍 Bug Log & Resolution

### Issue: Intermittent `NXDOMAIN` on Major Domains (e.g., Amazon.de)
* **Symptom:** Browser intermittently fails to resolve global domains, returning `DNS_PROBE_FINISHED_NXDOMAIN`. Refreshing after 30–60 seconds resolves the issue.
* **Diagnosis:** Recursive lookup latency. Unbound (recursive mode) was taking longer to query root servers than the browser's timeout threshold.
* **Resolution:** 
	1.  **Parallel Upstreams:** Reconfigured AdGuard Home to use "Parallel Requests," querying both the local Unbound instance and high-speed fallbacks (Quad9/Cloudflare) simultaneously.
    	2.  **Optimistic Caching:** Enabled `serve-expired` in Unbound to provide immediate responses from cache while refreshing records in the background.
    	3.  **DNS Rebind Protection:** Added critical domains to the Fritz!Box exception list to prevent the router from dropping valid local DNS responses.
### ⚡ Energy Profile & Efficiency
* **Idle Power (CPU/RAM):** ~22.6 Watts
* **Monitoring Stack:** * **Primary:** Intel RAPL (Running Average Power Limit) interface for high-precision energy telemetry.
* **Visualization:** Netdata Dashboard integration via the `powercap` collector.
* **Optimization:** Even with a high TDP Xeon E5-1650 v3, the system is tuned for low-power idle states, ensuring a cost-effective 24/7 DNS infrastructure.
