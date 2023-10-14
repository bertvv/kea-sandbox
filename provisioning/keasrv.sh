#! /bin/bash
#
# Provisioning script for srv001

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------

# Location of provisioning scripts and files
readonly PROVISIONING_SCRIPTS="/vagrant/provisioning/"
# Location of files to be copied to this server
readonly PROVISIONING_FILES="${PROVISIONING_SCRIPTS}/files/${HOSTNAME}"

export PROVISIONING_SCRIPTS PROVISIONING_FILES

#------------------------------------------------------------------------------
# "Imports"
#------------------------------------------------------------------------------

# shellcheck disable=1091
source ${PROVISIONING_SCRIPTS}/util.sh    # Utility functions

# shellcheck disable=1091
source ${PROVISIONING_SCRIPTS}/common.sh  # Actions common to all hosts

#------------------------------------------------------------------------------
# Provision server
#------------------------------------------------------------------------------

log "Starting server specific provisioning tasks on ${HOSTNAME}"

log "Installing packages"
dnf install -y epel-release
dnf install -y kea

log "Copy configuration files"

if files_differ "${PROVISIONING_FILES}/kea-dhcp4.conf" /etc/kea/kea-dhcp4.conf; then
  log " -> Syntax check"
  kea-dhcp4 -t "${PROVISIONING_FILES}/kea-dhcp4.conf"

  log " -> Copying kea-dhcp4.conf"
  cp "${PROVISIONING_FILES}/kea-dhcp4.conf" /etc/kea/kea-dhcp4.conf
fi

ensure_running kea-dhcp4.service