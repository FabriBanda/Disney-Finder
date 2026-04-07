# Disney Finder

Disney Finder is an iOS app built with SwiftUI that lets you search Disney characters using the Disney API.

This project was also created as a practical introduction to a basic architecture inspired by Clean Architecture, with a clear separation between presentation, domain, and data layers.

<p align="center">
  <img width="300" alt="Disney Finder" src="https://github.com/user-attachments/assets/46349e9b-427f-4cac-a694-41264817792c" />
</p>

## Requirements

- Xcode 26
- iOS 26
- macOS with Xcode Command Line Tools installed

## Setup

Clone the repository and move into the project folder:
```bash
git clone https://github.com/FabriBanda/Disney-Finder.git
cd Disney-Finder
```

Create the local secrets file:
```bash
./scripts/setup-secrets.sh
```

If you want to use a custom API host:
```bash
API_HOST=api.disneyapi.dev ./scripts/setup-secrets.sh
```

## Run

Open the project in Xcode:
```bash
open DisneyFinder.xcodeproj
```

Then select an iPhone simulator or a physical device and run the app.

## Features

- Fetch all Disney characters
- Search characters by name
- Display empty state when no character is found
- Display loading skeletons while data is being fetched
- Handle common repository and network errors
- Support mock data source for testing the flow without relying on the API
- Local secrets setup script

## Architecture Overview

This project follows a simple architecture inspired by Clean Architecture.

The goal is to keep responsibilities separated and make the code easier to understand, maintain, and evolve.

### Layers

**Presentation**
- Contains SwiftUI screens, reusable UI components, and the `HomeViewModel`
- Responsible for rendering data and reacting to user interactions

**Domain**
- Contains business rules and app models
- Includes entities, repository contracts, use cases, errors, and value objects

**Data**
- Contains the concrete implementation of repositories
- Handles API communication, endpoints, DTO mapping, and data sources

### Main Concepts Used

**View + ViewModel**

The UI is built with SwiftUI, while `HomeViewModel` manages screen state, user actions, and error presentation.

Responsibilities include:
- Loading all characters
- Searching characters by name
- Exposing loading, success, idle, and not found states
- Handling and exposing user-friendly error messages

**Use Cases**

Use cases represent the application actions. This project includes:
- `GetAllCharactersUseCase`
- `SearchCharacterUseCase`

These use cases help keep the business logic out of the UI layer.

**Repository Pattern**

The domain defines a repository contract: `CharactersRepository`

The data layer provides the concrete implementation: `CharactersDataSourceRepositoy`

This keeps the domain independent from networking and data-fetching details.

**Data Sources**

The repository depends on a `DataSource` abstraction, which makes it possible to switch between different implementations.

Current implementations:
- `HttpDataSource`
- `MockDataSource`

This makes the project easier to test and easier to extend.

**Endpoints**

API requests are described through endpoint types. This project includes:
- `CharacterEndpoint`

This helps centralize request configuration such as path, method, and query parameters.

**DTO to Entity Mapping**

The API response is decoded into DTOs and then mapped into domain entities.

Flow:
1. API response
2. DTO decoding
3. Entity mapping
4. Delivery to the domain and presentation layers

This keeps external data models separated from internal app models.

**Dependency Injection**

Dependencies are assembled in `DependencyInjector`. It is responsible for creating and wiring:
- The selected data source
- The repository
- The use cases

This keeps object creation centralized and makes the architecture easier to follow.

**Error Handling**

The project includes a custom `RepositoryError` to represent common failures such as:
- Invalid URL
- Invalid response
- No data
- No internet connection
- Lost network connection
- HTTP status errors

This improves error consistency across layers.

## Project Structure
```
DisneyFinder
├── Presentation
│   └── UI
│       ├── Screens
│       └── Components
├── Domain
│   ├── Entities
│   ├── Errors
│   ├── Repositories
│   ├── UseCase
│   ├── Utilities
│   └── VOs
├── Data
│   ├── DTOs
│   ├── Endpoints
│   ├── Repositories
│   └── Utilities
│       └── DataSources
└── DisneyFinderApp.swift
```
## Flow Diagram
```mermaid
flowchart LR
    V["View"] --> VM["ViewModel"]
    VM --> UC["Use Case"]
    UC --> R["Repository"]
    R --> DS["Data Source"]
    DS --> EP["Endpoint"]
    EP --> API["Disney API"]

    API --> DTO["DTO"]
    DTO --> E["Entity"]
    E --> R2["Repository"]
    R2 --> UC2["Use Case"]
    UC2 --> VM2["ViewModel"]
    VM2 --> V

    DS -. Optional .-> M["Mock Data Source"]
    M -. Mock Response .-> DTO

    style V fill:#424242,color:#fff,stroke:#0F172A
    style VM fill:#1D4ED8,color:#fff,stroke:#1D4ED8
    style UC fill:#2563EB,color:#fff,stroke:#2563EB
    style R fill:#0EA5E9,color:#fff,stroke:#0EA5E9
    style DS fill:#06B6D4,color:#fff,stroke:#06B6D4
    style EP fill:#14B8A6,color:#fff,stroke:#14B8A6
    style API fill:#10B981,color:#fff,stroke:#10B981
    style DTO fill:#F59E0B,color:#fff,stroke:#F59E0B
    style E fill:#F97316,color:#fff,stroke:#F97316
    style R2 fill:#0EA5E9,color:#fff,stroke:#0EA5E9
    style UC2 fill:#2563EB,color:#fff,stroke:#2563EB
    style VM2 fill:#1D4ED8,color:#fff,stroke:#1D4ED8
    style M fill:#EF4444,color:#fff,stroke:#EF4444
