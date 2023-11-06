// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let myAdsModel = try? newJSONDecoder().decode(MyAdsModel.self, from: jsonData)

import Foundation

struct MyAdsModel : Codable {
    let status : Bool?
    let code : String?
    let data : MyAdsData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(MyAdsData.self, forKey: .data)
    }

}

struct MyAdsData : Codable {
    let advertisements_count : String?
    let data : [AdsData]?
    let pagination : Pagination?
    let if_have_blocked_advertisements : Bool?

    enum CodingKeys: String, CodingKey {

        case advertisements_count = "advertisements_count"
        case data = "data"
        case pagination = "pagination"
        case if_have_blocked_advertisements = "if_have_blocked_advertisements"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertisements_count = try values.decodeIfPresent(String.self, forKey: .advertisements_count)
        data = try values.decodeIfPresent([AdsData].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
        if_have_blocked_advertisements = try values.decodeIfPresent(Bool.self, forKey: .if_have_blocked_advertisements)
    }

}
