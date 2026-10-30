---
name: mockups
description: Draft multiple self-contained HTML UI mockups from a product description, screenshots, photos, or a list of usability problems. Save the mockups to `.notes/mockups/` and open the HTML document in the browser. Use when the user asks for UI mockups, interface concepts, screen variants, visual explorations, or competing design options.
disable-model-invocation: true
---

# HTML mockups

Turn the user's UI description, reference images, and problem list into a small set of meaningfully different HTML mockups. Save the result to `.notes/mockups/` and open it in the browser.

## Working style

- Treat the user's listed problems as requirements, not loose inspiration.
- Study every supplied image before drafting. Preserve relevant product conventions unless the user asks for a new visual direction.
- Ask only for missing information that would materially change the concepts. If the request already identifies the screen, users, problems, and constraints, start drafting.
- State assumptions briefly when details are missing but a reasonable default lets work continue.
- Default to three options. Use the count the user requests when they specify one.
- Make the options structurally different. Do not present the same layout with different colors.
- Use realistic labels, content, and data. Avoid lorem ipsum and placeholder-heavy wireframes unless the user asks for low fidelity.

## Concept development

Before writing HTML, identify:

1. The task the screen must help the user complete.
2. The specific problems each option must address.
3. Existing visual or interaction conventions visible in the references.
4. Hard constraints, required content, and unresolved assumptions.

Give each option a short descriptive name. Vary information architecture, content priority, interaction model, density, or progressive disclosure. Each option must make a clear trade-off and solve the stated problems in a different way.

## HTML artifact

Produce one self-contained HTML document containing every option. Start from the bundled shell template, `assets/shell.html` in this skill's directory. Do not write the comparison chrome yourself.

### How the shell works

The template has two halves:

- **Shell (fixed).** The `<style id="shell">` block, the `<script>` block, the header, and the left Brief panel provide option tabs and a persistent brief. Do not edit them.
- **Slots (yours).** Marked with `SLOT` comments. Everything else is the product UI you are designing.

Copy the template to your draft path, then edit only the slots:

```bash
cp <skill-directory>/assets/shell.html <draft.html>
```

For each option, add one matching triple. The shell script and the shell check both rely on these ids:

| Slot | Element | Key attributes |
| --- | --- | --- |
| Tab | `<button class="ms-tab" role="tab">` in the header | `id="tab-1a"`, `aria-controls="option-1a"`, `data-mockup-tab="1a"`, `data-round="1"`, inner `<span class="ms-id">1a</span>` |
| Panel | `<section class="ms-option" role="tabpanel">` in `<main>` | `id="option-1a"`, `aria-labelledby="tab-1a"`, `data-mockup-option="1a"` |
| Notes | `<article class="ms-option-notes">` in the Brief | `data-mockup-note="1a"`, `data-solves="P1 P3"` |

The rest of the slots:

- **Goal and Problems.** One sentence for the goal. One `<li data-problem="P1">` per problem the user listed. The shell dims problems an option does not address and checks the ones it does, using `data-solves`.
- **Assumptions.** Open questions and defaults you chose.
- **Product UI.** Put each option's entire UI inside its `.ms-frame`. Style it in `<style id="product">`. Add behavior in `<script id="product-js">`. Do not use the `ms-` class prefix for your own classes.
- **Native controls.** The frame defaults to `color-scheme: light` so radios, selects, checkboxes and scrollbars render correctly in light products. A dark product should set `color-scheme: dark` on its own root element.
- **Be honest in `data-solves`.** List only the problems an option clearly addresses. A problem it covers weakly is useful signal, so do not tick everything.
- **Do not put rationale in the panel.** Approach and trade-off belong in the option's notes article. Text below the frame gets lost.

### Option IDs and rounds

IDs are permanent and addressable: `1a`, `1b`, `1c` in round 1, then `2a`, `2b` in round 2. The user will refer to them ("go with 1a but add 2a's filters"). Never renumber. A new round appends tabs after a `<span class="ms-round" role="presentation">Round 2</span>` divider and keeps earlier rounds available until the user rejects them.

### Product UI guidance

- Make the options structurally different, and render each as a complete screen or coherent flow.
- Use responsive CSS so the mockup stays usable at about 760px wide, and keep it comfortable at 1440px.
- Use semantic HTML, visible focus states, sensible contrast, and keyboard-operable controls.
- Use inline CSS and JavaScript only. Prefer system fonts and embedded assets. Avoid external dependencies unless they materially improve the mockup.

## Bounded visual check

Do not show the mockup before looking at rendered snapshots yourself. Source review and HTML validation do not catch collapsed columns, accidental clipping, broken responsive states, or unusable whitespace.

1. Keep the draft as a local HTML file (copied from the shell template) at `.notes/mockups/YYYY-MM-DD-<short-artifact-slug>.html`.
2. Run the bundled snapshot helper:

   ```bash
   review_dir="$(mktemp -d "${TMPDIR:-/tmp}/mockups-review.XXXXXX")"
   node <skill-directory>/scripts/snapshot.mjs <draft.html> "$review_dir"
   ```

   Replace `<skill-directory>` with this skill's directory. The helper uses only Node's standard library and an installed Chrome or Chromium browser. It first checks the shell contract and stops with a list of problems if a tab, panel, or notes article is missing, a `data-solves` id is unknown, or `REPLACE:` placeholder text remains. Then it opens every option at a 1440x900 full-width view and a 760x900 narrow view.
3. Use the image-reading tool to inspect every PNG in the output directory. Check only for release-blocking visual defects:
   - collapsed, overlapping, clipped, or off-screen content
   - controls or important content hidden at either width
   - broken option switching or visibly incomplete states
   - product styles that leak into the shell, or shell styles that break the product
   - the main action or content sitting below the fold, where the snapshot cannot see it; the snapshot is one viewport tall, so move the action up rather than relying on scroll
   - extreme dead space, illegible text, or hierarchy that makes the screen hard to understand
   - responsive changes that leave desktop-only grid assumptions in a single-column layout
4. If a blocker appears, make one focused repair pass and run the snapshots once more. Stop after that second snapshot round. Do not keep polishing, delegate a design review, or expand scope. If a visible defect remains, call it out rather than silently presenting the artifact as finished.

If Node or a compatible Chrome/Chromium browser is unavailable, use an existing browser screenshot tool at the same two widths. Do not install dependencies just for this check. If no screenshot path exists, perform a browser/DOM smoke check and tell the user that visual review was unavailable.

Legacy `tidy` is not a useful gate for these HTML5 mockups. The rendered snapshots are the acceptance check.

## Save and open

Create `.notes/` if missing. Keep the same path for revisions in the same design thread. Run `open <path>` once, when the artifact is ready to inspect, not after every edit.

## Iteration

When the user comments on an option:

- Revise the existing document instead of creating a second artifact.
- Treat a substantial rework as a new round: append new options with new IDs (`2a`, `2b`) and keep the earlier ones. Fix small issues in place without a new ID.
- Keep the Brief current. Add or reword problems when the user raises new ones, and update each option's `data-solves`.
- Remove an abandoned option only when the user clearly rejects it.
- Run the bounded visual check again, then reopen the document so the updated mockup is in view.

Finish chat responses with the file path and a one-line summary of the options or revision. Refer to options by ID. Do not paste the full HTML into chat.
