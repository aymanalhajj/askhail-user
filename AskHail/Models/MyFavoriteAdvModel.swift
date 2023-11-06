//
//  MyFavoriteAdvModel.swift
//  AskHail
//
//  Created by bodaa on 13/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

struct MyFavoriteAdvModel : Codable {
    let status : Bool?
    let code : String?
    let data : [MyFavoriteAdvData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([MyFavoriteAdvData].self, forKey: .data)
    }

}

struct MyFavoriteAdvData : Codable {
    let adv_id : Int?
    let adv_special_status : String?
    let adv_promotional_image : String?
    let adv_title : String?
    var adv_is_favorite : Bool?
    let adv_price : String?
    let adv_distance : String?
    let adv_views : String?
    let adv_media : [Adv_media]?
    let adv_advertiser_id : Int?
    let adv_available_status : String?
    let adv_available_custom_status : String?
    let adv_total_rate : String?
    let adv_type : String?

    enum CodingKeys: String, CodingKey {

        case adv_id = "adv_id"
        case adv_special_status = "adv_special_status"
        case adv_promotional_image = "adv_promotional_image"
        case adv_title = "adv_title"
        case adv_is_favorite = "adv_is_favorite"
        case adv_price = "adv_price"
        case adv_distance = "adv_distance"
        case adv_views = "adv_views"
        case adv_media = "adv_media"
        case adv_advertiser_id = "adv_advertiser_id"
        case adv_available_status = "adv_available_status"
        case adv_available_custom_status = "adv_available_custom_status"
        case adv_total_rate = "adv_total_rate"
        case adv_type = "adv_type"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adv_id = try values.decodeIfPresent(Int.self, forKey: .adv_id)
        adv_special_status = try values.decodeIfPresent(String.self, forKey: .adv_special_status)
        adv_promotional_image = try values.decodeIfPresent(String.self, forKey: .adv_promotional_image)
        adv_title = try values.decodeIfPresent(String.self, forKey: .adv_title)
        adv_is_favorite = try values.decodeIfPresent(Bool.self, forKey: .adv_is_favorite)
        adv_price = try values.decodeIfPresent(String.self, forKey: .adv_price)
        adv_distance = try values.decodeIfPresent(String.self, forKey: .adv_distance)
        adv_views = try values.decodeIfPresent(String.self, forKey: .adv_views)
        adv_media = try values.decodeIfPresent([Adv_media].self, forKey: .adv_media)
        adv_advertiser_id = try values.decodeIfPresent(Int.self, forKey: .adv_advertiser_id)
        adv_available_status = try values.decodeIfPresent(String.self, forKey: .adv_available_status)
        adv_available_custom_status = try values.decodeIfPresent(String.self, forKey: .adv_available_custom_status)
        adv_total_rate = try values.decodeIfPresent(String.self, forKey: .adv_total_rate)
        adv_type = try values.decodeIfPresent(String.self, forKey: .adv_type)
        
    }

}
