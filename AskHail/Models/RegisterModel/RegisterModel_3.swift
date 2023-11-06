//
//  RegisterModel_3.swift
//  AskHail
//
//  Created by bodaa on 26/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

struct RegisterModel_3 : Codable {
    let status : Bool?
    let code : String?
    let data : LoginData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
    }

}

