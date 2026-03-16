# Curriculum Mode Templates Reference

## Vault Folder Structure

```
StudyVault/
  00-Dashboard/
    Learning-Map.md            # MOC: unit map + study path + progress
    Quick-Reference.md         # Key formulas/rules per unit
  01-<Unit-Name>/
    concept.md                 # Age-appropriate concept explanation
    examples.md                # Worked examples with step-by-step
    practice.md                # Practice questions (8+)
  02-<Unit-Name>/
    ...
  curriculum.json              # Machine-readable curriculum definition
```

## curriculum.json Schema

```json
{
  "subject": "수학",
  "grade": "초등 3학년",
  "target_age": 9,
  "language_level": "쉬운 말, 예시 많이, 단계별 설명",
  "units": [
    {
      "id": "unit-01",
      "name": "세 자리 수의 덧셈과 뺄셈",
      "folder": "01-덧셈과-뺄셈",
      "objectives": [
        "세 자리 수의 덧셈을 할 수 있다",
        "받아올림이 있는 덧셈을 이해한다"
      ],
      "prerequisites": [],
      "difficulty": 1,
      "key_terms": ["덧셈", "뺄셈", "받아올림", "받아내림"]
    }
  ],
  "tag_registry": ["#math", "#addition", "#subtraction", "#carry-over"]
}
```

## Learning Map (Dashboard MOC) Template

```markdown
---
subject: <subject>
grade: <grade>
keywords: MOC, learning-map, <subject>
---

# <Grade> <Subject> Learning Map

#dashboard #<subject-tag>

## Overview
- **대상**: <grade> 학생
- **과목**: <subject>
- **총 단원**: <N>개
- **학습 순서**: 아래 번호 순서대로 진행하세요

## Study Path (학습 순서)

| 순서 | 단원 | 학습목표 | 선수단원 | 난이도 | 상태 |
|------|------|---------|---------|--------|------|
| 1 | [[01-Unit/concept]] | 목표 요약 | - | Easy | [ ] |
| 2 | [[02-Unit/concept]] | 목표 요약 | 단원1 | Easy | [ ] |

## Unit Details

### 단원 1: <Unit Name>
- **학습목표**:
  - 목표 1
  - 목표 2
- **핵심 개념**: [[01-Unit/concept]]
- **풀이 예시**: [[01-Unit/examples]]
- **연습 문제**: [[01-Unit/practice]]

## Quick Links
| 도구 | 설명 | 링크 |
|------|------|------|
| Quick Reference | 공식/규칙 모음 | [[Quick-Reference]] |

## Tag Index
| Tag | 관련 주제 |
|-----|-----------|
| `#tag-name` | description |

> **태그 규칙**: English, lowercase, kebab-case only

## Progress Summary
- **완료 단원**: 0 / <N>
- **현재 학습**: -
- **다음 단원**: 단원 1
```

## Quick Reference Template

```markdown
---
subject: <subject>
grade: <grade>
keywords: quick-reference, cheat-sheet, <subject>
---

# <Grade> <Subject> Quick Reference

#dashboard #quick-reference

## <Unit 1 Name> → [[01-Unit/concept]]

| 핵심 규칙 | 설명 |
|-----------|------|
| rule 1 | explanation |

## <Unit 2 Name> → [[02-Unit/concept]]

| 핵심 규칙 | 설명 |
|-----------|------|
| rule 1 | explanation |

---

## Must-Know (꼭 알아야 할 것)
| 항목 | 내용 | 자세히 보기 |
|------|------|------------|
| item | summary | → [[Note]] |
```

## Concept Note Template

```markdown
---
unit: <unit-id>
grade: <grade>
subject: <subject>
keywords: <3-5 English keywords>
---

# <Unit Title>

#<tag-from-registry>

## What are we learning? (무엇을 배울까요?)

> 한 줄로 이 단원에서 배울 내용을 소개합니다.

## Key Points (핵심 정리)

| 핵심 | 설명 |
|------|------|
| A | ... |
| B | ... |

## Let's Learn Step by Step (차근차근 배워봐요)

### 1. <First Concept>

<Age-appropriate explanation, 3-5 lines max>

- Key point 1
- Key point 2

> [!tip] 쉽게 기억하기
> <memory aid or mnemonic>

### 2. <Second Concept>

...

## Visual Guide (그림으로 이해하기)

<ASCII diagram, number line, table, or visual representation>

```
  234
+ 152
-----
  386    ← 일의 자리부터 차례대로!
```

## Common Mistakes (자주 하는 실수)

> [!warning] 조심!
> - 실수 1: 설명
> - 실수 2: 설명

## Summary (정리)

1. 핵심 포인트 1
2. 핵심 포인트 2
3. 핵심 포인트 3

## Related Notes
- [[Previous Unit]] ← 선수 학습
- [[Next Unit]] → 다음 학습
- [[examples]] — 풀이 예시
- [[practice]] — 연습 문제
```

## Worked Examples Template

```markdown
---
unit: <unit-id>
grade: <grade>
subject: <subject>
keywords: examples, worked-solutions, <topic keywords>
---

# <Unit Title> — Worked Examples (풀이 예시)

#examples #<topic-tag>

## Related Concepts
- [[concept]] — 개념 설명

---

## Example 1 — <Label> [Easy]

**문제**: <problem statement>

**풀이 과정**:

> Step 1: <explanation>
> Step 2: <explanation>
> Step 3: <explanation>

**정답**: <answer>

> [!tip] 포인트
> <key insight from this example>

---

## Example 2 — <Label> [Easy]

...

---

## Example 3 — <Label> [Medium]

...

---

## Try It Yourself! (직접 풀어보세요)

아래 문제를 위의 풀이 과정처럼 풀어보세요:

1. <problem>
2. <problem>

> [!answer]- 정답 보기
> 1. <answer with brief steps>
> 2. <answer with brief steps>

---

## Example 4 — <Label> [Medium]

...

---

## Example 5 — <Label> [Hard]

...

---

## Related Notes
- [[concept]] — 개념 다시 보기
- [[practice]] — 연습 문제 풀기
```

## Practice Questions Template

```markdown
---
unit: <unit-id>
grade: <grade>
subject: <subject>
keywords: practice, <topic keywords>
---

# <Unit Title> — Practice (N questions)

#practice #<topic-tag>

## Related Concepts
- [[concept]]
- [[examples]]

> [!hint]- 핵심 패턴 (클릭하여 보기)
> | 패턴 | 정답/풀이법 |
> |------|------------|
> | pattern 1 | **Solution** |
> | pattern 2 | **Solution** |

---

## Q1. <Short Label> [recall] [Easy]
> <Problem statement — clear and simple>

> [!answer]- 정답 보기
> **정답**: <answer>
> <1-2 line explanation>

---

## Q2. <Short Label> [recall] [Easy]
> <Problem statement>

> [!answer]- 정답 보기
> **정답**: <answer>
> <explanation>

---

## Q3. <Short Label> [recall] [Medium]
> <Problem statement>

> [!answer]- 정답 보기
> **정답**: <answer>
> <explanation>

---

## Q4. <Short Label> [application] [Medium]
> <Word problem / real-world scenario>

> [!hint]- 힌트가 필요하면 클릭
> <hint without giving away the answer>

> [!answer]- 정답 보기
> **정답**: <answer>
> **풀이**: <step-by-step solution>

---

## Q5. <Short Label> [application] [Medium]
> <Word problem>

> [!answer]- 정답 보기
> **정답**: <answer>
> **풀이**: <solution>

---

## Q6. <Short Label> [application] [Medium]
> <Word problem>

> [!answer]- 정답 보기
> **정답**: <answer>
> **풀이**: <solution>

---

## Q7. <Short Label> [analysis] [Hard]
> <Why/how question or error analysis>

> [!answer]- 정답 보기
> <explanation with reasoning>

---

## Q8. <Short Label> [challenge] [Hard]
> <Challenging problem for advanced learners>

> [!hint]- 힌트가 필요하면 클릭
> <hint>

> [!answer]- 정답 보기
> **정답**: <answer>
> **풀이**: <detailed solution>

---

> [!summary]- 패턴 요약 (클릭하여 보기)
> | 유형 | 핵심 포인트 |
> |------|------------|
> | recall | ... |
> | application | ... |
> | analysis | ... |
```

## Language Level Guidelines

### Age-Appropriate Writing

| Grade | Age | Language Style | Example |
|-------|-----|---------------|---------|
| 초등 1-2 | 7-8 | 아주 쉬운 말, 짧은 문장 | "2 더하기 3은 5예요!" |
| 초등 3-4 | 9-10 | 쉬운 말, 예시 많이 | "234 + 152를 풀어볼까요? 일의 자리부터 해봐요." |
| 초등 5-6 | 11-12 | 또래 수준 용어 | "분수의 덧셈에서 통분이 필요한 이유를 알아보자." |
| 중등 1-3 | 13-15 | 교과서 수준 용어 | "일차방정식의 해를 구하는 과정을 살펴보겠습니다." |
| 고등 1-3 | 16-18 | 정식 학술 용어 | "미분의 정의와 극한의 관계를 분석한다." |

### Writing Rules for Children

1. **Short sentences**: Max 20 words per sentence for 초등 1-4
2. **Concrete before abstract**: Always show examples before rules
3. **Encouragement**: Use positive framing ("잘했어요!", "거의 다 왔어요!")
4. **Visual aids**: Every concept should have at least one visual (ASCII art, table, number line)
5. **Step numbering**: Always number steps explicitly (1, 2, 3...)
6. **Real-world connections**: Use scenarios kids relate to (candy, toys, friends, animals)
