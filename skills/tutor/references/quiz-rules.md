# Quiz Design Rules

## Zero-Hint Policy (CRITICAL)

Every question must be answerable ONLY by someone who actually knows the material.

1. **Option descriptions**: NEVER reveal correctness
   - BAD: `label: "stderr"`, `description: "Error output stream used by Cloud Run for error classification"`
   - GOOD: `label: "stderr"`, `description: "Standard error stream"`

2. **No "(Recommended)" tag** on any option

3. **Randomize** correct answer position — never always first or last

4. **Question phrasing**: Ask about behavior/purpose/output, don't hint at the answer
   - BAD: "Which error stream does error() use?"
   - GOOD: "Where does error() method output go?"

5. **Plausible distractors**: Wrong options must be real concepts from the domain, representing common misconceptions

## Question Types

1. **Factual recall**: "What HTTP status code is returned when...?"
2. **Conceptual understanding**: "Why does the system use X pattern?"
3. **Behavioral prediction**: "What happens when X fails?"
4. **Comparison/distinction**: "What is the difference between X and Y?"
5. **Debugging scenario**: "Given this error, what is the most likely cause?"

## Curriculum Vault Question Types

When targeting a Curriculum Vault (has `curriculum.json`), adapt question types to the subject and age:

### Math (수학)
1. **Computation recall**: "352 + 214 = ?"
2. **Word problem (application)**: "민수는 사탕 245개, 영희는 132개를 가지고 있어요. 합하면 몇 개일까요?"
3. **Error analysis**: "철수가 234 + 178 = 302 라고 했어요. 어디가 틀렸을까요?"
4. **Pattern recognition**: "다음 수 배열에서 빈칸에 알맞은 수는? 2, 4, __, 8"

### English / Phonics (영어/파닉스)
1. **Sound matching**: "Which word has the same vowel sound as 'cake'?"
2. **Spelling**: "Which is the correct spelling?"
3. **Vocabulary**: "What does this word mean?"
4. **Sentence completion**: "Choose the correct word: She ___ to school every day."

### Science (과학)
1. **Fact recall**: "식물이 자라는 데 필요한 것은?"
2. **Cause/effect**: "물을 끓이면 어떻게 될까요?"
3. **Classification**: "다음 중 포유류가 아닌 것은?"
4. **Observation**: "이 실험에서 알 수 있는 것은?"

### General Rules for Curriculum Vault
- **Match language_level**: Use age-appropriate vocabulary and sentence structure
- **Objective alignment**: Every question must map to a specific learning objective
- **Difficulty markers**: Tag each question [Easy], [Medium], or [Hard]
- **Encouragement after wrong answers**: Use positive framing for young learners
  - "아깝다! 거의 맞았어요" instead of "틀렸습니다"
  - "다시 한번 생각해볼까요?" for explanations

## Difficulty Balancing

- Diagnostic: easy 40%, medium 40%, hard 20%
- Weak-area drill: medium 30%, hard 70%
- Review: all levels evenly
- **Curriculum Vault diagnostic**: easy 50%, medium 40%, hard 10% (gentler for younger learners)
- **Curriculum Vault drill**: easy 20%, medium 50%, hard 30%

## Drilling Unresolved Concepts

When targeting 🔴 concepts from concept files:
- Do NOT repeat the exact same question — rephrase in a new context
- Test the same underlying knowledge from a different angle
- E.g., if user confused "400 vs 422", ask a scenario question where they must choose the correct status code for a new situation
- **Curriculum Vault**: Rephrase with different numbers, names, or scenarios while testing the same objective

## AskUserQuestion Format

- 4 questions per round, 4 options each, single-select
- Header: max 12 chars, "Q1. Topic"

## File Update Protocol

After grading:
1. Update `concepts/{area}.md` — add/update concept rows + error notes
2. Update dashboard — recalculate area stats from concept files
3. Badges: 🟥 0-39% · 🟨 40-69% · 🟩 70-89% · 🟦 90-100% · ⬜ no data

## Language Rule

All file content and output in the user's detected language. Badge emojis are universal.
**Curriculum Vault**: Always respect `language_level` from `curriculum.json`.
