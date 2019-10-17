import Foundation
import UIKit

class SectionsTableViewController: Screen {
  
  var viewModel: SectionsViewModelProtocol? {
    guard let _viewModel = _viewModel as? SectionsViewModelProtocol
      else { fatalError("viewModel is not SectionsViewModelProtocol") }
    _viewModel.setReloadhandler { [weak self] in DispatchQueue.main.async { self?.reloadData() } }
    return _viewModel
  }
  
  lazy var tableHeader
    = UINib.init(nibName: "TableHeaderView", bundle: Bundle.main)
      .instantiate(withOwner: self, options: nil).first as? TableHeaderView
  
  override func loadView() {
    tableView = UITableView(frame: .zero, style: .grouped)
    tableView.tableHeaderView = tableHeader
    tableView.separatorStyle = .none
  }
  
  func reloadData() {
    title = "Viaplay - Streama"
    tableHeader?.setTitle(viewModel?.sections.title ?? "")
    tableHeader?.setDescription(viewModel?.sections.description ?? "")

    tableView.reloadData()
    tableView.layoutTableHeaderView()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.sections.sections.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell
      = tableView.dequeueReusableCell(withIdentifier: "section")
        ?? UITableViewCell(style: .default, reuseIdentifier: "section")
    
    cell.textLabel?.text = viewModel?.sections.sections[indexPath.item].title
    cell.accessoryType = .disclosureIndicator
    return cell
  }
}

extension UITableView {
  func layoutTableHeaderView() {
    guard let headerView = self.tableHeaderView else { return }
    headerView.translatesAutoresizingMaskIntoConstraints = false
    
    let headerWidth = headerView.bounds.size.width
    let temporaryWidthConstraints
      = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]",
                                       options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)),
                                       metrics: ["width": headerWidth],
                                       views: ["headerView": headerView])
    
    headerView.addConstraints(temporaryWidthConstraints)
    
    headerView.setNeedsLayout()
    headerView.layoutIfNeeded()
    
    let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    let height = headerSize.height
    var frame = headerView.frame
    
    frame.size.height = height
    headerView.frame = frame
    
    self.tableHeaderView = headerView
    
    headerView.removeConstraints(temporaryWidthConstraints)
    headerView.translatesAutoresizingMaskIntoConstraints = true
  }
}
