# tutor-setup

A [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skill that transforms knowledge sources into an **Obsidian StudyVault** — structured, interlinked study notes ready for active recall.

## Features

### Document Mode

Transforms PDFs, text files, web pages, and other knowledge sources into comprehensive study notes.

- Auto-scans working directory for source files (PDF, TXT, MD, HTML, EPUB)
- Extracts and analyzes content with verified source mapping
- Generates concept notes with comparison tables, ASCII diagrams, and exam patterns
- Creates practice questions with hidden answers (active recall via fold callouts)
- Builds a dashboard with Map of Content (MOC), Quick Reference, and Exam Traps
- Full interlinking with `[[wiki-links]]` across all notes

### Codebase Mode

Generates a new-developer onboarding vault from a source code project.

- Auto-detects tech stack, architecture patterns, and module boundaries
- Traces request flows and data flows end-to-end
- Creates per-module notes with key files, public interfaces, and dependency maps
- Generates onboarding exercises (code reading, configuration, debugging, extension)
- Builds a dashboard with architecture overview, module map, API surface, and getting started guide

### Auto Mode Detection

The skill automatically detects which mode to use based on project markers in the current directory:

| Marker Found | Mode |
|---|---|
| `package.json`, `pom.xml`, `build.gradle`, `Cargo.toml`, `go.mod`, etc. | Codebase Mode |
| No project markers | Document Mode |

## Installation

### Option 1: Clone + Install Script (Recommended)

```bash
git clone https://github.com/RoundTable02/tutor-skills.git
cd tutor-skills
./install.sh
```

### Option 2: Manual Copy

Copy the `skill/` directory contents to your Claude Code skills folder:

```bash
mkdir -p ~/.claude/skills/tutor-setup/references
cp skill/SKILL.md ~/.claude/skills/tutor-setup/
cp skill/references/* ~/.claude/skills/tutor-setup/references/
```

### Option 3: Download ZIP

1. Download the ZIP from the [Releases](https://github.com/RoundTable02/tutor-skills/releases) page
2. Extract and run `./install.sh`

## Usage

### Document Mode

Place your source files (PDF, TXT, MD, etc.) in a directory, then:

```
cd ~/study-materials/
claude
> /tutor-setup
```

The skill will scan for source files, analyze content, and generate a `StudyVault/` directory with structured Obsidian notes.

### Codebase Mode

Navigate to any source code project:

```
cd ~/projects/my-app/
claude
> /tutor-setup
```

The skill detects project markers and generates an onboarding vault in `StudyVault/`.

## Generated Vault Structure

### Document Mode

```
StudyVault/
  00-Dashboard/          # MOC + Quick Reference + Exam Traps
  01-<Topic1>/           # Concept notes + practice questions
  02-<Topic2>/
  ...
```

### Codebase Mode

```
StudyVault/
  00-Dashboard/          # MOC + Quick Reference + Getting Started
  01-Architecture/       # System overview, request flow, data flow
  02-<Module1>/          # Per-module notes
  03-<Module2>/
  ...
  NN-DevOps/             # Build, deploy, CI/CD
  NN+1-Exercises/        # Onboarding exercises
```

## How It Works

### Document Mode Phases

| Phase | Name | Description |
|-------|------|-------------|
| D1 | Source Discovery | Scan, extract, and verify source content mapping |
| D2 | Content Analysis | Build topic hierarchy and dependency map |
| D3 | Tag Standard | Define English kebab-case tag registry |
| D4 | Vault Structure | Create numbered folders per topic |
| D5 | Dashboard | MOC, Quick Reference, Exam Traps |
| D6 | Concept Notes | Structured notes with tables, diagrams, callouts |
| D7 | Practice Questions | Active recall with fold callouts (8+ per topic) |
| D8 | Interlinking | Cross-reference all notes with wiki-links |
| D9 | Self-Review | Verify against quality checklist |

### Codebase Mode Phases

| Phase | Name | Description |
|-------|------|-------------|
| C1 | Project Exploration | Scan files, detect tech stack, map layout |
| C2 | Architecture Analysis | Identify patterns, trace flows, map modules |
| C3 | Tag Standard | Define `#arch-*`, `#module-*`, `#pattern-*` registry |
| C4 | Vault Structure | Create dashboard + per-module folders |
| C5 | Dashboard | MOC with module map, API surface, getting started |
| C6 | Module Notes | Purpose, key files, interface, flow, dependencies |
| C7 | Exercises | Code reading, config, debugging, extension tasks |
| C8 | Interlinking | Cross-link all modules and exercises |
| C9 | Self-Review | Verify against quality checklist |

## Requirements

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed and configured
- [Obsidian](https://obsidian.md/) (recommended) to open the generated vault

## Uninstall

```bash
./uninstall.sh
```

Or manually:

```bash
rm -rf ~/.claude/skills/tutor-setup
```

## License

[MIT](LICENSE)
