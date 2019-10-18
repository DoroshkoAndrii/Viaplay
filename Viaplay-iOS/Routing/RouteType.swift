//
//  RouteType.swift
//  Viaplay-iOS
//
//  Created by Andrey Doroshko on 10/17/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation

enum RouteType {
  case section(Link.Href)
  case alert(String, () -> Void)
}
