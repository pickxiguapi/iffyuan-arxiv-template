# iffyuan LaTeX Template

A clean, single-column academic paper template for arXiv preprints.

## Quick Start

```bash
# 1. Copy the template folder and rename it
cp -r iffyuan-template/ my-new-paper/
cd my-new-paper/

# 2. Edit main.tex — fill in title, authors, abstract, sections

# 3. Compile
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

## File Structure

```
iffyuan-template/
├── iffyuan.cls          # Template style (do not edit unless updating template)
├── main.tex             # Main document — start here
├── references.bib       # Bibliography entries
├── changelog.md         # Template version history
├── figures/
│   ├── team-logo.png    # Team logo (shown in title box)
│   ├── github-logo.pdf  # GitHub icon for metadata
│   └── hf-logo.pdf      # HuggingFace icon for metadata
```

## Template Features

- **Title box**: Rounded corners, light grey-purple background, team logo support
- **Fonts**: Palatino + XCharter (serif), Latin Modern Sans (headings), mathpazo (math)
- **Author system**: `\author[1]{Name}`, `\affiliation[1]{Inst}`, `\contribution`, `\metadata`
- **Icons**: FontAwesome5 + custom PDF logos for metadata links
- **Bibliography**: natbib (author, year) with `plainnat` style
- **Layout**: 2.2cm margins, minimal header/footer (page number only)

## Submitting to arXiv

### Step 1: Full compile locally

Make sure the paper compiles cleanly with references:

```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

Verify `main.pdf` looks correct.

### Step 2: Check that `main.bbl` exists

arXiv does **not** run `bibtex`. You must include the `.bbl` file:

```bash
ls main.bbl   # This file must exist after bibtex
```

### Step 3: Identify files to include

Required files:
- `main.tex` — main document
- `iffyuan.cls` — template class
- `main.bbl` — compiled bibliography (**required**, arXiv won't run bibtex)
- `figures/` — all images referenced in the paper

Optional:
- `references.bib` — not strictly needed if `.bbl` is included, but good practice
- Any additional `.tex` files loaded via `\input{}`

### Step 4: Clean up build artifacts

```bash
# Remove files that should NOT be uploaded
rm -f main.pdf main.aux main.log main.out main.blg main.synctex.gz
```

### Step 5: Package everything

```bash
# From the paper directory, create a tar.gz for upload
cd my-new-paper/
tar -czf ../my-new-paper-arxiv.tar.gz \
  main.tex \
  iffyuan.cls \
  main.bbl \
  references.bib \
  figures/

# Verify contents
tar -tzf ../my-new-paper-arxiv.tar.gz
```

### Step 6: Upload to arXiv

1. Go to https://arxiv.org/submit
2. Upload `my-new-paper-arxiv.tar.gz`
3. arXiv will auto-detect `main.tex` as the main file and compile with `pdflatex`
4. Check the preview PDF — if it looks good, proceed to submit

### Troubleshooting arXiv submission

| Problem | Solution |
|---|---|
| References show as `[?]` | You forgot to include `main.bbl` |
| "Multiple main files" error | Add `00README.json` to specify: `{"sources": [{"usage": "toplevel", "filename": "main.tex"}], "spec_version": 1}` |
| Font errors | Make sure you're not using system fonts — `iffyuan.cls` uses only TeX Live bundled fonts, so this should be fine |
| Missing figure | Check that all paths in `\includegraphics` match the files in your `figures/` directory |
| Need xelatex/lualatex | Add `00README.json` with `"process": {"compiler": "xelatex"}` — but this template uses pdflatex by default |

## Updating the Template

When modifying `iffyuan.cls`, remember to update `changelog.md` with:
- Date and version number
- What changed and why
