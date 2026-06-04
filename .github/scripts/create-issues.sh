#!/usr/bin/env bash
# create-issues.sh
# Creates all audit engagement issues for the Networking Services in Microsoft Azure
# Advanced Specialization (V1.8.1). Skips any issue whose title already exists
# (open or closed) under the cycle label to avoid duplicates across re-runs.
#
# Environment variables expected:
#   GH_TOKEN     - GitHub token with issues:write permission
#   CYCLE_LABEL  - e.g. "audit-2026"
#   MILESTONE    - milestone title (e.g. "Audit 2026")
#   REPO         - owner/repo

set -euo pipefail

# ─── helpers ──────────────────────────────────────────────────────────────────

create_issue() {
  local title="$1"
  local labels="$2"
  local body="$3"

  local existing
  existing=$(gh issue list \
    --repo "$REPO" \
    --state all \
    --label "$CYCLE_LABEL" \
    --limit 200 \
    --json title \
    --jq "[.[] | select(.title == \"$title\")] | length")

  if [ "${existing:-0}" -gt 0 ]; then
    echo "⏭  Skipping (exists): $title"
    return
  fi

  gh issue create \
    --repo "$REPO" \
    --title "$title" \
    --label "$labels" \
    --milestone "$MILESTONE" \
    --body "$body"

  echo "✅ Created: $title"
}

# ─── Pre-Qualification Gate ───────────────────────────────────────────────────

create_issue \
  "🎯 Pre-Qualification Gate" \
  "pre-qualification,$CYCLE_LABEL" \
  "## Pre-Qualification Gate

Confirm all pre-qualification requirements are met **before** requesting the audit from Partner Center.

📖 [Full requirements guide](../../src/content/docs/requirements.mdx)

---

### Solutions Partner designation
- [ ] Active **Solutions Partner for Infrastructure (Azure)** confirmed in Partner Center → Overview → Membership
- [ ] Screenshot exported for evidence

### Module A waiver check (optional fast path)
- [ ] Confirm whether a prior Pass exists (Expert MSP V1.9+ or any V2.0+ Azure specialization within last 24 months) that waives Module A

### Audit scoping
- [ ] Decision: Module B only (\$2,400, 4 h) or Module A+B (\$3,600, 8 h)
- [ ] Audit window booked with ISSI
- [ ] Customer evidence anonymisation policy agreed internally

### Engagement playbook ready
- [ ] [Offering one-pager](../../src/content/docs/engagement/offering-one-pager.mdx) tailored to firm
- [ ] [Qualification questionnaire](../../src/content/docs/engagement/qualification-questionnaire.mdx) reviewed
- [ ] [Reference architectures](../../src/content/docs/engagement/reference-architectures.mdx) endorsed by CODEOWNERS"

# ─── Module A controls ────────────────────────────────────────────────────────

create_issue \
  "A.1.1 — Cloud & AI Adoption Business Strategy" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.1.1 — Cloud & AI Adoption Business Strategy

📖 [Control guidance](../../src/content/docs/module-a/1-1-cloud-ai-adoption-business-strategy.mdx)

Required: **2 unique customers** in the last **12 months**, with **2 assessments** demonstrating both Business and FinOps outcomes. **FinOps Review is mandatory for all partners.**

### Customer A
- [ ] FinOps Review completed and exported
- [ ] Cloud Adoption Strategy Evaluator (CASE) OR Advisor assessment completed
- [ ] Strategy review document capturing business needs + partner recommendations
- [ ] Customer-named PDF in evidence folder \`Module A / A1.1 / CustomerA /\`

### Customer B
- [ ] FinOps Review completed and exported
- [ ] Second assessment (CASE / Advisor) completed
- [ ] Strategy review document
- [ ] Customer-named PDF in evidence folder \`Module A / A1.1 / CustomerB /\`

### Evidence index
- [ ] Both customers logged in the evidence-tracker spreadsheet"

create_issue \
  "A.1.2 — Cloud & AI Adoption Plan" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.1.2 — Cloud & AI Adoption Plan

📖 [Control guidance](../../src/content/docs/module-a/1-2-cloud-ai-adoption-plan.mdx)

Required: **2 unique customer projects** completed in the last **12 months**, with cost-management report (with pricing-calculator output) AND DevOps capability assessment per customer.

### Customer A
- [ ] Cost management report + Azure Pricing Calculator export
- [ ] DevOps capability assessment report
- [ ] Adoption plan / project plan
- [ ] At least 2 of: roadmap, prioritisation matrix, KPI tracker, executive readout

### Customer B
- [ ] Cost management report + Azure Pricing Calculator export
- [ ] DevOps capability assessment report
- [ ] Adoption plan / project plan
- [ ] At least 2 of the supporting documents"

create_issue \
  "A.2.1 — Security & Governance Tooling" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.2.1 — Security & Governance Tooling

📖 [Control guidance](../../src/content/docs/module-a/2-1-security-governance-tooling.mdx)

Required: **2 unique customers** in the last **12 months**.

### Customer A
- [ ] Microsoft Defender for Cloud baseline configured (or 3rd-party equivalent)
- [ ] Cloud Adoption Security Review assessment completed
- [ ] Baseline evidence (screenshots / exported reports) attached

### Customer B
- [ ] Defender for Cloud baseline configured
- [ ] Cloud Adoption Security Review completed
- [ ] Evidence attached"

create_issue \
  "A.2.2 — Well-Architected Workloads" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.2.2 — Well-Architected Workloads

📖 [Control guidance](../../src/content/docs/module-a/2-2-well-architected-workloads.mdx)

Required: **2 unique customer projects** in the last **12 months** + **Architecture Center alignment** + **1 WAR** per workload (Go-Live or Standard).

### Customer A
- [ ] Reference architecture cited (link)
- [ ] WAR export (customer-named PDF)
- [ ] 2 pillars selected — defaults: Reliability + Security (or Performance)

### Customer B
- [ ] Reference architecture cited
- [ ] WAR export (customer-named PDF)
- [ ] 2 pillars selected"

create_issue \
  "A.3.1 — Repeatable Deployment (ALZ)" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.3.1 — Repeatable Deployment

📖 [Control guidance](../../src/content/docs/module-a/3-1-repeatable-deployment.mdx)

Required: **2 unique customers** + ALZ-aligned deployment using Bicep, Terraform, or ARM + **ALZ Review** with multi-region/multi-zone redundancy policy.

### Customer A
- [ ] Identity configured (Entra ID / equivalent)
- [ ] Networking topology configured (CAF; hybrid via ER/VPN where applicable)
- [ ] Resource organization (tagging + naming standards) documented
- [ ] IaC (Bicep / Terraform / ARM) repository link
- [ ] ALZ Review export with redundancy-policy result

### Customer B
- [ ] Identity, Networking, Resource org configured
- [ ] IaC repository link
- [ ] ALZ Review export"

create_issue \
  "A.3.2 — Plan for Skilling" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.3.2 — Plan for Skilling

📖 [Control guidance](../../src/content/docs/module-a/3-2-plan-for-skilling.mdx)

Required: **2 unique customer engagements** in the last **12 months**. *(TAGA report NOT required for Networking.)*

### Customer A
- [ ] Skilling plan covering IT Admin / Governance / Operations / Security roles
- [ ] Microsoft Learn paths and certification references included
- [ ] Customer-facing presentation OR planning docs OR post-deployment doc

### Customer B
- [ ] Skilling plan
- [ ] Learn paths + certifications listed
- [ ] Customer-facing evidence"

create_issue \
  "A.3.3 — Operations Management Tooling" \
  "module-a,audit-evidence,$CYCLE_LABEL" \
  "## A.3.3 — Operations Management Tooling

📖 [Control guidance](../../src/content/docs/module-a/3-3-operations-management-tooling.mdx)

Required: **2 unique customers** + at least 1 of (Azure Monitor / Automation / Backup / Site Recovery) + a CI/CD security artifact (PII-free, timestamped, traceable).

### Customer A
- [ ] Ops tool deployed (specify which)
- [ ] CI/CD security artifact: pipeline YAML / SBOM / Defender DevOps export / policy-as-code snapshot
- [ ] Azure Advisor Reliability Review (recommended)

### Customer B
- [ ] Ops tool deployed
- [ ] CI/CD security artifact
- [ ] Advisor Reliability Review"

# ─── Module B controls ────────────────────────────────────────────────────────

create_issue \
  "B.1.1 — Cloud Networking Requirements Assessment" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.1.1 — Cloud Networking Requirements Assessment

📖 [Control guidance](../../src/content/docs/module-b/1-1-cloud-networking-requirements-assessment.mdx)

Required: **3 unique customer projects** in the last **18 months**, addressing all 8 bullets.

### Per-customer checklist (repeat ×3)
- [ ] Workload inventory (IaaS / PaaS / SaaS)
- [ ] Cloud footprint — regions in use / planned
- [ ] Terrestrial footprint — branches, HQ, DC sites, remote access
- [ ] Bandwidth + latency requirements per workload
- [ ] HA / backup / DR connectivity needs
- [ ] Segmentation + security requirements
- [ ] Private and internet connectivity needs
- [ ] Current architecture + gap analysis + best-practice recommendations
- [ ] Output: SOW / questionnaire / 3rd-party tool report / discovery workshop output"

create_issue \
  "B.2.1 — Solution Design" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.2.1 — Solution Design

📖 [Control guidance](../../src/content/docs/module-b/2-1-solution-design.mdx)

Required: **3 unique customer projects** in the last **18 months**, ≥ 1 of the 5 scenarios, with all design-point coverage items addressed.

### Per-customer checklist (repeat ×3)
- [ ] Scenario tagged: Secure infra / On-prem branch / Remote work / Global app delivery / 5G & edge
- [ ] Reference architecture cited (hub-spoke / VWAN / secure-edge / multi-region / PaaS isolation / hybrid baseline / landing-zone connectivity)
- [ ] CAF Network Topology alignment documented
- [ ] HA + reliability requirements addressed
- [ ] High-level implementation plan with estimated time-to-finish
- [ ] Validation approach for connectivity requirements
- [ ] ALZ design areas (hub-spoke / perimeter security / monitoring / cost-mgmt) addressed or deviation documented
- [ ] HLD + LLD + diagrams attached"

create_issue \
  "B.2.2 — Azure Well-Architected Review (Networking)" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.2.2 — Azure Well-Architected Review

📖 [Control guidance](../../src/content/docs/module-b/2-2-azure-well-architected-review.mdx)

Required: minimum **1 Networking workload** WAR within the last **12 months**, with **2 pillars** of output, customer-named.

### Checklist
- [ ] WAR run with workload type = Networking
- [ ] 2 pillars selected (default: Reliability + Security)
- [ ] Customer-named export PDF saved
- [ ] 1-page action plan attached"

create_issue \
  "B.3.1 — Cloud Networking Scenarios (deployment)" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.3.1 — Cloud Networking Scenarios

📖 [Control guidance](../../src/content/docs/module-b/3-1-cloud-networking-scenarios.mdx)

Required: **1 customer** with production deployment of ≥ 1 of the 5 scenarios in the last **18 months**.

### Checklist
- [ ] Scenario tagged
- [ ] Go-Live date documented (production)
- [ ] At least 2 of: signed SOW · solution design · project plan + sequence · architecture diagrams · HLD + LLD · as-built"

create_issue \
  "B.3.2 — Azure Networking Services (≥ 5 implemented)" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.3.2 — Azure Networking Services

📖 [Control guidance](../../src/content/docs/module-b/3-2-azure-networking-services.mdx)

Required: ≥ **5 of 11** native services implemented across customer project(s) in the last **18 months**.

### Service tracker (tick each implemented)
- [ ] Virtual Network + VNet Peering
- [ ] ExpressRoute
- [ ] VPN
- [ ] Virtual WAN
- [ ] CDN
- [ ] Front Door
- [ ] Load Balancer
- [ ] Private Link
- [ ] Traffic Manager
- [ ] Application Gateway
- [ ] Azure Firewall

### Evidence
- [ ] At least 2 of: SOW · solution design · project plan · architecture diagrams · HLD + LLD · as-built"

create_issue \
  "B.4.1 — Service Validation and Testing" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.4.1 — Service Validation and Testing

📖 [Control guidance](../../src/content/docs/module-b/4-1-service-validation-and-testing.mdx)

Required: **1 customer**, project in last **18 months**, with **customer sign-off**.

### Checklist
- [ ] Documented testing / validation / performance plan
- [ ] Test results showing customer requirements met
- [ ] Remediation log for any revealed issues
- [ ] **Customer sign-off PDF** (signed) attached"

create_issue \
  "B.4.2 — Post-deployment Documentation" \
  "module-b,audit-evidence,$CYCLE_LABEL" \
  "## B.4.2 — Post-deployment Documentation

📖 [Control guidance](../../src/content/docs/module-b/4-2-post-deployment-documentation.mdx)

Required: **1 customer** with completed implementation in the last **18 months**.

### Checklist
- [ ] As-built documentation (deltas from initial design captured)
- [ ] Standard operating procedures / how-to scenarios for BAU
- [ ] Architectural decisions + rationale
- [ ] Runbook (alternative evidence if managing the service on behalf of the customer)"

echo ""
echo "🎉 All audit engagement issues created."
