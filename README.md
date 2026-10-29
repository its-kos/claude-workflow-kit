# claude-workflow-kit

A way of working with Claude Code where you write the code and Claude teaches,
plans, writes the tests and reviews. Copy it into any repo.

## What's in it

```
template/
├── AGENTS.md                        working agreement, writing style, repo placeholders
├── CLAUDE.md                        imports AGENTS.md so Claude Code loads it
├── docs/knowledge/
│   ├── project-overview.md          vision, repo state, history, lessons
│   └── progress.md                  status of each step and a dated log
└── .claude/skills/
    ├── kickoff/                     /kickoff <topic>: design phase
    │   ├── SKILL.md
    │   └── plan-template.md
    └── guide/                       /guide: build phase
        ├── SKILL.md
        ├── teaching.md              how explanations should work
        └── review.md                how code reviews should work
```

**Kickoff** is for starting something new. Claude reads the design docs, the repo and its
history, researches how comparable tools solve the problem, interviews you, and writes a
decisions table and a step-by-step plan to `docs/knowledge/`.

**Guide** builds that plan one small step at a time. For each step, Claude explains the
concepts, checks library behaviour with small experiments, gives you a spec, and writes the
tests. You write the code, Claude reviews it and explains its findings, and you move on when
you understand it.

**The knowledge base** (`AGENTS.md` and `docs/knowledge/`) holds the plan, decisions and
progress, so a new session, or another AI tool, can pick up where the last one stopped.

Both skills can be started by typing `/kickoff` or `/guide`, or by Claude when a request
matches.

## Install

```sh
./install.sh path/to/repo
```

- Existing files are never overwritten; they're listed as skipped.
- The kit's files are added to the repo's `.gitignore` so they stay local. Use
  `./install.sh --commit path/to/repo` to track them in git instead.

Then fill in the `TODO` placeholders in the repo's `AGENTS.md` (project summary, build and
test commands) and start with `/kickoff <topic>`.

## Customising

Edit the files under `template/` to change the workflow for all future repos. Changes to a
repo's own copy only affect that repo. Copies don't update automatically, so re-run
`install.sh` after deleting the files you want refreshed.
