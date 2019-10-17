import Foundation

protocol ViewModelFactoryProtocol {
  func createSectionViewModel() -> SectionsViewModelProtocol
  func createSectionViewModel(href: Link.Href) -> SectionsViewModelProtocol
}

class ViewModelFactory: ViewModelFactoryProtocol {
  
  static let shared = ViewModelFactory()
  
  func createSectionViewModel() -> SectionsViewModelProtocol {
    return SectionsViewModel()
  }
  
  func createSectionViewModel(href: Link.Href) -> SectionsViewModelProtocol {
    return SectionsViewModel(href: href)
  }
}
