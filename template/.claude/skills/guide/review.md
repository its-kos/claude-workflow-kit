# Reviewing the user's code

## Run things first

1. Look at what changed: `git status`, `git diff`, and the files themselves.
2. Run the formatter check, build, linter and tests (commands are in `AGENTS.md`).
3. **If unfinished code stops the build** (e.g. declared but not implemented functions),
   copy the module to a temp directory, remove only the unfinished parts there, and run the
   tests on the copy. Never change the user's files to make things run. Tell them what
   blocked the build and how to fix it.

## Explain the results

- If tests fail, show **how to read the output**: which test, which case, got vs. want,
  and which check failed. That narrows the bug down to one place.
  Give a hint about the cause, not the fix.
- Point out what they got right and why it's right. That's part of the learning.

## Report findings

Group them, most important first:

| Group | Meaning |
|---|---|
| **Worth changing** | Real bugs, or things that will fail later (often silently) |
| **Consider** | Improvements with a real benefit, the user's call |
| **Leave alone** | Things that look odd but are fine, and why (this prevents churn) |

For each finding:
- **What:** the line or behaviour.
- **Why it matters:** a concrete failure scenario ("then X writes an empty file and
  reports success").
- **Hint:** the direction of the fix, not the code.

The user decides what to do. Record accepted and declined findings in `progress.md`.

## What to look for

- **Correctness against the spec:** every behaviour and every error case.
- **Error handling:** errors not ignored, wrapped once with useful context, consistent
  message style.
- **Secrets:** never logged, printed, or put in error messages (keys, passwords, tokens,
  decrypted data).
- **Input handling at trust boundaries:** see the checklist in `teaching.md`.
- **Silent failures:** functions that can return "no error" with no or bad data.
- **Resource and safety issues:** file permissions, unbounded sizes, aliasing (returning
  internal buffers callers can modify), concurrency.
- **Readability:** names that say what a value is, doc comments on public items that say
  why, constants for strings and numbers shared between functions.
- **Language traps:** e.g. variable shadowing, pointer vs. value, nil vs. empty,
  integer overflow. Check the ones relevant to the project's language.
- **Tests cover every error case** in the spec, not just the happy path. If the user changed
  tests, make sure they didn't weaken them.
- **Over-engineering:** extra abstraction or features the plan didn't ask for.

## Also check outside the code

When it's relevant, mention repo housekeeping you notice (ignore rules matching the wrong
paths, empty or missing license, inconsistent git author settings). Keep it short, and fix
only what the user agrees to.
