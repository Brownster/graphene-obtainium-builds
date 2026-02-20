# App Config Reference

Each item in `apps/apps.json` supports:

- `id`: unique app ID used in release tags.
- `enabled`: whether it is included in scheduled runs.
- `upstream_repo`: `owner/repo` source to build.
- `release_repo`: `owner/repo` destination where this app release is published.
- `version_source`: `latest_release` or `latest_tag`.
- `checkout_submodules`: `false`, `true`, or `recursive` for upstream checkout.
- `working_directory`: subdir in source repo where build runs.
- `uses_node`: `true` if build needs Node.
- `node_version`: Node version when `uses_node` is true.
- `uses_ruby`: `true` if build needs Ruby/Fastlane.
- `ruby_version`: Ruby version when `uses_ruby` is true.
- `uses_go`: `true` if build needs Go.
- `go_version_file`: path to `go.mod` when `uses_go` is true.
- `java_version`: Java version for Android builds.
- `android_build_tools`: build-tools version (for `zipalign`/`apksigner`).
- `build_script`: shell command run in `working_directory`.
- `build_artifact_path`: path or glob to APK artifact from repo root.
- `post_signing`: if `true`, pipeline signs artifact with your key after build.
- `output_name`: output APK base name.
- `package_name`: optional expected package ID.
