#!/usr/bin/env bash
set -euo pipefail

CONFIG_FILE="${1:-apps/apps.json}"

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required" >&2
  exit 1
fi

jq -e '.apps | type == "array" and length > 0' "$CONFIG_FILE" >/dev/null

jq -e '
  [ .apps[] |
    has("id")
    and has("enabled")
    and has("upstream_repo")
    and has("version_source")
    and has("working_directory")
    and has("uses_node")
    and has("node_version")
    and has("uses_ruby")
    and has("ruby_version")
    and has("uses_go")
    and has("go_version_file")
    and has("java_version")
    and has("android_build_tools")
    and has("build_script")
    and has("build_artifact_path")
    and has("post_signing")
    and has("output_name")
    and has("package_name")
  ]
  | all
' "$CONFIG_FILE" >/dev/null

jq -e '[.apps[].id] | length == (unique | length)' "$CONFIG_FILE" >/dev/null

jq -e '
  [ .apps[] | select(.version_source != "latest_release" and .version_source != "latest_tag") ] | length == 0
' "$CONFIG_FILE" >/dev/null

jq -e '
  [ .apps[] | select((.enabled | type) != "boolean") ] | length == 0
' "$CONFIG_FILE" >/dev/null

jq -e '
  [ .apps[] | select((.uses_node | type) != "boolean" or (.uses_ruby | type) != "boolean" or (.uses_go | type) != "boolean" or (.post_signing | type) != "boolean") ] | length == 0
' "$CONFIG_FILE" >/dev/null

echo "apps config is valid: $CONFIG_FILE"
