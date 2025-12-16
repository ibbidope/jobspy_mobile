# JobSpy Mobile

Flutter client for the JobSpy API: check service health, search LinkedIn/Indeed jobs, and open job listings in their native app or browser.

## Features
- API health card with one-tap refresh and animated status.
- Job search form with validation for required fields (site selection, search term, location, results count, hours old, Indeed country when applicable).
- Job results list with site badges and external launch for job links.
- Shared UI components (cards, chips, inputs) and GetX for state management/routing.

## Requirements
- Flutter SDK 3.9.2+
- Android Studio or Xcode CLI tools for device builds
- A running JobSpy API endpoint

## Setup
1. Install Flutter dependencies: `flutter pub get`
2. Configure environment:
   ```bash
   cp .env.example .env  # if you have an example; otherwise create .env
   ```
   `.env` must include:
   ```env
   API_BASE_URL=https://your-api-host.com
   ```
3. Generate json_serializable models if you change them:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. Run the app on a device/emulator:
   ```bash
   flutter run
   ```

## Project Structure
- `lib/main.dart` ƒ?" app entry, binds routes and global bindings.
- `lib/api/` ƒ?" ApiProvider (Dio), repository, and constants.
- `lib/modules/home/` ƒ?" home binding/controller/view for health + job search.
- `lib/shared/widgets/` ƒ?" reusable UI components (inputs, cards, chips).
- `lib/models/` ƒ?" JSON models for health and jobs.

## Notes
- If you see `MissingPluginException` for `url_launcher`, run `flutter clean && flutter pub get`, then rebuild on a real device/emulator.
- The default `test/widget_test.dart` is the stock Flutter counter test and does not cover current screens.
