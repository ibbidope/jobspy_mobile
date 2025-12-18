<h3 align="center">JobSpy Mobile is being hardened for a stable, production-ready release. Nightly QA builds will be published here soon.</h3>
<h4 align="center">Main development happens on <code>main</code>. Bugfix-only hot patches may land on <code>maintenance</code>.</h4>

<p align="center"><img src="assets/jobspy_logo.png" alt="JobSpy Mobile" width="140"></p>
<h2 align="center"><b>JobSpy Mobile</b></h2>
<h4 align="center">A lightweight Flutter client for the JobSpy API to check health, search LinkedIn/Indeed, and open listings fast.</h4>

<p align="center">
<a href="https://github.com/ibbidope/jobspy_mobile/releases" alt="JobSpy Mobile releases"><img src="https://img.shields.io/badge/downloads-coming%20soon-inactive"></a>
<a href="https://www.gnu.org/licenses/gpl-3.0" alt="License: GPLv3"><img src="https://img.shields.io/badge/license-TBD-blue.svg"></a>
<a href="https://github.com/ibbidope/jobspy_mobile/actions" alt="Build Status"><img src="https://img.shields.io/badge/ci-coming%20soon-lightgrey"></a>
</p>

<p align="center">
<a href="#screenshots">Screenshots</a> &bull; <a href="#supported-sources">Supported Sources</a> &bull; <a href="#description">Description</a> &bull; <a href="#features">Features</a> &bull; <a href="#installation-and-updates">Installation and updates</a> &bull; <a href="#contribution">Contribution</a> &bull; <a href="#privacy">Privacy</a>
</p>
<hr>

> [!warning]
> THIS APP IS IN BETA. YOU MAY ENCOUNTER BUGS. PLEASE OPEN ISSUES WITH CLEAR REPRO STEPS.

## Screenshots

Coming soon (health check, search form, job results).

## Supported Sources

- LinkedIn (via JobSpy API)
- Indeed (via JobSpy API)

## Description

JobSpy Mobile pairs a responsive Flutter UI with the JobSpy API so you can:
- Verify API health instantly with an animated status card.
- Run LinkedIn/Indeed searches in one place, pick which sites to query, and fetch LinkedIn descriptions when needed.
- Launch job links in the native app or browser with a tap.
- See job metadata at a glance (company, location, type, site badge).

## Features

- GetX-powered state, routing, and bindings for fast navigation and predictable updates.
- Validations for search term, location, results count, hours old, and Indeed country (only when Indeed is selected).
- Clear error and “no results” messaging; safe defaults for missing env/config.
- Debug-only network logging to avoid leaking data in production.

## Installation and updates

- Stable releases: coming soon via GitHub Releases.
- Nightly/QA: coming soon.
- Source build: `flutter pub get` then `flutter run` with a `.env` containing `API_BASE_URL`.

## Contribution

- Target `main` for feature work; keep changes small and covered by tests (`flutter test`).
- Regenerate JSON model code if model fields change.
- Add controller and widget tests when adding new user-facing behaviors.

## Privacy

JobSpy Mobile does not collect analytics. Network calls go directly to the configured JobSpy API endpoint. External links (job URLs) open via the platform browser/app.
