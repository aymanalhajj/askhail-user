//
//  AdvOnMapModel.swift
//  AskHail
//
//  Created by bodaa on 10/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
struct AdvOnMapModel : Codable {
    let status : Bool?
    let code : String?
    let data : AdvOnMapData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(AdvOnMapData.self, forKey: .data)
    }

}

struct AdvOnMapData : Codable {
    let data : [OneAdvOnMap]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([OneAdvOnMap].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}

struct OneAdvOnMap : Codable {
    let adv_id : Int?
    let adv_type : String?
    let adv_promotional_image : String?
    let adv_title : String?
    let adv_lat : String?
    let adv_lng : String?

    enum CodingKeys: String, CodingKey {

        case adv_id = "adv_id"
        case adv_type = "adv_type"
        case adv_promotional_image = "adv_promotional_image"
        case adv_title = "adv_title"
        case adv_lat = "adv_lat"
        case adv_lng = "adv_lng"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adv_id = try values.decodeIfPresent(Int.self, forKey: .adv_id)
        adv_type = try values.decodeIfPresent(String.self, forKey: .adv_type)
        adv_promotional_image = try values.decodeIfPresent(String.self, forKey: .adv_promotional_image)
        adv_title = try values.decodeIfPresent(String.self, forKey: .adv_title)
        adv_lat = try values.decodeIfPresent(String.self, forKey: .adv_lat)
        adv_lng = try values.decodeIfPresent(String.self, forKey: .adv_lng)
    }

}
