---
name: daily-work-summary-balancehq
description: Auto-generate a summary of work done at the end of the day and add it to the daily Obsidian note in my BalanceHQ vault
---

Check local checkouts of BalanceHQ repositories  (located at `~/code/balancehq` - all directories here are valid targets) for work done today, then update your BalanceHQ Obsidian vault (stored at `~/Documents/balanceHQ/`).

1. For each repository, check all branches modified by you in the last 24 hours. If the checkout doesn't exist at the expected path, or if no branches were modified, skip that repository and do not mention it in the summary.
2. For each modified branch, summarize the changes in 2–3 sentences: what you worked on, what changed, and current status. Ensure that GitHub issues are properly linked to in the summary.
3. Compile these summaries into a brief daily work summary.
4. In your BalanceHQ Obsidian vault, find or create today's Daily Note file.
5. Append the work summary to the "Notes" section of the Daily Note.
6. Stage the Daily Note file, commit with message "daily note summary: YYYYMMDD" (using today's date), and push to origin.

Hard constraints while executing this scheduled task:
1. DO NOT MODIFY ANYTHING OUTSIDE OF THE BALANCEHQ OBSIDIAN VAULT.
2. If none of the listed repository checkouts exist on this machine, *stop* — do not search elsewhere on the filesystem for them, and do not create/update the Daily Note.
3. If work *is not* detected in any repository, *stop* - do not create/update the Daily Note just to say nothing was done.
4. If work *is* detected and the Daily Note does not exist, create it before appending.