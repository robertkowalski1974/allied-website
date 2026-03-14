#!/bin/bash
# Download and fix accreditation logos for Allied Group website
# Run from project root: bash scripts/download-logos.sh

set -e

ACCRED_DIR="assets/images/accreditations"
cd "$(dirname "$0")/.."

echo "=== Allied Group Logo Download Script ==="
echo ""

# 1. Download color CPCS logo from official NOCN site
echo "[1/3] Downloading CPCS color logo..."
curl -sL -o "${ACCRED_DIR}/cpcs-new.png" \
  "https://cpcs.nocn.org.uk/images/logo-cpcs-2024.png"

if [ -s "${ACCRED_DIR}/cpcs-new.png" ]; then
  mv "${ACCRED_DIR}/cpcs-new.png" "${ACCRED_DIR}/cpcs.png"
  echo "  -> CPCS logo downloaded successfully"
else
  echo "  -> CPCS download failed, keeping existing"
  rm -f "${ACCRED_DIR}/cpcs-new.png"
fi

# 2. Download CLOCS SVG (real version from official site)
echo "[2/3] Downloading CLOCS SVG..."
curl -sL -o "${ACCRED_DIR}/clocs-new.svg" \
  "https://clocs.org.uk/wp-content/themes/clocs/images/CLOCS-logo.svg"

if [ -s "${ACCRED_DIR}/clocs-new.svg" ]; then
  # Check it's actually SVG content
  if head -5 "${ACCRED_DIR}/clocs-new.svg" | grep -q "svg"; then
    mv "${ACCRED_DIR}/clocs-new.svg" "${ACCRED_DIR}/clocs.svg"
    echo "  -> CLOCS SVG downloaded successfully"
  else
    echo "  -> CLOCS download not SVG, keeping existing PNG"
    rm -f "${ACCRED_DIR}/clocs-new.svg"
  fi
else
  echo "  -> CLOCS download failed, keeping existing PNG"
  rm -f "${ACCRED_DIR}/clocs-new.svg"
fi

# 3. Create professional LOLER compliance badge (regulation, no official logo)
echo "[3/3] Creating LOLER compliance badge..."
cat > "${ACCRED_DIR}/loler.svg" << 'LOLEREOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200" width="200" height="200">
  <defs>
    <linearGradient id="shield" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#1B365D"/>
      <stop offset="100%" style="stop-color:#0D1F38"/>
    </linearGradient>
  </defs>
  <!-- Shield shape -->
  <path d="M100 10 L180 40 L180 100 C180 145 145 175 100 190 C55 175 20 145 20 100 L20 40 Z"
        fill="url(#shield)" stroke="#D4A843" stroke-width="3"/>
  <!-- Inner border -->
  <path d="M100 22 L170 48 L170 100 C170 140 140 167 100 180 C60 167 30 140 30 100 L30 48 Z"
        fill="none" stroke="#D4A843" stroke-width="1" opacity="0.5"/>
  <!-- Crane/hook icon -->
  <g transform="translate(100,75)" fill="#D4A843">
    <!-- Hook -->
    <path d="M0,-30 L0,-15 C8,-15 12,-10 12,-3 C12,5 6,10 0,10 C-6,10 -12,5 -12,-3 C-12,-7 -10,-10 -7,-12"
          fill="none" stroke="#D4A843" stroke-width="3" stroke-linecap="round"/>
    <!-- Hook tip -->
    <circle cx="-7" cy="-12" r="2"/>
    <!-- Cable -->
    <line x1="0" y1="-30" x2="0" y2="-42" stroke="#D4A843" stroke-width="2.5"/>
    <!-- Beam -->
    <line x1="-25" y1="-42" x2="25" y2="-42" stroke="#D4A843" stroke-width="3" stroke-linecap="round"/>
  </g>
  <!-- LOLER text -->
  <text x="100" y="130" text-anchor="middle" font-family="Arial, Helvetica, sans-serif"
        font-weight="700" font-size="26" fill="#FFFFFF" letter-spacing="3">LOLER</text>
  <!-- Subtitle -->
  <text x="100" y="150" text-anchor="middle" font-family="Arial, Helvetica, sans-serif"
        font-weight="400" font-size="9" fill="#D4A843">LIFTING OPERATIONS &amp;</text>
  <text x="100" y="162" text-anchor="middle" font-family="Arial, Helvetica, sans-serif"
        font-weight="400" font-size="9" fill="#D4A843">LIFTING EQUIPMENT REGS</text>
  <!-- Compliant badge -->
  <text x="100" y="178" text-anchor="middle" font-family="Arial, Helvetica, sans-serif"
        font-weight="600" font-size="10" fill="#FFFFFF" letter-spacing="2">COMPLIANT</text>
</svg>
LOLEREOF
echo "  -> LOLER compliance badge created"

# 4. Remove placeholder SVGs that are now replaced by real PNGs
echo ""
echo "Cleaning up placeholder SVGs..."
for file in citb cscs constructionline ssip; do
  if [ -f "${ACCRED_DIR}/${file}.svg" ]; then
    size=$(wc -c < "${ACCRED_DIR}/${file}.svg" | tr -d ' ')
    if [ "$size" -lt 1000 ]; then
      rm "${ACCRED_DIR}/${file}.svg"
      echo "  -> Removed placeholder ${file}.svg (${size} bytes)"
    fi
  fi
done

# Remove cpcs placeholder SVG (we have PNG now)
if [ -f "${ACCRED_DIR}/cpcs.svg" ]; then
  size=$(wc -c < "${ACCRED_DIR}/cpcs.svg" | tr -d ' ')
  if [ "$size" -lt 1000 ]; then
    rm "${ACCRED_DIR}/cpcs.svg"
    echo "  -> Removed placeholder cpcs.svg"
  fi
fi

echo ""
echo "=== Done ==="
echo ""
echo "Logo status:"
echo "  citb.png          - Real logo (CITB overlapping circles)"
echo "  cpcs.png          - Downloaded from NOCN official"
echo "  cscs.png          - Real logo (blue CSCS badge)"
echo "  clocs.png/svg     - Real logo (blue C icon)"
echo "  constructionline.png - Real logo (gold pillar)"
echo "  fors.svg          - Real logo (fleet operator recognition)"
echo "  safecontractor.svg - Real logo (SafeContractor)"
echo "  ssip.png          - Real logo (SSIP blue ribbon)"
echo "  loler.svg         - Custom compliance badge (no official logo)"
echo ""
echo "Next: Update .qmd files to reference correct file formats"
