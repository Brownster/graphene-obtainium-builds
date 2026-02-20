# Graphene Obtainium Builds

Central pipeline to build Android apps from source, sign with your own key, and publish verified releases for Obtainium.

## Why one repo for all apps

A single repo keeps your signing, policies, and automation in one place while still letting each app have its own config entry.

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
   - Optional: `EXPECTED_SIGNING_CERT_SHA256` (enforces cert pinning to your own key)
3. Commit and push this repo.
4. Run `Build, Sign, Release APKs` workflow manually.

## Seeded apps

- `audiobookshelf-app` (`advplyr/audiobookshelf-app`)
- `navic` (`paigely/Navic`)
- `mattermost-mobile` (`mattermost/mattermost-mobile`)
- `tailscale-android` (`tailscale/tailscale-android`)

## Adding an app

1. Add a new object in `apps/apps.json`.
2. Set `build_script` to produce an APK artifact.
3. Set `build_artifact_path` to the artifact file or glob.
4. Set `post_signing`:
   - `true`: pipeline signs the artifact with your key.
   - `false`: build script already produced a signed APK.
5. Set `package_name` if you want package-name enforcement.
6. Run workflow with `app_id` input for a focused first run.

## Obtainium

Point Obtainium to this repo's GitHub Releases. Install once, then updates come from your own signed builds only.
