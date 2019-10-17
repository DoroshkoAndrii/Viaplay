//
//  TableHeaderView.swift
//  Viaplay-iOS
//
//  Created by Andrey Doroshko on 10/17/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation
import UIKit

class TableHeaderView: UIView {

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func setTitle(_ title: String) {
    self.titleLabel.text = title
    self.titleLabel.sizeToFit()
  }
  
  func setDescription(_ title: String) {
    self.descriptionLabel.text = title
    self.descriptionLabel.sizeToFit()
  }
}
