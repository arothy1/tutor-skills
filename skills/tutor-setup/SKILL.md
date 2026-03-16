---
name: tutor-setup
description: >
  Transforms knowledge sources into an Obsidian StudyVault. Three modes:
  (1) Document Mode — PDF/text/web sources → study notes with practice questions.
  (2) Codebase Mode — source code project → onboarding vault for new developers.
  (3) Curriculum Mode — subject/grade input → structured learning vault from curriculum standards.
  Mode is auto-detected based on project markers and user input in CWD.
argument-hint: "[source-path-or-url OR subject description e.g. '초등3학년 수학']"
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Tutor Setup — Knowledge to Obsidian StudyVault

## CWD Boundary Rule (ALL MODES)

> **NEVER access files outside the current working directory (CWD).**
> All source scanning, reading, and vault output MUST stay within CWD and its subdirectories.
> If the user provides an external path, ask them to copy the files into CWD first.

## Mode Detection

On invocation, detect mode automatically:

1. **Check user argument** for curriculum keywords:
   - Grade/level indicators: `초등`, `중등`, `고등`, `elementary`, `middle`, `high`, `grade`, `학년`
   - Subject indicators: `수학`, `영어`, `국어`, `과학`, `사회`, `math`, `english`, `science`, `phonics`, `파닉스`
   - If argument matches curriculum pattern → **Curriculum Mode**
2. **Check for project markers** in CWD:
   - `package.json`, `pom.xml`, `build.gradle`, `Cargo.toml`, `go.mod`, `Makefile`,
     `*.sln`, `pyproject.toml`, `setup.py`, `Gemfile`
3. **If any project marker found** → **Codebase Mode**
4. **Check for document files** in CWD:
   - `*.pdf`, `*.txt`, `*.md`, `*.html`, `*.epub`
   - If found → **Document Mode**
5. **If no files and no markers** → **Curriculum Mode** (ask user for subject/grade)
6. **Tie-break**: If `.git/` is the sole indicator and no source code files exist, default to Document Mode.
7. Announce detected mode and ask user to confirm or override.

---

## Curriculum Mode

> Generates a structured StudyVault from curriculum standards — no source files needed.
> The user provides a subject and grade level (e.g., "초등 3학년 수학", "elementary phonics").
> AI generates learning objectives, concept explanations, examples, and practice questions.
> Templates: [curriculum-templates.md](references/curriculum-templates.md)

### Phase K1: Curriculum Specification

1. **Parse user input** to extract:
   - `subject`: 과목 (수학, 영어, 국어, 과학, etc.)
   - `grade`: 학년/레벨 (초등 1~6, 중등 1~3, etc.)
   - `scope`: 범위 (전체 학년 or 특정 단원)
2. **Confirm with user** using AskUserQuestion:
   - Show parsed subject, grade, scope
   - Ask if they want full curriculum or specific units
   - Ask target learner age (for language level calibration)
3. **Determine language level**:
   - 초등 1-2: 매우 쉬운 말, 짧은 문장, 그림 설명 위주
   - 초등 3-4: 쉬운 말, 예시 많이, 단계별 설명
   - 초등 5-6: 또래 수준 용어, 개념 설명 + 예시
   - 중등: 교과서 수준 용어, 개념 + 원리 설명
   - 고등: 정식 용어, 심화 개념

### Phase K2: Curriculum Structure Generation

1. **Generate curriculum outline** based on national curriculum standards:
   - Unit list with learning objectives per unit
   - Prerequisite dependencies between units
   - Estimated difficulty per unit (1-5 scale)
2. **Save as `curriculum.json`** in CWD:
   ```json
   {
     "subject": "수학",
     "grade": "초등 3학년",
     "language_level": "쉬운 말, 예시 많이, 단계별 설명",
     "units": [
       {
         "id": "unit-01",
         "name": "세 자리 수의 덧셈과 뺄셈",
         "objectives": [
           "세 자리 수의 덧셈을 할 수 있다",
           "받아올림이 있는 덧셈을 이해한다",
           "세 자리 수의 뺄셈을 할 수 있다",
           "뺄셈의 검산을 할 수 있다"
         ],
         "prerequisites": [],
         "difficulty": 1
       }
     ]
   }
   ```
3. **Present to user** for confirmation/modification before proceeding.

### Phase K3: Tag Standard

Define tag vocabulary:
- **Format**: English, lowercase, kebab-case
- **Hierarchy**: `#subject` → `#unit-name` → `#objective` → `#question-type`
- **Example**: `#math`, `#addition`, `#carry-over`, `#recall`
- **Registry**: Only registered tags allowed.

### Phase K4: Vault Structure

Create `StudyVault/` with curriculum-oriented structure:

```
StudyVault/
  00-Dashboard/              # Learning map + progress tracker
  01-<Unit1-Name>/           # Per-unit folder
    concept.md               # Concept explanation (age-appropriate)
    examples.md              # Worked examples with step-by-step
    practice.md              # Practice questions (8+ per unit)
  02-<Unit2-Name>/
    ...
  curriculum.json            # Curriculum definition (machine-readable)
```

### Phase K5: Dashboard Creation

Create `00-Dashboard/` per [curriculum-templates.md](references/curriculum-templates.md):

- **Learning Map**: Unit list with objectives, prerequisites, status
- **Progress Tracker**: Links to each unit's concept/practice files
- **Study Path**: Recommended order based on prerequisites
- **Quick Reference**: Key formulas/rules per unit with `→ [[Concept Note]]` links

### Phase K6: Concept Notes

Per [curriculum-templates.md](references/curriculum-templates.md). Key rules:
- YAML frontmatter: `unit`, `grade`, `subject`, `keywords` (MANDATORY)
- **Age-appropriate language**: Match `language_level` from K1
- **Structure per concept note**:
  1. "What are we learning?" — 1-2 sentence intro
  2. "Let's understand step by step" — broken into small steps
  3. Overview table for key points
  4. Visual aids: ASCII diagrams, number lines, tables
  5. "Common mistakes" section with `> [!warning]` callouts
  6. `## Related Notes` with `[[wiki-links]]`

### Phase K7: Worked Examples

Per unit, create `examples.md`:
- **3-5 worked examples** per learning objective
- Each example shows **full step-by-step solution**
- Difficulty progression: easy → medium → challenging
- Use `> [!tip]` callouts for key insights
- Include "Try it yourself" prompts between examples

### Phase K8: Practice Questions

Per [curriculum-templates.md](references/curriculum-templates.md). Key rules:
- **8+ questions per unit** covering all objectives
- **Active recall**: answers use `> [!answer]- 정답 보기` fold callout
- **Question type diversity**:
  - Recall (basic): 40% — "352 + 214 = ?"
  - Application: 30% — "민수는 사탕 245개, 영희는 132개. 합하면?"
  - Analysis: 20% — "왜 이 답이 틀렸는지 설명해보세요"
  - Challenge: 10% — harder problems for advanced learners
- **Difficulty markers**: Easy / Medium / Hard per question
- Hints available via `> [!hint]-` fold callouts
- `## Related Concepts` with `[[wiki-links]]`

### Phase K9: Interlinking

1. `## Related Notes` on every concept note
2. Learning Map links to every concept + practice note
3. Cross-link concept ↔ examples ↔ practice
4. Prerequisites linked: "Before this, review [[Previous Unit]]"
5. Quick Reference → `[[Concept Note]]` links

### Phase K10: Self-Review (MANDATORY)

Verify against [quality-checklist.md](references/quality-checklist.md) **Curriculum Mode** section. Fix and re-verify until all checks pass.

---

## Document Mode

> Transforms knowledge sources (PDF, text, web, epub) into study notes.
> Templates: [templates.md](references/templates.md)

### Phase D1: Source Discovery & Extraction

1. **Auto-scan CWD** for `**/*.pdf`, `**/*.txt`, `**/*.md`, `**/*.html`, `**/*.epub` (exclude `node_modules/`, `.git/`, `dist/`, `build/`, `StudyVault/`). Present for user confirmation.
2. **Extract text (MANDATORY tools)**:
   - **PDF → `pdftotext` CLI ONLY** (run via Bash tool). NEVER use the Read tool directly on PDF files — it renders pages as images and wastes 10-50x more tokens. Convert to `.txt` first, then Read the `.txt` file.
     ```bash
     pdftotext "source.pdf" "/tmp/source.txt"
     ```
   - If `pdftotext` is not installed, install it first: `brew install poppler` (macOS) or `apt-get install poppler-utils` (Linux).
   - URL → WebFetch
   - Other formats (`.md`, `.txt`, `.html`) → Read directly.
3. **Read extracted `.txt` files** — understand scope, structure, depth. Work exclusively from the converted text, never from the raw PDF.
4. **Source Content Mapping (MANDATORY for multi-file sources)**:
   - Read **cover page + TOC + 3+ sample pages from middle/end** for EVERY source file
   - **NEVER assume content from filename** — file numbering often ≠ chapter numbering
   - Build verified mapping: `{ source_file → actual_topics → page_ranges }`
   - Flag non-academic files and missing sources
   - Present mapping to user for verification before proceeding

### Phase D2: Content Analysis

1. Identify topic hierarchy — sections, chapters, domain divisions.
2. Separate concept content vs practice questions.
3. Map dependencies between topics.
4. Identify key patterns — comparisons, decision trees, formulas.
5. **Full topic checklist (MANDATORY)** — every topic/subtopic listed. Drives all subsequent phases.

> **Equal Depth Rule**: Even a briefly mentioned subtopic MUST get a full dedicated note supplemented with textbook-level knowledge.

6. **Classification completeness**: When source enumerates categories ("3 types of X"), every member gets a dedicated note. Scan for: "types of", "N가지", "categories", "there are N".
7. **Source-to-note cross-verification (MANDATORY)**: Record which source file(s) and page range(s) cover each topic. Flag untraceable topics as "source not available".

### Phase D3: Tag Standard

Define tag vocabulary before creating notes:
- **Format**: English, lowercase, kebab-case (e.g., `#data-hazard`)
- **Hierarchy**: top-level → domain → detail → technique → note-type
- **Registry**: Only registered tags allowed. Detail tags co-attach parent domain tag.

### Phase D4: Vault Structure

Create `StudyVault/` with numbered folders per [templates.md](references/templates.md). Group 3-5 related concepts per file.

### Phase D5: Dashboard Creation

Create `00-Dashboard/`: MOC, Quick Reference, Exam Traps. See [templates.md](references/templates.md).

- **MOC**: Topic Map + Practice Notes + Study Tools + Tag Index (with rules) + Weak Areas (with links) + Non-core Topic Policy
- **Quick Reference**: every heading includes `→ [[Concept Note]]` link; all key formulas
- **Exam Traps**: per-topic trap points in fold callouts, linked to concept notes

### Phase D6: Concept Notes

Per [templates.md](references/templates.md). Key rules:
- YAML frontmatter: `source_pdf`, `part`, `keywords` (MANDATORY)
- **source_pdf MUST match verified Phase D1 mapping** — never guess from filename
- If unavailable: `source_pdf: 원문 미보유`
- `[[wiki-links]]`, callouts (`[!tip]`, `[!important]`, `[!warning]`), comparison tables > prose
- ASCII diagrams for processes/flows/sequences
- **Simplification-with-exceptions**: general statements must note edge cases

### Phase D7: Practice Questions

Per [templates.md](references/templates.md). Key rules:
- Every topic folder MUST have a practice file (8+ questions)
- **Active recall**: answers use `> [!answer]- 정답 보기` fold callout
- Patterns use `> [!hint]-` / `> [!summary]-` fold callouts
- **Question type diversity**: ≥60% recall, ≥20% application, ≥2 analysis per file
- `## Related Concepts` with `[[wiki-links]]`

### Phase D8: Interlinking

1. `## Related Notes` on every concept note
2. MOC links to every concept + practice note
3. Cross-link concept ↔ practice; siblings reference each other
4. Quick Reference sections → `[[Concept Note]]` links
5. Weak Areas → relevant note + Exam Traps; Exam Traps → concept notes

### Phase D9: Self-Review (MANDATORY)

Verify against [quality-checklist.md](references/quality-checklist.md) **Document Mode** section. Fix and re-verify until all checks pass.

---

## Codebase Mode

> Generates a new-developer onboarding StudyVault from a source code project.
> Full workflow: [codebase-workflow.md](references/codebase-workflow.md)
> Templates: [codebase-templates.md](references/codebase-templates.md)

### Phase Summary

| Phase | Name | Key Action |
|-------|------|------------|
| C1 | Project Exploration | Scan files, detect tech stack, read entry points, map directory layout |
| C2 | Architecture Analysis | Identify patterns, trace request flow, map module boundaries and data flow |
| C3 | Tag Standard | Define `#arch-*`, `#module-*`, `#pattern-*`, `#api-*` tag registry |
| C4 | Vault Structure | Create `StudyVault/` with Dashboard, Architecture, per-module, DevOps, Exercises folders |
| C5 | Dashboard | MOC (Module Map + API Surface + Getting Started + Onboarding Path) + Quick Reference |
| C6 | Module Notes | Per-module notes: Purpose, Key Files, Public Interface, Internal Flow, Dependencies |
| C7 | Onboarding Exercises | Code reading, configuration, debugging, extension exercises (5+ per major module) |
| C8 | Interlinking | Cross-link modules, architecture ↔ implementations, exercises ↔ modules |
| C9 | Self-Review | Verify against [quality-checklist.md](references/quality-checklist.md) **Codebase Mode** section |

See [codebase-workflow.md](references/codebase-workflow.md) for detailed per-phase instructions.

---

## Language

- Match source material language (Korean → Korean notes, etc.)
- **Curriculum Mode**: Match user's language; default to Korean for Korean curriculum
- **Tags/keywords**: ALWAYS English
