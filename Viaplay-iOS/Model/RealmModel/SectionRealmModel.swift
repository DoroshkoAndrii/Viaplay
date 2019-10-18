import Foundation
import RealmSwift

class SectionRealmModel: Object {
  @objc dynamic var title: String = ""
  @objc dynamic var representation: String = ""
  var sections: List<LinkRealmModel> = List<LinkRealmModel>()
  @objc dynamic var href: String = ""
  @objc dynamic var pageType: String = ""
  
  override static func primaryKey() -> String? {
    return "href"
  }
}

class LinkRealmModel: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var href: String = ""
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
