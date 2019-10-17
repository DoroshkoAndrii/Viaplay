import Foundation

protocol ScreenFactoryProtocol {
  func createSectionsScreen() -> SectionsTableViewController
}

class ScreenFactory: ScreenFactoryProtocol {
  
  static let shared = ScreenFactory()
  
  func createSectionsScreen() -> SectionsTableViewController {
    return SectionsTableViewController()
  }
}
