#!/bin/bash
# Script para capturar erros do Neovim

LOG_FILE="$HOME/.nvim_error_log.txt"

echo "Abrindo Neovim com captura de erros..."
echo "Log será salvo em: $LOG_FILE"
echo ""

# Abrir nvim e capturar TODOS os outputs
nvim "$@" 2>&1 | tee "$LOG_FILE"

echo ""
echo "✓ Erros capturados em: $LOG_FILE"
echo ""
echo "Para ver os erros:"
echo "  cat $LOG_FILE"
