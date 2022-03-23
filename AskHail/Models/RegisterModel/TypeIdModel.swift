//
//  TypeIdModel.swift
//  AskHail
//
//  Created by mohab mowafy on 23/03/2022.
//  Copyright © 2022 MOHAB. All rights reserved.
//

import Foundation

struct typeIdModel : Codable {
    let status : Bool?
    let code : String?
    let data : [typeIdData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([typeIdData].self, forKey: .data)
    }

}


struct typeIdData : Codable {
    let type_id : Int?
    let type_name : String?

    enum CodingKeys: String, CodingKey {

        case type_id = "type_id"
        case type_name = "type_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type_id = try values.decodeIfPresent(Int.self, forKey: .type_id)
        type_name = try values.decodeIfPresent(String.self, forKey: .type_name)
    }

}
