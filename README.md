# Graphene Obtainium Builds

Central pipeline to build Android apps from source, sign with your own key, and publish verified releases for Obtainium.

## Why one central repo

A single repo keeps signing, policies, and automation in one place. Each app is then published to its own GitHub releases repo for clean Obtainium URLs.

## Repository layout

- `apps/apps.json`: app allowlist + build config.
- `.github/workflows/build-sign-release.yml`: matrix workflow.
- `scripts/validate-apps.sh`: config validation.
- `docs/`: notes and onboarding docs.

## One-time setup

1. Generate and keep one long-lived Android keystore.
2. Add repository secrets:
   - `ANDROID_KEYSTORE_B64`
   - `ANDROID_KEYSTORE_PASSWORD`
   - `ANDROID_KEY_ALIAS`
   - `ANDROID_KEY_PASSWORD`
   - `RELEASE_REPO_TOKEN` (classic PAT with `repo` scope, or fine-grained token with `Contents: Read and write` on all target release repos)
   - Optional: `EXPECTED_SIGNING_CERT_SHA256` (enforces cert pinning to your own key)
3. Commit and push this repo.
4. Run `Build, Sign, Release APKs` workflow manually.

## Seeded apps

- `audiobookshelf-app` (`advplyr/audiobookshelf-app`)
- `navic` (`paigely/Navic`)
- `mattermost-mobile` (`mattermost/mattermost-mobile`)
- `tailscale-android` (`tailscale/tailscale-android`)
- `signal-android` (`signalapp/Signal-Android`)
- `newpipe` (`TeamNewPipe/NewPipe`)
- `bitwarden-android` (`bitwarden/android`)
- `jellyfin-android` (`jellyfin/jellyfin-android`)

## Adding an app

1. Add a new object in `apps/apps.json`.
2. Set `build_script` to produce an APK artifact.
3. Set `build_artifact_path` to the artifact file or glob.
4. Set `release_repo` to the target repo that will host this app's releases.
5. Set `post_signing`:
   - `true`: pipeline signs the artifact with your key.
   - `false`: build script already produced a signed APK.
6. Set `package_name` if you want package-name enforcement.
7. Run workflow with `app_id` input for a focused first run.

## Obtainium

Point Obtainium to each app-specific release repo URL (one app per repo). Install once, then updates come from your own signed builds only.
