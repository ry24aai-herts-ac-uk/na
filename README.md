# na

Lightweight Flutter Android app skeleton for astrology and numerology.

## Architecture

- `lib/ui`: screens and South Indian chart renderer
- `lib/domain`: models, numerology engine, service contracts
- `lib/data`: repository orchestration
- `lib/integrations`: free-tier API and cloud database adapters

## Included features

- South Indian chart widget renderer
- Local numerology engine:
  - Pythagorean
  - Chaldean
  - Pyramid number series
  - Pyramid prediction
- API service layer for a free-tier astrology backend
- Free cloud DB adapter (REST-compatible, e.g., Supabase free tier)
- User profiles, settings, and report persistence contracts
- Basic widget/unit tests

## Getting started

1. Install Flutter SDK.
2. Run `flutter pub get`.
3. Run `flutter test`.
4. Run `flutter run -d android`.

Set integration credentials through your preferred secure runtime config and inject:

- `FreeAstrologyApiService(baseUrl, apiKey)`
- `FreeCloudDatabaseService(baseUrl, apiKey)`
