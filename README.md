# Disney Finder

Disney Finder is an iOS app built with SwiftUI that lets you search Disney characters using the Disney API.

![Disney Finder](https://github.com/user-attachments/assets/46349e9b-427f-4cac-a694-41264817792c)

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

## Project Structure

- **Data:** API, DTOs, repositories, and data sources
- **Domain:** entities, repositories, use cases, and value objects
- **Presentation:** SwiftUI screens, components, and view models

## Features

- Fetch all Disney characters
- Search characters by name
- Empty state when no character is found
- Loading skeleton state
- Local secrets setup script

## Notes

`Secrets.xcconfig` is not included in the repository.
After cloning the project, generate it locally with:
```bash
./scripts/setup-secrets.sh
```
