//
//  ScreenProtocol.swift
//  Viaplay-iOS
//
//  Created by Andrey Doroshko on 10/17/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation

protocol ScreenProtocol {
  var _viewModel: BaseViewModelProtocol? { get }
  
  func connectViewModel(_ viewModel: BaseViewModelProtocol?)
}
