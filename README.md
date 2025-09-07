<img height="300px" width="500px" src="https://github.com/Prashant42125/KieLeo/blob/main/Banner.png?raw=true"/>


# 🕷️ KIELEO
**KIELEO** is an automated web reconnaissance tool designed to make information gathering faster, cleaner, and more structured. Whether you're a penetration tester, bug bounty hunter, or security researcher — this tool helps you quickly collect subdomains, live domains, URLs, parameters, WHOIS info, and more with just a few flags.

---

## 🚀 Features

- 🔍 **Subdomain Enumeration** (via `subfinder`, `assetfinder`)
- 🌐 **Live Domain Detection** (via `httpx`)
- 🧠 **URL Collection** (via `gau`)
- 🧪 **Parameter Discovery** (via `ParamSpider`)
- 📜 **WHOIS Lookup**
- 🕳️ **Wayback Machine Data** (via `waybackurls`)
- 🔎 **Port Scanning** (via `naabu`)
- 📂 **Organized Output** (each target in its own directory)

---

## 📥 Installation

1. **Clone the repository**

```bash
git clone https://github.com/yourusername/shadowrecon.git
cd shadowrecon
chmod +x recon.sh
```


## ⚙️ Requirements

Make sure the following tools are installed and available in your `PATH`:
```bash
- [`subfinder`](https://github.com/projectdiscovery/subfinder)
- [`assetfinder`](https://github.com/tomnomnom/assetfinder)
- [`httpx-tool`](https://www.kali.org/tools/httpx-toolkit/)
- [`gau`](https://github.com/lc/gau)
- [`ParamSpider`](https://github.com/devanshbatham/ParamSpider)
- [`waybackurls`](https://github.com/tomnomnom/waybackurls)
- [`naabu`](https://github.com/projectdiscovery/naabu)
- `curl`, `grep`, `bash`
```

## 📥 Installation of Tools using go
```bash
$ go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
$ go install github.com/tomnomnom/assetfinder@latest
$ go install github.com/lc/gau/v2/cmd/gau@latest
$ go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
$ go install github.com/tomnomnom/waybackurls@latest
```

🧪 Usage
```bash
./recon.sh <domain> <flags>
```

```bash
🔹 Example:
./recon.sh example.com --httpx --urls --whois
```

📖 Available Flags
Flag	Description
```bash
-h, --help	Show help menu
-hx, --httpx	Detect live domains
-u, --urls	Extract URLs using gau
-p, --parameter	Find GET parameters (ParamSpider)
-w, --wayback	Fetch Wayback URLs
--whois	Run WHOIS lookup
-ps, --portscan	Scan open ports using naabu
```

💡 You can combine multiple flags in one run.

📂 Output

All data is stored inside a folder named after the target domain:
```bash
example.com/
├── sub-domains.txt
├── live_domains.txt
├── urls.txt
├── parameter.txt
├── waybackurls.txt
├── whois.txt
├── openports.txt
```

🧑‍💻 Author
Prashant Swami
```bash
🔗 LinkedIn : https://www.linkedin.com/in/prashant-s-swami
``` A quick demo is available to show how KieLeo works.

