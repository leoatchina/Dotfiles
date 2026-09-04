# Automatic subagent routing

## In Plan Mode (Planning Workflow)

When the latest effective Plan Mode contract says Plan Mode is active, automatically use the configured read-only planning workflow for the first substantive planning request and for each material scope revision:

1. Run `architect` to inspect the repository and produce a decision-ready plan draft.
2. Run `advisor` after `architect` to critique that draft for unsupported assumptions, contract mismatches, missing validation, unnecessary complexity, and material risks.
3. The main agent remains the decision authority, synthesizes both results, asks only necessary questions, and submits the final plan with `plan_mode_complete` as the final action by itself.

Use one parent-controlled `workflowScript` for the two stages. Keep both children read-only. Never launch `backend` or `frontend` while Plan Mode is active. If external documentation or web research is required during planning, `tiny` may also be dispatched as a read-only researcher. Do not launch the same planning workflow repeatedly for an unchanged request; reuse results already present in the conversation. If `subagent` is unavailable or blocked, continue planning directly rather than failing the request.

## Research and Web Search (Both Modes)

When external information, online API documentation, library specs, GitHub issues, or public error solutions are needed (in either Plan Mode or Normal Mode), automatically dispatch `tiny` to perform web searches and documentation retrieval, keeping the main context clean. Do not dispatch `backend` or `frontend` for research tasks.

## Outside Plan Mode (Implementation Workflow)

When the user requests code implementation, feature development, bug fixes, or refactoring in Normal Mode, automatically route the execution to the appropriate subagents without requiring the user to explicitly name them:

1. **Automatic Routing to Writer Agent**:
   - Backend logic, systems, scripts, APIs, data processing, backend tests -> dispatch `backend`.
   - Frontend UI, web components, client styling, interaction, client state -> dispatch `frontend`.
   - Full-stack tasks -> sequence `backend` then `frontend` (keep one writer at a time in a shared worktree).
2. **Automatic Review**:
   - After the writer agent finishes implementation and initial verification, automatically dispatch `advisor` to review the diff for regressions, edge cases, contract violations, and test gaps.
3. **Synthesis & Reporting**:
   - The main agent synthesizes the results, runs any final project-level checks if needed, and reports the changes and verification status to the user.

For purely conversational queries, explanations, or meta-questions, answer directly without dispatching subagents. If `subagent` is unavailable, blocked, or the change is a trivial one-line edit, the main agent may complete the task directly.
