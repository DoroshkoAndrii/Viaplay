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
    navigationController.navigationBar.backItem?.title = "Viaplay"
  }
  
  func setWindow(window: UIWindow?) {
    self.window = window
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
  
  func perform(route: RouteType) {
    switch route {
    case let .section(href):
      let controller = screenFactory.createSectionScreen()
      let model = viewModelFactory.createSectionViewModel(href: href)
      controller.connectViewModel(model)
      navigationController.pushViewController(controller, animated: true)
    case let .alert(message, tryAgain):
      let alertController = UIAlertController(title: "Sorry",
                                              message: message,
                                              preferredStyle: .alert)
      
      let tryAgain = UIAlertAction(title: "Try Again",
                                   style: .default) { _ in tryAgain()}
      
      let cancel = UIAlertAction(title: "Cancel",
                                 style: .cancel) { _ in alertController.dismiss(animated: true, completion: nil) }
                                    
      
      alertController.addAction(tryAgain)
      alertController.addAction(cancel)
      navigationController.present(alertController, animated: true, completion: nil)

    }
  }
}
