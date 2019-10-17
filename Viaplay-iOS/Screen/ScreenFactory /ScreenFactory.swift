import Foundation

protocol ScreenFactoryProtocol {
  func createSectionScreen() -> SectionsTableViewController
}

class ScreenFactory: ScreenFactoryProtocol {
  
  static let shared = ScreenFactory()
  
  func createSectionScreen() -> SectionsTableViewController {
    return SectionsTableViewController()
  }
}
