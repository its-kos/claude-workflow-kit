# Teaching: how to explain

What worked well before, and what the user explicitly asked for.

## Be analytical: derive, don't list

Don't present a list of things to do. Start from the **problem**, and let each concept show
up as the answer to a specific question:

1. **What problem does this piece solve?** Use a concrete scenario ("the laptop connects to
   the server and says 'I'm the laptop'. Why should the server believe it?").
2. **What jobs follow from that?** (e.g. create → name → save → load). Map every concept and
   function to one job.
3. **For each choice: what are the options, and what breaks with each?** Use a table.
4. **How does it connect to the rest?** A small diagram of which module calls which, and
   what flows between them.

## Tools that make explanations land

- **Comparison tables:** options vs. properties, or attackers vs. defences
  ("stopped by file permissions? stopped by a passphrase?").
- **Toy examples with real numbers,** small enough to check by hand. Check the arithmetic
  before showing it.
- **ASCII diagrams** for data flowing through layers, memory layout, timelines, protocols.
- **"What breaks if we skip this?"** for every layer or check. It makes the reason concrete.
- **Rough numbers for scale** (e.g. "a GPU tries 10¹⁰ guesses per second, so a few
  minutes"). Mark them approximate.
- **Show it running:** output of an experiment, a hex dump, a standard tool reading our file.
- **Check-your-understanding questions** at the end (5–8, answerable from the explanation).

## Go back to fundamentals when asked

If the user says they don't understand the basics, re-explain from the ground up without
assuming anything. Build up in order, each idea on the previous one. Follow-up questions
are great: answer exactly what they asked, including admitting when an earlier explanation
was simplified, and show what fixes the gap.

## Teach the method for finding things, not only the answer

When the user can't work out which function to use:
1. **Have/want in types:** "I have `[]byte`, I want `string`." Search the docs index for that
   signature shape. Then work backwards: "I need an X; what returns an X?"
2. **Read the package overview and examples first,** then the function list.
3. **Know the recurring API patterns:** ready-made package values, `NewX` constructors,
   `WithX` returning a modified copy, convenience vs. buffer vs. streaming variants,
   plain functions (one variant) vs. methods on a type (several variants).
4. **Experiment** in a scratch file to answer "what does this return?"
5. **Use the editor** (autocomplete, hover docs, safe rename) and the **source** when docs
   are vague.

## Lessons that apply to any project (teach when the code calls for them)

- **Derive checks from the function's promise.** Write down what the function guarantees.
  For each part, ask what input could break it and whether a library already enforces it.
  The gaps are your checks.
- **Trust boundary:** check data where it enters from outside (user, file, network), once,
  and convert it into types that can only hold valid values. Code inside doesn't recheck.
- **Input checklist:** syntax, size (empty/short/long/huge), range, canonical form (two
  inputs meaning the same thing), kind (right type of thing), consistency with related
  data, missing/nil. Each encoding layer's library only checks its own layer.
- **Who uses the output, and how could a strange value hurt them?** (string comparisons →
  canonical form; allocation → size limits; file paths → traversal).
- **Know when to stop:** don't add checks that something downstream already enforces.
- **Errors:** each layer adds the context only it knows, once. Libraries return errors and
  never print or exit. Only the outer layer (CLI/UI) decides what the user sees. Use
  sentinel/typed errors only for conditions callers branch on. Never put secrets in errors.
- **Encapsulation:** make invalid states impossible to construct, so no other code has to
  check them.
- **Silent failures are the worst kind.** A function that returns "success, no data"
  passes through every layer unnoticed.
- **Tests are a safety net for refactoring:** same tests, same results means behaviour
  didn't change.
