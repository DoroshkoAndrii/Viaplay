import Foundation

protocol SectionsViewModelProtocol: BaseViewModelProtocol {
  var dataSource: Section { get }
  var isLoading: Bool { get }
  func setReloadhandler(_ handler: @escaping (() -> Void))
  func selectSectionWith(href: Link.Href)
  
  func reload()
}

class SectionsViewModel: SectionsViewModelProtocol {
  
  var dataSource: Section = .init(title: "", description: "", sections: []) {
    didSet { self.reloadHandler() }
  }
  var isLoading: Bool = false
  var reloadHandler: (() -> Void) = {}
  
  private var href: Link.Href?
  
  init() {
    synchronize()
  }
  
  init(href: Link.Href) {
    self.href = href
    synchronize(href)
  }
  
  func synchronize() {
    isLoading = true
    NetworkService.shared.requestSections {[weak self] result in
      self?.isLoading = false
      switch result {
      case let .failure(error):
        self?.handleError(error)
      case let .success(sections):
        self?.dataSource = sections
      }
    }
  }
  
  func synchronize(_ href: Link.Href) {
    isLoading = true
    NetworkService.shared.request(
      URL(string: href.string)
    ) {[weak self] result in
      self?.isLoading = false
      switch result {
      case let .failure(error):
        self?.handleError(error)
      case let .success(sections):
        self?.dataSource = sections
      }
    }
  }
  
  func handleError(_ error: Error?) {
    print(error?.localizedDescription)
  }
  
  func setReloadhandler(_ handler: @escaping (() -> Void)) {
    self.reloadHandler = handler
  }
  
  func selectSectionWith(href: Link.Href) {
    ScreenRouter.shared.perform(route: .section(href))
  }
  
  func reload() {
    guard let href = self.href else { return synchronize() }
    synchronize(href)
  }
}
