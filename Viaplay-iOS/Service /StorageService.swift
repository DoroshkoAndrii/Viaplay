import Foundation
import RealmSwift

class StorageService {
  private let realm = try! Realm()
  private var token: NotificationToken?
  
  static let shared = StorageService()
 
  func saveSection(_ section: Section, with href: Link.Href) throws {
    do {
      try self.realm.write {
        self.realm.add(SectionRealmModel.fromDomain(section, with: href), update: .all)
      }
    } catch let error {
      throw error
    }
  }
  
  func getSection(with href: Link.Href) -> Section? {
    guard let realmSection
      = realm.object(ofType: SectionRealmModel.self, forPrimaryKey: href.string)
      else { return nil }
    return Section.fromLocal(model: realmSection)
  }
}

extension SectionRealmModel {
  static func fromDomain(_ section: Section, with href: Link.Href) -> SectionRealmModel {
    let model = SectionRealmModel()
    model.title = section.title
    model.representation = section.description
    model.sections.append(objectsIn: section.links.map(LinkRealmModel.fromDomain))
    model.href = href.string
    model.pageType = section.pageType
    return model
  }
}

extension LinkRealmModel {
  static func fromDomain(_ link: Link) -> LinkRealmModel {
    let model = LinkRealmModel()
    model.title = link.title
    model.id = link.id
    model.href = link.href.string
    return model
  }
}

private extension Section {
  static func fromLocal(model: SectionRealmModel) -> Section {
    return Section(title: model.title,
                   description: model.representation,
                   links: model.sections.map(Link.fromLocal),
                   pageType: model.pageType)
  }
}

private extension Link {
  static func fromLocal(model: LinkRealmModel) -> Link {
    return Link(id: model.id,
                title: model.title,
                href: .init(string: model.href))
  }
}


