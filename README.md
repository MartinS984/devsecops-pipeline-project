# DevSecOps Pipeline Project

[![DevSecOps Security Automation](https://github.com/<your-username>/<your-repo-name>/actions/workflows/devsecops-ci.yml/badge.svg)](https://github.com/<your-username>/<your-repo-name>/actions)

A production-ready, cloud-native Node.js application secured through a highly automated, multi-stage DevSecOps pipeline. This repository demonstrates container hardening, dependency mitigation, and automated static security testing (SAST/SCA/Secrets) using industry-standard cloud-native tools.

---

## 🚀 Architecture & Security Topology

This project shifts security "left" by integrating automated validation directly into the developer workflow and the GitHub Actions CI pipeline:

[ Developer Commit ] ──> [ Pre-Commit Hooks ] ──> [ Git Push ]
│
┌───────────────────────────────────────────────────────┘
▼
[ GitHub Actions CI Pipeline ]
├── 1. SAST & Dependency Code Scan (Parallel Jobs)
│    ├── TruffleHog (Credential & Secret Scanning)
│    ├── Trivy FS (Software Composition Analysis)
│    └── Semgrep (Static Application Security Testing)
│
└── 2. Container Hardening & Scan (Blocking Stage)
├── Docker Multi-Stage Build (Alpine, Non-root)
└── Trivy Image Scan (Container Vulnerability Gate)


---

## 🔒 Implemented Security Controls

### 1. Pre-Commit Guardrails
To prevent vulnerable code or secrets from ever reaching the remote repository, a local `pre-commit` configuration forces checks before a commit is finalized:
* **End-of-File Fixer & Whitespace Trimming:** Enforces formatting standards.
* **TruffleHog Local Scan:** Blocks commits containing plain-text keys or certificates.

### 2. Static Application Security Testing (SAST)
* **Semgrep CI Integration:** Scans application code for logical vulnerabilities, injection points, and insecure configuration patterns without requiring compilation.

### 3. Software Composition Analysis (SCA)
* **Trivy FS Scan:** Analyzes the dependency tree (`package-lock.json`) for known Common Vulnerabilities and Exposures (CVEs).
* **Vulnerability Gating:** Configured to fail the build if any `HIGH` or `CRITICAL` vulnerability is detected in the dependencies, blocking unsafe deployments.

### 4. Container Hardening (Docker Best Practices)
The `Dockerfile` is highly optimized and hardened for production:
* **Minimal Attack Surface:** Built on the lightweight `node:20-alpine` base image to eliminate unnecessary OS binaries.
* **Multi-Stage Build:** Dependencies are resolved in a discarded `builder` stage, ensuring the final runtime image contains only production packages.
* **Least Privilege Principle:** Creates a dedicated system user (`appuser`) and group (`appgroup`) to run the runtime process, ensuring the container does not run as `root`.
* **Container Layer Scan:** A post-build **Trivy Container Scan** inspects the compiled image layers for base-OS vulnerabilities before deployment.

---

## 🛠️ Tech Stack & Tooling

* **Runtime:** Node.js (Alpine Linux)
* **CI/CD Platform:** GitHub Actions
* **Security Scanners:** TruffleHog, Semgrep, Aqua Security Trivy
* **Build Engine:** Docker Buildx (Multi-Stage)

---

## 📦 Getting Started

### Prerequisites
* Docker & Docker Compose
* Node.js (v20+)
* pre-commit framework

### Installation & Local Run
1. Clone the repository:
   ```bash
   git clone https://github.com/https://github.com/MartinS984/devsecops-pipeline-project.git
   cd devsecops-pipeline-project
