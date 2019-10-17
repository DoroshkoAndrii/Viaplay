import Foundation

protocol SectionsViewModelProtocol: BaseViewModelProtocol {
  var sections: Sections { get }
  var isLoading: Bool { get }
  func setReloadhandler(_ handler: @escaping (() -> Void))
}

class SectionsViewModel: SectionsViewModelProtocol {
  
  var sections: Sections = .init(title: "", description: "", sections: []) {
    didSet { self.reloadHandler() }
  }
  var isLoading: Bool = false
  
  var reloadHandler: (() -> Void) = {}
  
  init() {
    synchronize()
  }
  
  func synchronize() {
    isLoading = true
    NetworkService.shared.requestSections {[weak self] result in
      self?.isLoading = false
      switch result {
      case let .failure(error):
        self?.handleError(error)
      case let .success(sections):
        self?.sections = sections
      }
    }
  }
  
  func handleError(_ error: Error?) {
    print(error?.localizedDescription)
  }
  
  func setReloadhandler(_ handler: @escaping (() -> Void)) {
    self.reloadHandler = handler
  }
}
