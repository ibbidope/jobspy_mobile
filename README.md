# JobSpy Mobile

A Flutter client for the JobSpy API that fetches the latest LinkedIn and Indeed postings through a simple mobile form.

## What it does
- Check API health with a one-tap refresh and animated status indicator.
- Choose LinkedIn and/or Indeed, toggle LinkedIn description fetch, and submit a unified search.
- Capture search term, location, results wanted (1-50), hours old (1-720), and require an Indeed country only when Indeed is selected.
- Display results with site badges, job type tags, company/location details, and counts.
- Open job pages externally using direct links when available, with graceful fallbacks.
- Show inline validation and error banners for missing fields or API failures.

## Tech and architecture
- Flutter 3.9 with GetX for routing, bindings, and reactive state management.
- Dio-powered ApiRepository with models generated via json_serializable.
- Responsive layout via flutter_screenutil plus shared widgets (cards, chips, inputs, loading indicator).
- Environment config via .env (API base URL) loaded at startup.

## Key files
- lib/main.dart – app bootstrap with ScreenUtil and GetMaterialApp.
- lib/modules/home/ – health + job search UI and controller logic.
- lib/api/ – provider, repository, and API constants.
- lib/models/ – HealthModel and JobModel with generated serializers.
- lib/shared/ – reusable widgets, constants, and utilities.
