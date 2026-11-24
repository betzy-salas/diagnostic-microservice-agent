#!/usr/bin/env bash
# Instala (o desinstala) Agente Q para GitHub Copilot a nivel de usuario.
# Uso:
#   ./install.sh              Instala o actualiza
#   ./install.sh --uninstall  Elimina los agentes y skills de Agente Q
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COPILOT_DIR="${HOME}/.copilot"
AGENTS_DIR="${COPILOT_DIR}/agents"
SKILLS_DIR="${COPILOT_DIR}/skills"

uninstall() {
  echo "Desinstalando Agente Q..."
  for f in "${KIT_DIR}"/agents/*.agent.md; do
    target="${AGENTS_DIR}/$(basename "$f")"
    if [ -f "$target" ]; then rm -f "$target"; echo "  eliminado: $target"; fi
  done
  for d in "${KIT_DIR}"/skills/*/; do
    target="${SKILLS_DIR}/$(basename "$d")"
    if [ -d "$target" ]; then rm -rf "$target"; echo "  eliminado: $target"; fi
  done
  echo "Listo. Recarga VS Code (Developer: Reload Window)."
}

if [ "${1:-}" = "--uninstall" ]; then
  uninstall
  exit 0
fi

# Si ~/.copilot/agents es un repositorio clonado (agente anterior), no se instala encima.
if [ -d "${AGENTS_DIR}/.git" ]; then
  echo "ERROR: ${AGENTS_DIR} es un clon de Git (agente anterior)."
  echo "Renómbralo y vuelve a ejecutar este script, por ejemplo:"
  echo "  mv \"${AGENTS_DIR}\" \"${AGENTS_DIR}-old\""
  exit 1
fi

mkdir -p "${AGENTS_DIR}" "${SKILLS_DIR}"

echo "Agente Q - con licencia para evolucionar"
echo "Kit: ${KIT_DIR}"
echo "Versión: $(cat "${KIT_DIR}/VERSION" 2>/dev/null || echo 'desconocida')"

echo "Instalando agentes en ${AGENTS_DIR}..."
for f in "${KIT_DIR}"/agents/*.agent.md; do
  cp -f "$f" "${AGENTS_DIR}/"
  echo "  $(basename "$f")"
done

echo "Instalando skills en ${SKILLS_DIR}..."
for d in "${KIT_DIR}"/skills/*/; do
  name="$(basename "$d")"
  rm -rf "${SKILLS_DIR:?}/${name}"
  cp -R "$d" "${SKILLS_DIR}/${name}"
  echo "  ${name}"
done

echo
echo "Instalación completa. En VS Code ejecuta: Developer: Reload Window"
