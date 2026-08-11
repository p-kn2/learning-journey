#!/bin/bash

# ==============================================================================
#                      DevOps Tooling Installer Script
# ==============================================================================
# Safe execution settings: Stop immediately if a command fails
set -eo pipefail

# ------------------------------------------------------------------------------
# 1. Colors & Formatting Setup (Makes terminal output easy to read)
# ------------------------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color / Reset

# Logger functions for simple messaging
log_section() { echo -e "\n${BLUE}====================================================${NC}"; echo -e "${BLUE}  $1${NC}"; echo -e "${BLUE}====================================================${NC}"; }
log_info()    { echo -e "${YELLOW}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# Catch any unexpected errors and print the line number
trap 'log_error "Installation failed at line $LINENO! Check the error messages above."' ERR

# ------------------------------------------------------------------------------
# 2. Pre-flight Checks (Verify root privileges)
# ------------------------------------------------------------------------------
log_section "STEP 1: Checking Permissions"

if [ "$EUID" -ne 0 ]; then
  log_error "This script must be run as root or with sudo!"
  echo "Usage: sudo ./userdata.sh"
  exit 1
fi
log_success "Root privileges verified."

# Non-interactive mode so apt won't stop for user input screens
export DEBIAN_FRONTEND=noninteractive

# Interactive prompt function with 5-second auto-yes timer
ask_install() {
  local package_name="$1"
  local timeout=5

  # Auto-select YES if running headlessly (like EC2 user-data)
  if [ ! -t 0 ]; then
    log_info "Non-interactive mode detected. Auto-installing $package_name..."
    return 0
  fi

  echo -n -e "${YELLOW}[PROMPT]${NC} Do you want to install $package_name? [Y/n] (Auto-YES in ${timeout}s): "
  read -t $timeout -n 1 choice || true
  echo ""

  case "$choice" in
    [nN])
      log_info "Skipped $package_name."
      return 1
      ;;
    *)
      log_info "Proceeding with $package_name installation..."
      return 0
      ;;
  esac
}

# ------------------------------------------------------------------------------
# 3. Core System Updates & Essential Utilities
# ------------------------------------------------------------------------------
if ask_install "System Updates & Core Tools (git, curl, wget, unzip, jq)"; then
  log_section "STEP 2: Updating Ubuntu & Installing Core Utilities"
  apt-get update -y
  apt-get install -y ca-certificates curl gnupg lsb-release git jq unzip tree wget apt-transport-https
  log_success "Core system utilities installed."
fi

# ------------------------------------------------------------------------------
# 4. Docker & Docker Compose
# ------------------------------------------------------------------------------
if ask_install "Docker Container Engine"; then
  log_section "STEP 3: Installing Docker & Docker Compose"
  apt-get install -y docker.io docker-compose-v2
  systemctl enable --now docker
  
  # Allow the 'ubuntu' user to run docker without sudo
  if id "ubuntu" &>/dev/null; then
    usermod -aG docker ubuntu
    log_info "Added user 'ubuntu' to docker group."
  fi
  
  # Test if docker daemon is running
  docker info >/dev/null 2>&1 && log_success "Docker service is active and running!"
fi

# ------------------------------------------------------------------------------
# 5. AWS CLI v2
# ------------------------------------------------------------------------------
if ask_install "AWS CLI v2"; then
  log_section "STEP 4: Installing AWS Command Line Interface (v2)"
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
  unzip -q -o /tmp/awscliv2.zip -d /tmp
  /tmp/aws/install --update
  rm -rf /tmp/aws /tmp/awscliv2.zip
  
  log_success "AWS CLI Version: $(aws --version)"
fi

# ------------------------------------------------------------------------------
# 6. Terraform
# ------------------------------------------------------------------------------
if ask_install "HashiCorp Terraform"; then
  log_section "STEP 5: Installing HashiCorp Terraform"
  mkdir -p /etc/apt/keyrings
  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /etc/apt/keyrings/hashicorp.gpg
  echo "deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
  
  apt-get update -y
  apt-get install -y terraform
  log_success "Terraform Version: $(terraform --version | head -n 1)"
fi

# ------------------------------------------------------------------------------
# 7. Java 21 & Jenkins
# ------------------------------------------------------------------------------
if ask_install "Jenkins CI/CD Automation Server"; then
  log_section "STEP 6: Installing Java 21 & Jenkins"
  apt-get install -y openjdk-21-jre fontconfig
  
  wget -O /usr/share/keyrings/jenkins.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
  echo "deb [signed-by=/usr/share/keyrings/jenkins.asc] https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list
  
  apt-get update -y
  apt-get install -y jenkins
  systemctl enable --now jenkins
  log_success "Jenkins installed and service started on port 8080."
fi

# ------------------------------------------------------------------------------
# 8. SonarQube Container
# ------------------------------------------------------------------------------
if ask_install "SonarQube (Code Quality Tool via Docker)"; then
  log_section "STEP 7: Deploying SonarQube as a Docker Container"
  
  # ElasticSearch requirement for SonarQube
  sysctl -w vm.max_map_count=524288
  echo "vm.max_map_count=524288" >> /etc/sysctl.conf

  docker run -d --name sonarqube \
    -p 9000:9000 \
    --restart unless-stopped \
    sonarqube:community
    
  log_success "SonarQube container launched on port 9000."
fi

# ------------------------------------------------------------------------------
# 9. Kubernetes CLI (kubectl) & Helm
# ------------------------------------------------------------------------------
if ask_install "Kubernetes CLI (kubectl) & Helm"; then
  log_section "STEP 8: Installing kubectl & Helm"
  
  # kubectl
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes.gpg
  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' > /etc/apt/sources.list.d/kubernetes.list
  
  # Helm
  curl https://baltocdn.com/helm/signing.asc | gpg --dearmor -o /etc/apt/keyrings/helm.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" > /etc/apt/sources.list.d/helm.list

  apt-get update -y
  apt-get install -y kubectl helm
  log_success "kubectl and Helm successfully installed."
fi

# ------------------------------------------------------------------------------
# 10. Cleanup & Summary
# ------------------------------------------------------------------------------
log_section "STEP 9: Cleaning Up Temporary Files"
apt-get autoremove -y >/dev/null 2>&1

log_section "ALL INSTALLATIONS COMPLETE!"
echo -e "${GREEN}Service Web URLs:${NC}"
echo -e " • Jenkins:   ${BLUE}http://<YOUR-EC2-PUBLIC-IP>:8080${NC}"
echo -e " • SonarQube: ${BLUE}http://<YOUR-EC2-PUBLIC-IP>:9000${NC} (Login: admin / admin)"
echo ""
echo -e "${YELLOW}Note:${NC} If you are using the 'ubuntu' user account, log out and reconnect to run docker without 'sudo'."