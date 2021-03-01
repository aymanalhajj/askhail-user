//
//  AdsMediaModel.swift
//  AskHail
//
//  Created by Mohab on 12/25/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
import Foundation
struct AdsMedia_Model : Codable {
    let status : Bool?
    let code : String?
    let data : AdsMediaData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(AdsMediaData.self, forKey: .data)
    }

}

struct AdsMediaData : Codable {
    let adv_id : Int?
    let adv_promotional_image : String?
    let adv_media : [Adv_media]?

    enum CodingKeys: String, CodingKey {

        case adv_id = "adv_id"
        case adv_promotional_image = "adv_promotional_image"
        case adv_media = "adv_media"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adv_id = try values.decodeIfPresent(Int.self, forKey: .adv_id)
        adv_promotional_image = try values.decodeIfPresent(String.self, forKey: .adv_promotional_image)
        adv_media = try values.decodeIfPresent([Adv_media].self, forKey: .adv_media)
    }

}


