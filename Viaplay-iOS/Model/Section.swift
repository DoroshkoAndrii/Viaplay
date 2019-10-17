//
//  Section.swift
//  Viaplay-iOS
//
//  Created by Andrey Doroshko on 10/17/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation

struct Section {
  let id: ID; struct ID {
    let string: String
  }
  let title: String
  let description: String
  let href: String
}
