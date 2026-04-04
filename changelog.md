# iffyuan LaTeX Template — Changelog

## v1.0 (2026-04-05)

Initial release.

### Fonts
- Serif: Palatino (tgpagella) + XCharter for main text
- Math: mathpazo (Palatino math)
- Sans-serif: Latin Modern Sans (lmss) — used for section titles, captions, bold text
- Monospace: zlmtt (scaled 1.1)

### Layout
- Base class: `extarticle`
- Margins: 2.2cm left/right, 2.25cm top, 2.5cm bottom
- Single column, letterpaper

### Title Box
- arXiv/FAIR style: rounded corners (`arc=10pt`), light grey-purple background (`#f4f3f7`)
- Title: 20.2pt sans-serif bold
- Author system: `\author[affil]{Name}`, `\affiliation[id]{Institution}`, `\contribution`, `\metadata`
- Team logo support: `\setteamlogo{path}` places logo at bottom-right of title box
- Metadata with FontAwesome5 icons (`\faGlobe`, `\faGithub`, `\faDatabase`, `\faEnvelope`)

### Section Headings
- Sans-serif bold (`\sffamily\bfseries`)
- `\section`: `\Large`, `\subsection`: `\large`, `\subsubsection`: `\normalsize`

### Header / Footer
- Minimal: page number only (bottom-right), no header, no rules

### Links
- Citation & link color: deep purple-blue (`#300a7f`)
- URL color: `#371878`

### Other
- natbib (round, authoryear) for bibliography
- cleveref for smart cross-references
- tcolorbox `aibox` style available for highlight boxes
- Compact lists via enumitem (`noitemsep`)
