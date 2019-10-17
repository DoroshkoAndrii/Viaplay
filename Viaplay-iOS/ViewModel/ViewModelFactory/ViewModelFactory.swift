import Foundation

protocol ViewModelFactoryProtocol {
  func createSectionsViewModel() -> SectionsViewModelProtocol
}

class ViewModelFactory: ViewModelFactoryProtocol {
  
  static let shared = ViewModelFactory()
  
  func createSectionsViewModel() -> SectionsViewModelProtocol {
    return SectionsViewModel()
  }
}
