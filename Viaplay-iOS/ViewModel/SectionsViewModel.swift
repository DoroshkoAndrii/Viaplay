import Foundation

protocol SectionsViewModelProtocol: BaseViewModelProtocol {
  var dataSource: Section { get }
  var isLoading: Bool { get }
  func setReloadhandler(_ handler: @escaping (() -> Void))
  func selectSectionWith(href: Link.Href)
  
  func reload()
}

class SectionsViewModel: SectionsViewModelProtocol {
  
  var dataSource: Section = .init(title: "", description: "", sections: [], pageType: "") {
    didSet { self.reloadHandler() }
  }
  var isLoading: Bool = false
  var reloadHandler: (() -> Void) = {}
  
  private var href: Link.Href
  
  init(href: Link.Href) {
    self.href = href
    synchronizeLocal(href)
    synchronizeRemote(href)
  }
  
  func synchronizeLocal(_ href: Link.Href) {
    DispatchQueue.main.async {
      guard let section
        = StorageService.shared.getSection(with: href)
        else { return }
      self.dataSource = section
    }
  }
  
  func synchronizeRemote(_ href: Link.Href) {
    isLoading = true
    reloadHandler()
    NetworkService.shared.request(
      URL(string: href.string)
    ) {[weak self] result in
      self?.isLoading = false
      switch result {
      case let .failure(error):
        self?.handleError(error)
      case let .success(section):
        self?.dataSource = section
        self?.saveLocal(section)
      }
    }
  }
  
  func saveLocal(_ section: Section) {
    DispatchQueue.main.async {
      try? StorageService.shared.saveSection(section, with: self.href)
    }
  }
  
  func handleError(_ error: Error?) {
    DispatchQueue.main.async { [weak self] in
      self?.reloadHandler()
      ScreenRouter.shared.perform(
        route: .alert(error?.localizedDescription ?? "Something went wrong",
                      { self?.reload() }))
    }
  }
  
  func setReloadhandler(_ handler: @escaping (() -> Void)) {
    self.reloadHandler = handler
  }
  
  func selectSectionWith(href: Link.Href) {
    ScreenRouter.shared.perform(route: .section(href))
  }
  
  func reload() {
    synchronizeRemote(href)
  }
}
