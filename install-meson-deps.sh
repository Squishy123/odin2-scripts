#!/usr/bin/env bash
set -e

MESON_FILE="${1:-meson.build}"

if [ ! -f "$MESON_FILE" ]; then
    echo "meson.build not found: $MESON_FILE"
    exit 1
fi

command -v meson >/dev/null || { echo "meson missing"; exit 1; }
command -v jq >/dev/null || { echo "jq missing (sudo apt install jq)"; exit 1; }
command -v pkg-config >/dev/null || { echo "pkg-config missing"; exit 1; }

echo "[*] Introspecting $MESON_FILE"

deps_json=$(meson introspect --dependencies "$MESON_FILE")

deps=$(echo "$deps_json" | jq -r '.[].name' | sort -u)

if [ -z "$deps" ]; then
    echo "[*] No dependencies found."
    exit 0
fi

echo "[*] Found deps:"
printf "  %s\n" $deps

missing=()

for dep in $deps; do
    if ! pkg-config --exists "$dep" 2>/dev/null; then
        missing+=("$dep")
    fi
done

if [ ${#missing[@]} -eq 0 ]; then
    echo "[*] All deps already present."
    exit 0
fi

echo "[*] Missing deps:"
printf "  %s\n" "${missing[@]}"

pkgs=()
unresolved=()

for pc in "${missing[@]}"; do
    echo "[*] Resolving $pc via apt search"

    base="${pc,,}"
    base="${base//_/-}"

    candidates=(
        "lib${base}-dev"
        "${base}-dev"
        "lib${base}"
        "${base}"
    )

    found=""

    for c in "${candidates[@]}"; do
        if apt search --names-only "^${c}$" 2>/dev/null | grep -q "^${c}/"; then
            found="$c"
            break
        fi
    done

    if [ -z "$found" ]; then
        found=$(apt search --names-only "$base" 2>/dev/null \
            | grep -E 'dev/' \
            | head -n1 \
            | cut -d/ -f1 || true)
    fi

    if [ -n "$found" ]; then
        pkgs+=("$found")
    else
        unresolved+=("$pc")
    fi
done

if [ ${#pkgs[@]} -gt 0 ]; then
    echo
    echo "[*] Installing packages:"
    printf "  %s\n" "${pkgs[@]}"
    sudo apt install -y "${pkgs[@]}"
fi

if [ ${#unresolved[@]} -gt 0 ]; then
    echo
    echo "[!] Unresolved dependencies:"
    printf "  %s\n" "${unresolved[@]}"
    echo
    echo "You may need to install these manually or enable extra repos."
fi

echo
echo "[✓] Done"
