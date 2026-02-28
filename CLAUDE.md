# Allied Group Website

## Project Type
Quarto website (v1.4.549) for Allied Group — UK on-site construction services umbrella brand.

## Brand Architecture
- **Allied** (parent umbrella)
- **Allied Lifting** — Crane operations & lifting services (established)
- **Allied Logistics** — Construction logistics coordination (new)
- **Allied Scaffolding** — Scaffolding services (new, placeholder)

## Key Contact
- Ambrose Greham, Managing Director
- 07450 649110 / Ambrose@alliedlifting.co.uk

## Brand Colors
- Primary Navy: `#1B365D`
- Gold Accent: `#D4A843`
- Charcoal: `#2D2D2D`
- Light Grey: `#F5F5F5`

## Typography
- Headings: Montserrat 600/700 (italic for logo wordmarks)
- Body: Inter 400/500
- Loaded via Google Fonts in `_quarto.yml` `include-in-header`

## Tech Stack & Conventions
- **Quarto 1.4.549** — use `{{< var >}}` shortcodes, avoid `{{< meta >}}` inside includes
- **Theme**: Bootstrap `cosmo` base + `styles/allied-theme.scss` overrides
- **Page layout**: `page-layout: full` with `:::` fenced divs + Bootstrap grid classes for full-width sections
- **Images**: CSS gradient placeholders (no real photos yet)
- **SVG logos**: All in `assets/images/`, share identical "A" mark geometry with different wordmarks
- **Footer**: Uses `page-footer` (not `footer`) in `_quarto.yml`
- **Variables**: `_variables.yml` loaded via `metadata-files` in `_quarto.yml`

## File Structure
```
_quarto.yml          — Site config, navbar, footer
_variables.yml       — Company data, contact, brand colors
styles/allied-theme.scss — SCSS theme
assets/images/       — SVG logos and favicon
lifting/index.qmd    — Allied Lifting division
logistics/index.qmd  — Allied Logistics division
scaffolding/index.qmd — Allied Scaffolding division
```

## Source Materials
Marketing PDFs and docs at:
`/Users/robertkowalski/Library/CloudStorage/OneDrive-SharedLibraries-LunaBusinessAdvantageLtd/ALLIED - Documents/01-MARKETING/`

## GitHub
Repository: https://github.com/robertkowalski1974/allied-website
