//
//  OrderLvL3.swift
//  AskHail
//
//  Created by bodaa on 10/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct Order_lvl_3_Model : Codable {
    let status : Bool?
    let code : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
