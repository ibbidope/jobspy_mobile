<h3 align="center">JobSpy Mobile is stable, production-ready, and allergic to flaky builds.</h3>

<p align="center"><img src="assets/images/jobspy_banner.png" alt="JobSpy Mobile" width="300"></p>
<h2 align="center"><b>JobSpy Mobile</b></h2>
<h4 align="center">A Flutter app that scrapes fresh LinkedIn/Indeed gigs so you spend less time tab-juggling and more time choosing which swag hoodie to wear.</h4>

<p align="center">
<a href="https://github.com/ibbidope/jobspy_mobile/releases" alt="JobSpy Mobile releases"><img src="https://img.shields.io/badge/release-stable-brightgreen"></a>
<a href="https://www.gnu.org/licenses/gpl-3.0" alt="License: GPLv3"><img src="https://img.shields.io/badge/license-GPLv3-blue.svg"></a>
<a href="https://github.com/ibbidope/jobspy_mobile/actions" alt="Build Status"><img src="https://img.shields.io/badge/ci-main-blue"></a>
</p>

<p align="center">
<a href="#quickstart">Quickstart</a> &bull; <a href="#features">Features</a> &bull; <a href="#supported-sources">Supported Sources</a> &bull; <a href="#screenshots">Screenshots</a> &bull; <a href="#privacy">Privacy</a> &bull; <a href="#contributing">Contributing</a>
</p>
<hr>

## Features

- Health check that admits when the service is down instead of gaslighting you.
- Unified search for LinkedIn and Indeed; pick sources like toggling feature flags.
- Instant launch to the native app or browser so you can apply faster than your coffee cools.
- GetX-driven state/routing for snappy navigation—no setState whack-a-mole.
- Input validation for search term, location, results count, hours old, and country (only when Indeed is selected).
- Debug-only network logging; production stays as quiet as a server room at 3 a.m.

## Supported Sources

- LinkedIn (scraped via backend)
- Indeed (scraped via backend)

## Screenshots

Coming soon (health check, search form, job results). Imagine tasteful gradients and zero spinner storms.

## Privacy

No analytics, no secret trackers. Calls go straight to our configured backend. External job links (job URLs) open via the platform browser/app.
