# Automatic subagent routing

When the latest effective Plan Mode contract says Plan Mode is active, automatically use the configured read-only planning workflow for the first substantive planning request and for each material scope revision:

1. Run `architect` to inspect the repository and produce a decision-ready plan draft.
2. Run `advisor` after `architect` to critique that draft for unsupported assumptions, contract mismatches, missing validation, unnecessary complexity, and material risks.
3. The main agent remains the decision authority, synthesizes both results, asks only necessary questions, and submits the final plan with `plan_mode_complete` as the final action by itself.

Use one parent-controlled `workflowScript` for the two stages. Keep both children read-only. Never launch `backend` or `frontend` while Plan Mode is active. Do not launch the same planning workflow repeatedly for an unchanged request; reuse results already present in the conversation. If `subagent` is unavailable or blocked, continue planning directly rather than failing the request.

Outside Plan Mode, do not force this planning workflow. Route explicitly approved implementation work to `backend` or `frontend` only when their scope matches, and keep one writer at a time in a shared working directory.
