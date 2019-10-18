import Foundation

protocol ViewModelFactoryProtocol {
  func createSectionViewModel(href: Link.Href) -> SectionsViewModelProtocol
}

class ViewModelFactory: ViewModelFactoryProtocol {
  
  static let shared = ViewModelFactory()
  
  func createSectionViewModel(href: Link.Href) -> SectionsViewModelProtocol {
    return SectionsViewModel(href: href)
  }
}
