# vim:ft=bash
declare -a DEPENDENCIES="(python3 pip)"

# Function that displays error messages
function error() {
  local MESSAGE="$1"
  # Check if stderr is in interactive mode
  if [[ -t 2 ]]; then
    >&2 printf "%b\n" "\033[01;31mERROR\033[0m: $MESSAGE"
  else
    >&2 printf "%s\n" "ERROR: $MESSAGE"
  fi
  exit 1
}

# Function that displays info messages
function info() {
  local MESSAGE="$1"
  # Check if stdout is in interactive mode
  if [[ -t 1 ]]; then
    printf "%b\n" "\033[01;34mINFO\033[0m: $MESSAGE"
  else
    printf "%s\n" "INFO: $MESSAGE"
  fi
}

# Check if the script is run as root
function checkRoot() {
  if ((EUID == 0)); then
    error "Please don't run this script as root"
  fi
}

# Check if dependencies are installed
function checkDependencies() {
  for CMD in "${DEPENDENCIES[@]}"; do
    if ! command -v "$CMD" &>/dev/null; then
      if [[ "$CMD" == "pip" ]]; then
        error "python-pip is not installed"
      else
        error "$CMD is not installed"
      fi
    fi
  done
}

# Create and enter Python environment
function initializeEnvironment() {
  # Create new Python virtual environment
  python3 -m venv ".env"
}

# Install playbook dependencies
function installRequirements() {
  # Install python requirements
  pip install -r "requirements.txt"
  # Install ansible requirements
  ansible-galaxy install -r "requirements.yaml"
}

# Main function
function main() {
  checkRoot
  checkDependencies
  initializeEnvironment
  installRequirements
}

# Stop script execution immediately
# If any command below fails
set -o "errexit"
# Pause the script on fail
trap "read -r -p 'Press any key to continue...'" EXIT

# Execute main function
main "$@"

# Disable trap
trap "" EXIT
