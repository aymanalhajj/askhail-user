//
//  RegionModel.swift
//  AskHail
//
//  Created by mohab mowafy on 02/02/2022.
//  Copyright © 2022 MOHAB. All rights reserved.
//

import Foundation
struct REgionModel : Codable {
    let status : Bool?
    let code : String?
    let data : [RegionData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([RegionData].self, forKey: .data)
    }

}

struct RegionData : Codable {
    let region_id : Int?
    let region_name : String?

    enum CodingKeys: String, CodingKey {

        case region_id = "region_id"
        case region_name = "region_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        region_id = try values.decodeIfPresent(Int.self, forKey: .region_id)
        region_name = try values.decodeIfPresent(String.self, forKey: .region_name)
    }

}
