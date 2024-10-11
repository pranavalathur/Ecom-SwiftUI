import Foundation

struct HomeScreenResModel : Codable {
	let type : String?
	let title : String?
	let contents : [Contents]?
	let id : String?

	enum CodingKeys: String, CodingKey {

		case type = "type"
		case title = "title"
		case contents = "contents"
		case id = "id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		contents = try values.decodeIfPresent([Contents].self, forKey: .contents)
		id = try values.decodeIfPresent(String.self, forKey: .id)
	}

}
struct Contents : Codable {
    let title : String?
    let image_url : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case image_url = "image_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
    }

}
