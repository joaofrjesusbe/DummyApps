# DummyApps iOS — AppList + AppForm

**A small marathon of 2 days developing the requirements.**

[Requirements in Portuguese](InterviewChallenge.pdf) 

Contributors:
- Me
  
## Tech Requirements

- Xcode 16+ (Swift 6 toolchain)
- iOS 17.0+ / macOS 14.0+ SDKs
- Swift Package Manager

## Installation

- Open `DummyJson.xcworkspace` in Xcode.
- Let Xcode resolve Swift Package Manager dependencies.
- Select a scheme and a destination (Simulator or Mac Catalyst where applicable).

## Run & Build

- App (Form demo): select the `DummyForm` scheme and press Run.
- App (Products list demo): select the `DummyStore` scheme and press Run.
- Tests are available for each scheme by a shared xctestplan or by testing directly each Swift package.

## Project Structure

- `AppDomains` (Swift package)
  - `AppForm` — SwiftUI MVVM form feature.
    - Validations: email regex, digits-only number, promo code (A–Z and hyphens, 3–7, no accents), date not Monday nor future.
    - UX: keyboard-friendly (`scrollDismissesKeyboard`, `.ignoresSafeArea(.keyboard)`), focus navigation with toolbar.
  - `AppList` — Products listing + detail using MVVM.
    - Models live here: `Product`, `CatalogResponse`.
    - Services live here: `ProductsService`, `NetworkProductsService`, `MockProductsService`.
    - Repositories: `ProductsRepository` (paging + cache), `ProductsCache` (actor, JSON on disk).
    - UI Adapters: `ProductUIAdapter` to design-system `ListCellItem`.
    - DI: `ListDI` wires services via Factory container.

- `AppSDK` (Swift package shared libs)
  - `AppGroup` — Re-exports shared modules (`AppCore`, `AppDesignSystem`, `AppNetwork`).
  - `AppCore` — Core utilities and Navigation abstractions.
  - `AppDesignSystem` — Pure UI components (except RemoteImage that requires the network).
  - `AppNetwork` — Generic networking (HTTP client).

- `DummyJson` (Xcode app)
  - App entry. Launches the form and the products list demo.

## Architecture

- MVVM in both features (`View` + `ViewModel` + pure validators/services/repositories).
- Clear module boundaries: AppList owns product domain (models + services).
- DI via Factory container, resolved in `ListDI` and AppNetwork `ContainerDI`.
- Caching via `ProductsCache` actor with JSON persistence and index for paging continuity.
- Testing
  - AppForm: XCTest for validators and view-model behavior.
  - AppList: Swift Testing for `ProductListViewModel`, `ProductsCache`, `ProductsRepository`.

## Third-Party Libraries

- Factory (hmlongco/Factory)
  - Purpose: Dependency Injection container and factories.
  - Usage: `Container` extensions wire services (HTTP client, image loader, products service).

- Nuke (kean/Nuke)
  - Purpose: Image loading pipeline.
  - Usage: Integrated in `AppNetwork.ContainerDI.imageLoader` for efficient image fetching/caching.

## Notes

- Form feature is keyboard-safe and responsive across sizes.
- Product list search is diacritic-insensitive and token-based.
- AppDesignSystem only has UI generic components used by AppList. 

## Missing requirements

- Only tested for iOS iPhone
- Only support for English, although AppForm is ready for localization in PT
