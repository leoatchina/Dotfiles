---
name: plan-doc-review
description: Connect Pi plan mode with pi-doc-review for a human review loop. Use whenever the user asks to plan and review a change, review a plan before implementation, visually annotate an implementation plan, or combine /plan with /doc-review.
compatibility: Requires npm:@narumitw/pi-plan-mode and npm:pi-doc-review.
---

# Plan document review

Create a decision-ready implementation plan, save it as Markdown, open it in `doc-review`, and incorporate the user's feedback before final approval.

## Workflow

1. Confirm that Pi Plan mode is active. If it is not active, ask the user to start it with `/plan <request>`; do not pretend that a skill can toggle Pi's mode itself.
2. Investigate the repository and resolve important ambiguities using the active Plan mode tools and contract.
3. Write the draft to `plan/<YYYY-MM-DD>_<short-description>.md` using Linux line endings. Create `plan/` when needed.
4. Open the draft with the installed dispatcher:

   ```bash
   doc-review <absolute-plan-path>
   ```

   Run this command by itself and wait for it to finish. Do not launch parallel work while the review window is open.
5. Interpret the dispatcher result:
   - `FEEDBACK_FILE: <path>`: read the feedback, apply direct Markdown edits, then address every selection and overall comment.
   - `REVIEW_CANCELLED`: keep the draft unchanged and tell the user that review was cancelled.
   - Any error: report it verbatim and stop the review loop.
6. If the feedback reports that the file changed during review, reconcile it with the current on-disk plan instead of overwriting blindly.
7. Reopen `doc-review` only when the user asks for another pass or unresolved feedback requires confirmation.
8. After approval, finish through the active Plan mode contract. If `plan_mode_complete` is required, call it alone as the final action and use the reviewed Markdown as the submitted plan.

## Boundaries

- Do not implement code while Plan mode is active.
- Do not invoke `/doc-review` as shell syntax; use the `doc-review` executable from shell, while `/doc-review` remains available for direct user invocation in Pi.
- Preserve the reviewed plan file as the implementation handoff artifact.
- Report unresolved or conflicting comments explicitly.
