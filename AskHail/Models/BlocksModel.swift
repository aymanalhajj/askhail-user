//
//  BlocksModel.swift
//  AskHail
//
//  Created by bodaa on 27/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct BlocksModel : Codable {
    let status : Bool?
    let code : String?
    let data : [BlocksData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([BlocksData].self, forKey: .data)
    }

}

struct BlocksData : Codable {
    let block_id : String?
    let block_city : Block_city?
    let block_name : String?
    let admin_block_name : String?

    enum CodingKeys: String, CodingKey {

        case block_id = "block_id"
        case block_city = "block_city"
        case block_name = "block_name"
        case admin_block_name = "admin_block_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        block_id = try values.decodeIfPresent(String.self, forKey: .block_id)
        block_city = try values.decodeIfPresent(Block_city.self, forKey: .block_city)
        block_name = try values.decodeIfPresent(String.self, forKey: .block_name)
        admin_block_name = try values.decodeIfPresent(String.self, forKey: .admin_block_name)
    }

}
