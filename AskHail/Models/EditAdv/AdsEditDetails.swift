//
//  AdsEditDetails.swift
//  AskHail
//
//  Created by bodaa on 09/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

struct AdvEditDetailsModel : Codable {
    let status : Bool?
    let code : String?
    let data : EditDetailsData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(EditDetailsData.self, forKey: .data)
    }

}


struct EditDetailsData : Codable {
    let adv_id : Int?
    let adv_title : String?
    let adv_description : String?
    let adv_location : String?
    let adv_latitude : String?
    let adv_longitude : String?
    let adv_price : String?
    let adv_side_id : Int?
    let adv_side : Adv_side?
    let adv_region_id : Int?
    let adv_region : Adv_region?
    let adv_city_id : Int?
    let adv_city : Adv_city?
    let adv_block_id : Int?
    let adv_block : Adv_block?
    let adv_specifications : [Adv_specifications]?

    enum CodingKeys: String, CodingKey {

        case adv_id = "adv_id"
        case adv_title = "adv_title"
        case adv_description = "adv_description"
        case adv_location = "adv_location"
        case adv_latitude = "adv_latitude"
        case adv_longitude = "adv_longitude"
        case adv_price = "adv_price"
        case adv_side_id = "adv_side_id"
        case adv_side = "adv_side"
        case adv_region_id = "adv_region_id"
        case adv_region = "adv_region"
        case adv_city_id = "adv_city_id"
        case adv_city = "adv_city"
        case adv_block_id = "adv_block_id"
        case adv_block = "adv_block"
        case adv_specifications = "adv_specifications"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adv_id = try values.decodeIfPresent(Int.self, forKey: .adv_id)
        adv_title = try values.decodeIfPresent(String.self, forKey: .adv_title)
        adv_description = try values.decodeIfPresent(String.self, forKey: .adv_description)
        adv_location = try values.decodeIfPresent(String.self, forKey: .adv_location)
        adv_latitude = try values.decodeIfPresent(String.self, forKey: .adv_latitude)
        adv_longitude = try values.decodeIfPresent(String.self, forKey: .adv_longitude)
        adv_price = try values.decodeIfPresent(String.self, forKey: .adv_price)
        adv_side_id = try values.decodeIfPresent(Int.self, forKey: .adv_side_id)
        adv_side = try values.decodeIfPresent(Adv_side.self, forKey: .adv_side)
        adv_region_id = try values.decodeIfPresent(Int.self, forKey: .adv_region_id)
        adv_region = try values.decodeIfPresent(Adv_region.self, forKey: .adv_region)
        adv_city_id = try values.decodeIfPresent(Int.self, forKey: .adv_city_id)
        adv_city = try values.decodeIfPresent(Adv_city.self, forKey: .adv_city)
        adv_block_id = try values.decodeIfPresent(Int.self, forKey: .adv_block_id)
        adv_block = try values.decodeIfPresent(Adv_block.self, forKey: .adv_block)
        adv_specifications = try values.decodeIfPresent([Adv_specifications].self, forKey: .adv_specifications)
    }

}
