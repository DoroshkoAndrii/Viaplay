//
//  ScreenRouter.swift
//  Viaplay-iOS
//
//  Created by Andrey Doroshko on 10/17/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation
import UIKit

final class ScreenRouter {
  
  static let shared = ScreenRouter()
  
  private weak var window: UIWindow?
  private let screenFactory: ScreenFactoryProtocol = ScreenFactory.shared
  private let viewModelFactory: ViewModelFactoryProtocol = ViewModelFactory.shared
  
  private let navigationController = UINavigationController()
  
  init() {
    navigationController.navigationBar.prefersLargeTitles = true
    navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
    
    let controller = screenFactory.createSectionScreen()
    navigationController.setViewControllers([controller], animated: false)
  }
  
  func setWindow(window: UIWindow?) {
    self.window = window
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
  
  func perform(route: RouteType) {
    switch route {
    case .sections:
      let controller = screenFactory.createSectionScreen()
      let model = viewModelFactory.createSectionViewModel()
      controller.connectViewModel(model)
      navigationController.setViewControllers([controller], animated: false)
    case let .section(href):
      let controller = screenFactory.createSectionScreen()
      let model = viewModelFactory.createSectionViewModel(href: href)
      controller.connectViewModel(model)
      navigationController.setViewControllers([controller], animated: false)
    }
  }
  
}
