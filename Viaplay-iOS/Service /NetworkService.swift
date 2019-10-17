//
//  NetworkService.swift
//  Viaplay-iOS
//
//  Created by Andrey Doroshko on 10/17/19.
//  Copyright © 2019 Andrey Doroshko. All rights reserved.
//

import Foundation

enum NetworkError: Error {
  case error(Error?)
  case noURL(String)
  case parsingError
}

class NetworkService {
  enum Path: String {
    case serier, film, sport3, sport2, sport, barn
  }
  
  let baseURL = URL(string: "https://content.viaplay.se/ios-se")
  static var shared = NetworkService()
//
//  func request(_ path: Path) -> Section?  {
//    guard let url = baseURL?.appendingPathComponent(path.rawValue)
//      else { return nil }
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//
//    URLSession.shared.dataTask(with: request) { (data, response, error) in
//      if let data = data {
//        let section = try? JSONDecoder().decode(NetworkSection.self, from: data)
//
//      }
//    }.resume()
//  }
  
  func requestSections(completion: @escaping (Result<Sections, NetworkError>) -> Void) {
    guard let url = baseURL
      else { completion(.failure(.noURL("URL not found"))); return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard error == nil else { completion(.failure(.error(error))); return }
      if let data = data {
        guard let sections = try? JSONDecoder().decode(NetworkSections.self, from: data)
          else { completion(.failure(.parsingError)); return }
        completion(.success(Sections.fromDTO(sections)))
      }}.resume()
  }
  
  struct NetworkSections: Decodable {
    let title: String
    let description: String
    let _links: Links; struct Links: Decodable {
      let sections: [NetworkSection]
      private enum CodingKeys: String, CodingKey {
        case sections = "viaplay:sections"
      }
      
      init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
        sections = try container.decode([NetworkSection].self,
                                        forKey: .sections)
      }
    }
  }
  
  struct NetworkSection: Codable {
    let id: String
    let title: String
    let href: String
  }
}

extension Sections {
  static func fromDTO(_ dto: NetworkService.NetworkSections) -> Sections {
    return Sections(title: dto.title,
                    description: dto.description,
                    sections: dto._links.sections.map(Section.fromDTO))
  }
}

extension Section {
  static func fromDTO(_ dto: NetworkService.NetworkSection) -> Section {
    return Section(id: .init(string: dto.id),
                   title: dto.title,
                   description: "",
                   href: dto.href)
  }
}



