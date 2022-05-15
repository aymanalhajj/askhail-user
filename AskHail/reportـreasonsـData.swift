//
//  reportـreasonsـData.swift
//  AskHail
//
//  Created by mohab mowafy on 13/05/2022.
//  Copyright © 2022 MOHAB. All rights reserved.
//

import Foundation
/// report-reasons
///
struct reportـreasonsـModel : Codable {
    let status : Bool?
    let code : String?
    let data : [reportـreasonsـData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([reportـreasonsـData].self, forKey: .data)
    }

}


struct reportـreasonsـData : Codable {
    let report_reason_id : Int?
    let report_reason_type : String?
    let report_reason_title : String?

    enum CodingKeys: String, CodingKey {

        case report_reason_id = "report_reason_id"
        case report_reason_type = "report_reason_type"
        case report_reason_title = "report_reason_title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        report_reason_id = try values.decodeIfPresent(Int.self, forKey: .report_reason_id)
        report_reason_type = try values.decodeIfPresent(String.self, forKey: .report_reason_type)
        report_reason_title = try values.decodeIfPresent(String.self, forKey: .report_reason_title)
    }

}
