//
//  OrderSuccesAdd.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct OrderSuccesAddModel : Codable {
    let status : Bool?
    let code : String?
    let data : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }

}
