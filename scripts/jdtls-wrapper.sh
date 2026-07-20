#!/bin/bash
# JDTLS Wrapper - auto-repair corrupted indices

JDTLS_DIR="${HOME}/.local/share/nvim/mason/packages/jdtls"
WORKSPACE_DIR="${1:-.}"

# Extract workspace name from data parameter
for arg in "$@"; do
  if [[ "$prev_arg" == "-data" ]]; then
    WORKSPACE_DIR="$arg"
    break
  fi
  prev_arg="$arg"
done

# Function to clean corrupted indices
cleanup_indices() {
  local metadata_dir="${WORKSPACE_DIR}/.metadata"
  if [ -d "$metadata_dir/.plugins/org.eclipse.jdt.core" ]; then
    rm -rf "$metadata_dir/.plugins/org.eclipse.jdt.core"
    echo "Cleaned corrupted JDTLS indices" >&2
  fi
}

# Run JDTLS with error handling
"${JDTLS_DIR}/bin/jdtls" "$@" 2>&1 | while IFS= read -r line; do
  echo "$line"
  
  # Check for index corruption errors
  if echo "$line" | grep -q "UTFDataFormatException\|FileNotFoundException.*\.index"; then
    cleanup_indices
  fi
done
