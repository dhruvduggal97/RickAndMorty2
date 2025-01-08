# Rick and Morty Explorer

A feature-rich iOS application that allows users to explore characters from the Rick and Morty universe. The app demonstrates clean architecture principles and integrates advanced iOS development techniques, including MVVM, Dependency Injection, and Coordinator patterns.

> **Note**: This project is a work in progress, with planned improvements for scalability, UI enhancements, and expanded testing coverage.

---

## Features

- Browse characters from the Rick and Morty universe using the official API.
- Search and filter characters by name and status.
- Pagination for seamless browsing of large datasets.
- Detailed view of each character, including their origin and current location.
- Multiple view types (TableView and CollectionView) with dynamic UI updates.
- Error handling and loading indicators for a smooth user experience.

---

## Technologies Used

- **Language**: Swift  
- **UI Frameworks**: UIKit  
- **Networking**: URLSession, Codable  
- **Architecture**: MVVM + Coordinator  
- **Dependency Injection**: Custom DI for improved testability  
- **Unit Testing**: XCTest  
- **Caching**: URLCache  

---

## Architecture Overview

The app follows the **MVVM (Model-View-ViewModel)** architecture, enhanced by the **Coordinator** pattern for navigation. This approach ensures:

- **Separation of Concerns**: Business logic is isolated in ViewModels, while navigation logic resides in Coordinators.  
- **Scalability**: The architecture is designed to support future features with minimal refactoring.  
- **Testability**: Dependency Injection makes components easy to unit test.  

### Key Components

1. **ViewModel**: Handles data transformations and communicates with Services.  
2. **Coordinator**: Manages navigation between screens.  
3. **Services**: Handles API calls and caching.  
4. **Data Manager**: Abstracts network and caching logic.  

---

## Setup and Installation

1. Clone the repository
2. Open the project in Xcode
3. Run the project on the simulator or a real device.
4. Ensure you have an active internet connection to fetch data from the API.


## How to Use

1. **Browse Characters**: The home screen shows a paginated list of characters.  
2. **Search**: Use the search bar at the top to filter characters by name or status.  
3. **View Details**: Tap on a character to view detailed information.  

---

## Unit Tests

The project includes unit tests to ensure code reliability and maintainability. The following components are tested:

- **ViewModels**: DataTableViewModel, DataDetailViewModel  
- **Services**: CharacterServices, ImageServices  
- **Managers**: APIDataManager, DataCacheManager  

To run tests:
1. Open the project in Xcode.  
2. Press `⌘ + U` to execute the test suite.  

---

## Future Improvements

- Add Core Data for offline persistence.  
- Implement Combine for reactive state management.  
- Improve UI with animations and custom transitions.  
- Add accessibility features for inclusive design.  
- Expand test coverage with integration tests and UI tests.
- More Features such as episode details, Location details
- Filtering Characters based on Status etc  

> While the current implementation demonstrates a clean and scalable architecture, these enhancements are part of the ongoing development
