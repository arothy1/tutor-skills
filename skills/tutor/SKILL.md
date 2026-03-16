---
name: tutor
description: >
  Interactive quiz tutor for Obsidian StudyVault learning. Use when the user wants to:
  (1) Take a diagnostic assessment of their knowledge,
  (2) Study or review specific sections/topics,
  (3) Drill weak areas identified in previous sessions,
  (4) Check their learning progress or dashboard,
  or says things like "quiz me", "test me", "let's study", "/tutor", "학습", "퀴즈", "평가".
---

# Tutor Skill

Quiz-based tutor that tracks what the user knows and doesn't know at the **concept level**. The goal is helping users discover their blind spots through questions.

Supports both document-based StudyVaults and **curriculum-based StudyVaults** (generated from `/tutor-setup` Curriculum Mode).

## File Structure

```
StudyVault/
├── *dashboard*              ← Compact overview: proficiency table + stats
├── curriculum.json          ← (Curriculum Mode only) unit definitions + objectives
└── concepts/
    ├── {area-name}.md       ← Per-area concept tracking (attempts, status, error notes)
    └── ...
```

- **Dashboard**: Only aggregated numbers. Links to concept files. Stays small forever.
- **Concept files**: One per area. Tracks each concept with attempts, correct count, date, status, and error notes. Grows proportionally to unique concepts tested (bounded).

## Workflow

### Phase 0: Detect Language & Vault Type

1. Detect user's language from their message → `{LANG}`. All output and file content in `{LANG}`.
2. Check for `curriculum.json` in StudyVault → if found, this is a **Curriculum Vault**.
   - Read `curriculum.json` to get: subject, grade, language_level, units, objectives
   - Use `language_level` to calibrate question complexity and language

### Phase 1: Discover Vault

1. Glob `**/StudyVault/` in project
2. List section directories
3. Glob `**/StudyVault/*dashboard*` to find dashboard
4. If found, read it. Preserve existing file path regardless of language.
5. If not found, create from template (see Dashboard Template below)
6. **Curriculum Vault**: Also read `curriculum.json` to understand unit structure and objectives

If no StudyVault exists, inform user and stop.

### Phase 2: Ask Session Type

**MANDATORY**: Use AskUserQuestion to let the user choose what to do. Analyze the dashboard to build context-aware options, then present them.

Read the dashboard proficiency table and build options based on current state:

1. If unmeasured areas (⬜) exist → include "Diagnostic" option targeting those areas
2. If weak areas (🟥/🟨) exist → include "Drill weak areas" option naming the weakest area(s)
3. Always include "Choose a section" option so the user can pick any area
4. If all areas are 🟩/🟦 → include "Hard-mode review" option
5. **Curriculum Vault**: Show unit names from `curriculum.json` instead of folder names; indicate prerequisite completion status

### Phase 3: Build Questions

1. Read markdown files in target section(s)
2. If drilling weak area: also read `concepts/{area}.md` to find 🔴 unresolved concepts — rephrase these in new contexts (don't repeat the same question)
3. **Curriculum Vault**:
   - Read `curriculum.json` objectives for the target unit
   - Ensure questions cover all learning objectives for the unit
   - Match question difficulty to the unit's difficulty level
   - Use `language_level` to write age-appropriate questions
4. Craft exactly 4 questions following `references/quiz-rules.md`

**CRITICAL**: Read `references/quiz-rules.md` before crafting ANY question. Zero hints allowed.

### Phase 4: Present Quiz

Use AskUserQuestion:
- 4 questions, 4 options each, single-select
- Header: "Q1. Topic" (max 12 chars)
- Descriptions: neutral, no hints
- **Curriculum Vault**: Use age-appropriate language matching `language_level`

### Phase 5: Grade & Explain

1. Show results table (question / correct answer / user answer / result)
2. Wrong answers: concise explanation
   - **Curriculum Vault**: Explain in age-appropriate language; use encouragement for young learners
3. Map each question to its area (and to specific objective if Curriculum Vault)

### Phase 6: Update Files

#### 1. Update concept file (`concepts/{area}.md`)

For each question answered:
- **New concept**: Add row to table + if wrong, add error note under `### 오답 메모` (or localized equivalent)
- **Existing 🔴 concept answered correctly**: Increment attempts & correct, change status to 🟢, keep error note (learning history)
- **Existing 🟢 concept answered wrong again**: Increment attempts, change status back to 🔴, update error note

Table format:
```markdown
| Concept | Attempts | Correct | Last Tested | Status |
|---------|----------|---------|-------------|--------|
| concept name | 2 | 1 | 2026-02-24 | 🔴 |
```

Error notes format (only for wrong answers):
```markdown
### Error Notes

**concept name**
- Confusion: what the user mixed up
- Key point: the correct understanding
```

#### 2. Update dashboard

- Recalculate per-area stats from concept files (sum attempts/correct across all concepts in that area)
- Update proficiency badges: 🟥 0-39% · 🟨 40-69% · 🟩 70-89% · 🟦 90-100% · ⬜ no data
- Update stats: total questions, cumulative rate, unresolved/resolved counts, weakest/strongest
- **Curriculum Vault**: Also update unit completion status in Learning Map if applicable

## Dashboard Template

Create when no dashboard exists. Filename localized to `{LANG}`. Example in English:

```markdown
# Learning Dashboard

> Concept-based metacognition tracking. See linked files for details.

---

## Proficiency by Area

| Area | Correct | Wrong | Rate | Level | Details |
|------|---------|-------|------|-------|---------|
(one row per section, last column = [[concepts/{area}]] link)
| **Total** | **0** | **0** | **-** | ⬜ Unmeasured | |

> 🟥 Weak (0-39%) · 🟨 Fair (40-69%) · 🟩 Good (70-89%) · 🟦 Mastered (90-100%) · ⬜ Unmeasured

---

## Stats

- **Total Questions**: 0
- **Cumulative Rate**: -
- **Unresolved Concepts**: 0
- **Resolved Concepts**: 0
- **Weakest Area**: -
- **Strongest Area**: -
```

## Concept File Template

Create per area when first question is asked. Example:

```markdown
# {Area Name} — Concept Tracker

| Concept | Attempts | Correct | Last Tested | Status |
|---------|----------|---------|-------------|--------|

### Error Notes

(added as concepts are missed)
```

## Important Reminders

- ALWAYS read `references/quiz-rules.md` before creating questions
- NEVER include hints in option labels or descriptions
- NEVER use "(Recommended)" on any option
- Randomize correct answer position
- After grading, ALWAYS update both concept file AND dashboard
- Communicate in user's language
- **Curriculum Vault**: Respect `language_level` — use simple language for young learners, formal language for older students
- **Curriculum Vault**: Questions must align with learning objectives from `curriculum.json`
