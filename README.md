# Networking Services in Microsoft Azure — Advanced Specialization

> Engagement toolkit for Microsoft partners pursuing the **Networking Services in Microsoft Azure Advanced Specialization** audit (V1.8.1, active **Jan 1 – Jun 30, 2026**; V1.9 in PREVIEW).

---

## 🎯 Purpose

This repository gives Azure Network Architects a structured, repeatable engagement framework to guide partner organisations from discovery through audit. It includes:

- **GitHub Issues** as the engagement task board — one issue per audit control with evidence checklists
- **Documentation site** (Astro / Starlight) with detailed evidence guidance for every Module A and Module B control
- **Engagement Playbook** — qualification questionnaire, discovery workshop, WAF assessment, MAP / ALZ inputs, reference architectures (hub-spoke, VWAN, secure edge, multi-region), and customer deliverable templates (HLD / LLD / Runbook / KT / Hypercare)
- **Engagement Agent** — an AI assistant that knows every networking control, evidence requirement, and common gap
- **Automated issue creation** — recreates audit issues each year, 9 months before the next audit window

---

## 🚀 Getting Started

This repo is a **GitHub Template**. Click **"Use this template"** (not Fork) to create your own copy.

### 1. Use this template
Click **Use this template → Create a new repository** and choose your GitHub organisation.

### 2. Set your site URL
In `astro.config.mjs`, the site URL is derived from `GITHUB_REPOSITORY` automatically and may be overridden via repo variables:

- Go to your repo → **Settings → Secrets and variables → Actions → Variables**
- Add `ASTRO_SITE` = `https://YOUR_ORG.github.io/YOUR_REPO_NAME` (optional)
- Add `ASTRO_GITHUB_URL` = `https://github.com/YOUR_ORG/YOUR_REPO_NAME` (optional)

### 3. Enable GitHub Pages
**Settings → Pages → Source** → select **GitHub Actions**.

### 4. Create the engagement issues
**Actions → Create Audit Engagement Issues → Run workflow.**

### 5. Done
- Issues appear as your engagement task board 📋
- The documentation site deploys automatically on push to `main` 🌐
- Use the Engagement Agent for guided assistance 🤖

---

## 🤖 Engagement Agent

This repo ships with a **GitHub Custom Agent** that knows every Networking Services audit control, evidence requirement, and common blocker, plus the engagement playbook (qualification questionnaire, discovery workshop, reference-architecture lookup, WAF pillars).

Ask things like:
> *"What should we work on first?"*
> *"What evidence do we need for B.3.2?"*
> *"Customer is multi-region with ExpressRoute — VWAN or hub-spoke?"*
> *"Help me write the LLD for a Secured Virtual Hub deployment."*

Agent profile: [`.github/agents/engagement-agent.agent.md`](.github/agents/engagement-agent.agent.md).

---

## 📅 Annual Audit Cycle

The `Create Audit Engagement Issues` workflow runs on a **schedule** (default: March 1st) — 9 months after a typical June audit. Adjust the cron month in `.github/workflows/create-issues.yml` to match your audit timing.

---

## 🖥️ Local Development

```bash
npm install
npm run dev
```

Requires Node 24.

---

## 📁 Structure

```
├── .github/
│   ├── agents/engagement-agent.agent.md
│   ├── memories/mdx-content.md
│   ├── ISSUE_TEMPLATE/
│   ├── PULL_REQUEST_TEMPLATE.md
│   ├── scripts/create-issues.sh
│   └── workflows/{deploy,create-issues,copilot-setup-steps}.yml
├── CONTRIBUTING.md
├── CODEOWNERS
└── src/content/docs/
    ├── index.mdx / overview.mdx / requirements.mdx / audit-process.mdx
    ├── evidence-tracker.mdx / faq.mdx
    ├── module-a/                 # A.1.1 – A.3.3 (Cloud Foundation)
    ├── module-b/                 # B.1.1 – B.4.2 (Networking Services workload)
    ├── engagement/               # Offering, qualification, discovery, WAF, MAP, refs, deliverables, DoD
    │   ├── deliverables/
    │   └── reference-architectures/
    └── innersource/              # Contributing, governance, roadmap
```

---

## 📄 License

Content is provided for partner enablement purposes. Refer to your Microsoft Partner Agreement for usage terms.
