# Contributing

Thanks for helping improve the **Networking Services in Microsoft Azure Specialization** engagement toolkit. This repo is **innersource** — anyone in the practice can contribute audit clarifications, reference architectures, deliverable improvements, and lessons learned.

## Ways to contribute

| What | How |
|---|---|
| Clarify a control's evidence wording | Open a **Control Improvement** issue, then a PR against the relevant `module-a/` or `module-b/` MDX file |
| Improve a deliverable template (HLD / LLD / Runbook / KT / Hypercare) | Open a **Template Improvement** issue, then a PR against `engagement/deliverables/` |
| Add a reference architecture | Open a **Template Improvement** issue (kind=reference-architecture), then a PR against `engagement/reference-architectures/` |
| Capture a lesson learned | Open a **Lesson Learned** issue |
| Fix a typo / broken link | PR directly, no issue needed |

## Branch naming

```
<type>/<short-description>
```

- `type` ∈ `feat`, `fix`, `docs`, `chore`, `refactor`
- Examples: `feat/vwan-secured-hub-ref-arch`, `fix/b-3-2-evidence-wording`, `docs/lld-template-tagging`

## Commit messages

Use Conventional Commits:

- `feat(refs): add Secured Virtual Hub reference architecture`
- `fix(module-b): clarify B.3.2 service-count requirement`
- `docs(engagement): tighten qualification questionnaire section 3`

## Pull request flow

1. Open or pick up an issue (one PR per issue where practical)
2. Branch from `main`
3. Run `npm install && npm run build` locally — the PR will not be merged if the build is broken
4. Fill in `PULL_REQUEST_TEMPLATE.md` linking the improvement → engagement phase → control ID
5. Request review from the relevant CODEOWNERS area lead

## Review SLA

- First reviewer response: **2 business days**
- Merge target after approval: **1 business day**
- Reference-architecture changes require **2 approvers** (network + security area leads)

## Content governance lifecycle

Every page moves through the lifecycle defined in `src/content/docs/innersource/content-governance.mdx`:

```
Draft → Reviewed → Endorsed → Deprecated
```

Status is set in the front matter / page footer.

## Code of conduct

Be specific, be kind, be useful. No customer-identifying content in PRs — anonymise as "Customer A / B / C". No secrets, no credentials, no tenant IDs.

## MDX rules

See [`.github/memories/mdx-content.md`](.github/memories/mdx-content.md) for the strict MDX authoring rules (especially the `<` escaping rule and dot-free filenames).
