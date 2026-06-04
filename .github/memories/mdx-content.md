# MDX content authoring rules

**Scope:** `src/content/docs/**/*.mdx`

This repository's documentation pages follow a **strict template** for control pages so that the Engagement Agent and the auto-generated GitHub Issues stay synchronised. Follow these rules whenever editing or creating MDX files.

## ⚠️ MDX syntax gotchas

MDX 3 (Astro 6 / Starlight 0.39) parses `<` followed by a letter, digit, or space as the start of a JSX tag. This breaks the build with `Unexpected character '...' before name`.

**Always escape these patterns:**

| ❌ Wrong | ✅ Right |
|---|---|
| `target <2 business days` | `target &lt; 2 business days` |
| `latency <100ms` | `latency &lt; 100ms` |
| `<6 months coverage` | `&lt; 6 months coverage` |
| `if x < 5 then` (in prose) | `if x &lt; 5 then` |
| `&` standalone in prose | `&amp;` |

Inside fenced code blocks (` ``` `) characters are NOT parsed as MDX — so you don't need to escape there.

## Control page template (Module A / Module B)

Every file in `src/content/docs/module-a/` and `src/content/docs/module-b/` must follow this exact structure:

```mdx
---
title: "<MODULE>.<SECTION>.<ITEM> – <Short Title>"
description: <One-sentence summary used by Starlight + search engines>
sidebar:
  label: "<SECTION>.<ITEM> <Short Title>"
  order: <integer>
---

import { Aside } from '@astrojs/starlight/components';

## What the Auditor Checks

<Short prose paragraph>

**Typical questions:**
- <Q1>
- <Q2>

---

## Required Evidence Checklist

| # | Evidence Item | Accepted Formats | Status |
|---|---|---|---|
| 1 | **<Item name>** | PDF, Word, Excel | ⬜ |

<Aside type="tip">
  <Optional shortcut or pro tip>
</Aside>

---

## Evidence Guidance

### <Item 1 name>
<How to produce / collect it>

---

## Evidence Status

| Item | Owner | Status | Last Updated | Notes |
|---|---|---|---|---|
| <Item 1> | | ⬜ Not started | | |

---

## Common Gaps

- **<Gap>:** <Why it fails the audit and how to prevent it>
```

## Engagement playbook page template

Pages in `src/content/docs/engagement/` follow this shape:

```mdx
---
title: <Deliverable name>
description: <One-sentence summary>
sidebar:
  order: <integer>
---

## When to use this
## Inputs you need from the customer
## Step-by-step
## Output: customer-ready deliverable
## Reuse & contribute back
```

## Status icons (mandatory)

Use only these three icons in the `Status` column: `⬜` not started · `🟡` in progress · `✅` complete.

## Cross-references

- Control numbers in prose always use dots: `A.2.1`, `B.3.1`.
- Cross-link controls with **relative** paths (Astro doesn't auto-prefix base on absolute markdown links).
- **Filenames must NOT contain dots** — Starlight strips them from URL slugs. Use `2-1-foo.mdx` not `2.1-foo.mdx`.
- Never link to GitHub Issues by hard-coded number — they vary per fork.

## When evidence requirements change

If you add, remove, or reword an evidence item in a control page, you **must** make the matching edit to `.github/scripts/create-issues.sh` so the auto-created issue checkboxes stay aligned.

## Starlight components allowed

```mdx
import { Aside, Steps, Card, CardGrid, Tabs, TabItem } from '@astrojs/starlight/components';
```

Do not introduce React components, MDX expressions that fetch data at build time, or third-party widgets without explicit need.
