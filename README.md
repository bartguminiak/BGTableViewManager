# BGTableViewManager

A lightweight Swift library designed to simplify `UITableView` data source and delegate management.

BGTableViewManager separates table view management from view controllers by introducing a dedicated manager, section abstractions and protocol-based row definitions.

Originally developed in **2015–2016**, the project reflects an earlier stage of Swift and UIKit development. It is preserved as a historical engineering project rather than actively maintained as a modern iOS dependency.

## Overview

The library provides an abstraction layer around `UITableView`, moving repetitive data source and delegate responsibilities into a reusable `TableViewManager`.

Instead of implementing table view data handling directly in a view controller, developers can describe the table using sections and objects conforming to dedicated protocols.

### Key Features

- **Centralized table view management** – a dedicated `TableViewManager` implements `UITableViewDataSource` and `UITableViewDelegate`.
- **Section-based composition** – tables are organized into `TableViewSection` objects containing headers, rows and optional footers.
- **Protocol-oriented design** – custom cells and header/footer views are integrated through lightweight protocols rather than concrete implementation dependencies.
- **Dynamic content management** – supports adding, removing, replacing and updating sections and individual rows.
- **Animated updates** – uses native `UITableView` batch update APIs to animate section and row changes.
- **Cell reuse** – registers cell and header/footer classes and uses UIKit's reuse mechanism.
- **Configurable row heights** – supports explicit and estimated heights.
- **Interaction handling** – provides hooks for row selection and cell display events.
- **Scroll event forwarding** – allows selected scroll view delegate callbacks to be forwarded to an external delegate.

## Architecture

The library consists of a few focused components:

| Component | Responsibility |
|---|---|
| `TableViewManager` | Implements table view data source and delegate methods; manages content updates and cell registration. |
| `TableViewSection` | Represents a table section with an optional header, rows and footer. |
| `TableViewCellRowManageable` | Defines the interface for row models responsible for cell configuration and interaction callbacks. |
| `TableViewHeaderFooterManageable` | Defines the interface for reusable section header and footer views. |
| `TableViewManagerDelegate` | Exposes selected scroll view delegate callbacks. |

### Design Principles

**Separation of concerns**

Table view data handling is extracted from view controllers, keeping presentation controllers less coupled to the mechanics of table view management.

**Protocol-oriented composition**

Rows and supplementary views conform to dedicated protocols, allowing different cell and view implementations to work with the same manager.

**Encapsulation of update operations**

Common table view operations are exposed through a single API, reducing the need to manually coordinate data source changes with UIKit update calls.

## Example Usage

Create a manager and attach it to a table view:

```swift
let tableViewManager = TableViewManager()
tableViewManager.attachDelegates(inTableView: tableView)
```

Create a section using objects conforming to `TableViewCellRowManageable`:

```swift
let section = TableViewSection(
    cellRows: cellRows
)
```

Add it to the table:

```swift
tableViewManager.addSection(
    section: section,
    inTableView: tableView
)
```

The manager takes care of registering the required cell classes and providing the table view data source and delegate implementation.

Sections and rows can subsequently be added, removed, replaced or reloaded through the manager's API.

## What Could Be Improved?

The project was created in 2015–2016, and its implementation reflects the Swift and UIKit conventions of that period.

Looking at it from today's engineering perspective, several areas could be improved:

- **Modern Swift** – migrate from Swift 2 syntax and older APIs to a current Swift version, with stronger type safety and modern language features.
- **Type-safe cell configuration** – replace `AnyObject`-based cell configuration with generic abstractions and compile-time type checking.
- **Safer update handling** – improve index management and make section and row updates more robust, including edge cases in batch operations.
- **Complete supplementary view support** – implement the missing footer-related delegate methods.
- **Error handling** – avoid force unwraps and unnecessary `fatalError` calls for valid states, such as sections without headers.
- **Testing** – introduce unit tests for section management, row operations, cell configuration and update behavior.
- **Modern table view APIs** – consider integrating `UITableViewDiffableDataSource` and identifier-based data management.
- **Distribution** – add Swift Package Manager support and modernize dependency management.
- **Documentation and examples** – provide a sample application and more comprehensive API documentation.

These are potential improvements rather than features of the current implementation.

## Project Status

**Historical project – not actively maintained.**

The code was originally developed between 2015 and 2016, with the last repository changes dating back to April 2016.

The decision is to preserve the original implementation rather than invest in a full migration to modern Swift and UIKit APIs.

A modernization effort would involve more than updating syntax: it would require reconsidering parts of the API, type system, update mechanisms, testing strategy and distribution model. Given the project's original scope and age, a modern implementation would be better approached as a separate project rather than an incremental update.

This repository therefore serves as a snapshot of an earlier engineering project and demonstrates the approach taken to designing reusable UIKit abstractions at that time.

## Requirements

- Swift 2
- UIKit
- iOS 8.0 or later (as specified in the original CocoaPods specification)

## License

MIT
