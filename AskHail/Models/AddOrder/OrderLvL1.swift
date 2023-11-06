//
//  OrderLvL1.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct Order_lvl_1_Model : Codable {
    let status : Bool?
    let code : String?
    let message : String?
    let data : Order_lvl_1_Data?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(Order_lvl_1_Data.self, forKey: .data)
    }

}

struct Order_lvl_1_Data : Codable {
    let order_id : Int?
    let next_level : Int?

    enum CodingKeys: String, CodingKey {

        case order_id = "order_id"
        case next_level = "next_level"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
        next_level = try values.decodeIfPresent(Int.self, forKey: .next_level)
    }

}
