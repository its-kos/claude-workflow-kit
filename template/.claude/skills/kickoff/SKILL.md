---
name: kickoff
description: Design phase for a new project, feature or component, before any code is written. Reads the design docs and repo, researches how comparable tools solve it, interviews the user, records decisions and writes a step-by-step plan. Use when the user wants to start designing or architecting something new, or says decisions are still open. Not for small changes or bug fixes.
argument-hint: <topic>
---

# Kickoff: design before code

Topic: $ARGUMENTS (if empty, ask the user what we're designing).

The goal is a plan the user understands and agrees with, built on facts rather than
assumptions. Nothing gets implemented in this phase. Use plan mode if it's available.

## 1. Understand what exists

- Read every design document the user points to, in full.
- Read the whole repo: layout, each package, tests, build files.
- Read the git history (`git log`, and `git show` on big or "reset" commits). Deleted code
  often explains why things are the way they are.
- Summarise your understanding back to the user:
  - What the project is for.
  - What's decided and what's still open.
  - How the current code relates to the design.
  - The important problems you noticed (bugs, risks, gaps in the design). Flag them clearly.

Write or update `docs/knowledge/project-overview.md` with this.

## 2. Research how others do it

Start up to two research agents in parallel, in the background:
- **Deep dive** into the reference implementation, if there is one. Ask for concrete,
  sourced facts with file paths and URLs: what it does step by step, defaults, edge cases,
  known pain points from its issue tracker.
- **Survey** of 5–10 comparable tools: how each solves the same problem, then a summary
  of best practices and trade-offs.

Ask both to keep **facts separate from inferences** and to list their sources. While they
run, start the interview (step 3). Save the condensed findings, with sources, to
`docs/knowledge/<topic>-research.md`. That's how a future session can recheck them.

## 3. Interview the user

Ask in rounds of at most 4 questions (use the question tool if available).
- Every option states its **trade-off**. Put the recommended option first and mark it.
- **Explain unfamiliar concepts before asking about them.** If the user says "I don't know
  what X is", explain it (with what popular tools do) and ask again.
- Read answers carefully. Users often answer with a question, a correction, or "do what
  you think is best". Follow what they actually say.
- **Don't ask about things with an obvious conventional default.** Decide them yourself,
  and list them in the plan as your decisions so the user can object.
- Ask about requirements, threat model / constraints, scope (what's explicitly *out*),
  platforms, and anything where the research shows real alternatives.
- When an answer reveals a misunderstanding on either side, stop and clear it up first.

## 4. Decide and plan

Build a **decisions table**: `D1 … Dn`, each with the decision, rationale, and source
(user's choice or research finding). Then write the plan using `plan-template.md` (in this
skill's folder):
- Context (why, what prompted it, intended outcome).
- Decisions table.
- Layout / data formats / algorithm, in enough detail to build from.
- **Pieces, ordered bottom-up**, so each one depends only on earlier ones and can be tested
  alone. The guide skill builds them one at a time.
- An explicit **deferred** list (what we're not doing now).
- Verification: how we'll know it works.

Keep it short enough to scan. Save it to `docs/knowledge/<topic>-plan.md` and add the
pieces to `docs/knowledge/progress.md`.

## 5. Hand over

- Ask the user to approve the plan (plan mode's exit, if available).
- Then building starts with the guide skill (`.claude/skills/guide/SKILL.md`).
- When the whole feature is done, record the decisions as an ADR
  (`docs/decisions/NNNN-<topic>.md`: context, alternatives, choice, reasons, consequences,
  when to revisit).

## Pitfalls

- Don't start implementing during kickoff, even "just the easy part".
- Don't adopt a reference implementation's whole architecture because it exists. Each
  borrowed idea needs a reason that applies to this project.
- Don't make the design bigger than the problem. The user prefers the simplest design that's correct.
