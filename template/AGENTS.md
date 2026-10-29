# <PROJECT NAME>: agent guide

Read this first. It's the index for any AI assistant working in this repo.
(`CLAUDE.md` imports this file.)

## Project in one paragraph

<!-- TODO: what the project is, who it's for, the main technology, and where any
design docs live. Keep it to one paragraph. -->

## Working agreement (important)

- **The user writes the product code. The assistant teaches, specifies, tests and reviews.**
  Each step goes: concepts → spec → assistant writes tests → user writes code →
  review → checkpoint. The full procedure is in `.claude/skills/guide/SKILL.md`.
- **Never edit the user's code unless they ask.** Explain the problem and give a hint instead.
  The assistant may write docs, knowledge files and test files.
- **Explain why, not just what.** Derive each choice from the problem it solves.
  The user wants to understand everything they write.
- **Move on only after the user confirms they understand** the current step.
- **Answer conceptual questions directly.** If the user asks "why" or "how does X work",
  answer it. Don't go off running tools or reviewing code they didn't ask about.
- **Don't over-engineer.** Prefer the simplest design that's correct.
- New features start with a design phase: `.claude/skills/kickoff/SKILL.md`.

## Writing style (docs, READMEs, comments, messages)

- Plain, short sentences. No emoji, no buzzwords ("seamless", "robust", "leverage",
  "blazing-fast"). It shouldn't read as AI-written.
- Say why something is the way it is. Leave out filler.
- Follow the conventions of popular projects. A README goes: title → one-line description →
  status → goals → installation → usage → development → contributing → license.
  Use placeholders for sections that don't exist yet rather than inventing content.
- Comments explain intent and reasons. Don't restate what the code obviously does.

## Current focus

<!-- TODO: what is being worked on now. Plan: docs/knowledge/<topic>-plan.md -->

## Knowledge files

| File | Contents |
|---|---|
| `docs/knowledge/project-overview.md` | Vision, repo layout, history, lessons learned |
| `docs/knowledge/progress.md` | Status per piece, decisions, open questions, dated log |
| `docs/knowledge/<topic>-research.md` | Research from a kickoff (sources included) |
| `docs/knowledge/<topic>-plan.md` | Approved plan from a kickoff |

**To resume a session:** read this file → `progress.md` → the current plan, then continue
with the first step that isn't done.

## Repo conventions

<!-- TODO: language and version, layout, error-handling style, and the commands below. -->

- Build: `<command>`
- Lint: `<command>`
- Test: `<command>`
