//
//  Screen.swift
//  Viaplay-iOS
//
//  Created by Andrey Doroshko on 10/17/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation
import UIKit

class Screen: UITableViewController, ScreenProtocol {
  var _viewModel: BaseViewModelProtocol?
  
  func connectViewModel(_ viewModel: BaseViewModelProtocol?) {
    _viewModel = viewModel
  }
}
