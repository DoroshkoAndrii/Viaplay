//  Copyright © 2019 Andrey Doroshko. All rights reserved.
import Foundation

enum NetworkError: Error {
  case error(Error?)
  case noURL(String)
  case parsingError
}

class NetworkService {
  static var shared = NetworkService()
  
  func request(_ url: URL?, completion: @escaping (Result<Section, NetworkError>) -> Void) {
    guard let url = url
      else { completion(.failure(.noURL("URL not found"))); return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard error == nil else { completion(.failure(.error(error))); return }
      if let data = data {
        guard let sections = try? JSONDecoder().decode(NetworkSection.self, from: data)
          else { completion(.failure(.parsingError)); return }
        completion(.success(Section.fromDTO(sections)))
      }}.resume()
  }
  
  struct NetworkSection: Decodable {
    let title: String
    let description: String
    let pageType: String
    let _links: Links; struct Links: Decodable {
      let links: [NetworkLink]
      private enum CodingKeys: String, CodingKey {
        case sections = "viaplay:sections"
      }
      
      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        links = try container.decode([NetworkLink].self,
                                     forKey: .sections)
      }
    }
  }
  
  struct NetworkLink: Codable {
    let id: String
    let title: String
    let href: String
  }
}

private extension Section {
  static func fromDTO(_ dto: NetworkService.NetworkSection) -> Section {
    return Section(title: dto.title,
                   description: dto.description,
                   sections: dto._links.links.map(Link.fromDTO),
                   pageType: dto.pageType)
  }
}

private extension Link {
  static func fromDTO(_ dto: NetworkService.NetworkLink) -> Link {
    return Link(id: dto.id,
                title: dto.title,
                href: .init(string: .init(dto.href.dropLast(6)))
    )
  }
}



