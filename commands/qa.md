Run QA testing on the target application with browser automation, accessibility audit, and user flow verification.

Target: $ARGUMENTS

## Pipeline

### Phase 1: Environment Setup

1. Check if Playwright is installed: `npx playwright --version`
2. If not installed: `npm init -y && npm install playwright && npx playwright install chromium`
3. Identify test target:
   - If URL provided in $ARGUMENTS → use directly
   - If no URL → check for dev server config (`package.json` scripts, `.env`) and start it
   - Common patterns: `npm run dev`, `npm start`, `bun dev`

### Phase 2: Smoke Test

Spawn `qa-tester` agent:
> "Navigate to [URL]. Take full-page screenshots at 3 viewports (375px, 768px, 1280px). Report any console errors, broken images, or layout issues."

### Phase 3: User Flow Testing

Based on the app type, test critical flows:
- **Auth app**: signup → login → logout → password reset
- **Dashboard**: navigation → data loading → filters → export
- **E-commerce**: browse → add to cart → checkout
- **Form app**: fill → validate → submit → success/error states
- **API app**: endpoint responses → error handling → loading states

Spawn `qa-tester` agent for each independent flow (parallel if possible).

### Phase 4: Accessibility Audit

Spawn `qa-tester` agent:
> "Run accessibility audit on [URL]. Check WCAG AA compliance: contrast ratios, form labels, alt text, keyboard navigation, focus indicators, semantic HTML."

### Phase 5: Report & Fix

Compile all findings into a single QA report.

If BLOCKER or MAJOR issues found:
1. Present findings with screenshots to user
2. Ask: "Fix these issues automatically?"
3. If yes → fix code → re-run affected tests → verify fix

```
## QA Report: [target]

### Summary
- Pages tested: N
- Viewports: 375px, 768px, 1280px
- Total findings: N (Blocker: N, Major: N, Minor: N)
- Accessibility violations: N

### Blocker (must fix before ship)
[findings with screenshots]

### Major (should fix)
[findings with screenshots]

### Minor (nice to have)
[findings]

### Accessibility
[WCAG violations with remediation]

### Verdict: PASS / FAIL
```

## Rules
- Always test at minimum 3 viewports
- Screenshot every finding as evidence
- Never skip accessibility audit
- If dev server needs to be started, start it and wait for it to be ready
- Clean up: kill dev server process after testing if we started it
- Don't modify test config files unless asked
