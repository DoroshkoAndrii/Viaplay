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
  
  private weak var window: UIWindow?
  private let screenFactory: ScreenFactoryProtocol = ScreenFactory.shared
  private let viewModelFactory: ViewModelFactoryProtocol = ViewModelFactory.shared
  
  private let navigationController = UINavigationController()
  
  init(window: UIWindow?) {
    self.window = window
    window?.rootViewController = navigationController
    navigationController.navigationBar.prefersLargeTitles = true
    navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
    
    let controller = screenFactory.createSectionsScreen()
    navigationController.setViewControllers([controller], animated: false)
    
    window?.makeKeyAndVisible()
  }
  
  func perform(route: RouteType) {
    switch route {
    case .sections:
      let controller = screenFactory.createSectionsScreen()
      let model = viewModelFactory.createSectionsViewModel()
      controller.connectViewModel(model)
      navigationController.setViewControllers([controller], animated: false)
    case let .section(id):
      print(id)
    }
  }
  
}
