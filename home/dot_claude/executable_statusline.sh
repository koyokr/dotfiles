#!/usr/bin/env bash
# Claude Code status line: model effort · dir · context % used · 5h / 7d % left
jq -r --arg home "$HOME" '
  def pct: if . == null then "-" else "\(floor)%" end;
  def left: if . == null then null else 100 - . end;
  def hm: if . == null then "" else " (" + (localtime | strftime("%H:%M")) + ")" end;
  [
    ([.model.display_name, (.effort.level // empty)] | join(" ")),
    ((.workspace.current_dir // .cwd) | sub("^" + $home; "~")),
    "context " + (.context_window.used_percentage | pct) + " used",
    (.rate_limits.five_hour
      | if . then "5h " + (.used_percentage | left | pct) + " left" + (.resets_at | hm) else empty end),
    (.rate_limits.seven_day
      | if . then "7d " + (.used_percentage | left | pct) + " left" else empty end),
    (.session_id // empty)
  ] | join(" · ")
'
