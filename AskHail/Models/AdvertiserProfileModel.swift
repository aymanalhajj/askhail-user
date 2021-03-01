//
//  AdvertiserProfileModel.swift
//  AskHailBusiness
//
//  Created by bodaa on 15/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation

//MARK: User Profile Model


struct AdvertiserProfileModel : Codable {
    let status : Bool?
    let code : String?
    let data : AdvertiserProfileData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(AdvertiserProfileData.self, forKey: .data)
    }

}

struct AdvertiserProfileData : Codable {
    let advertisements_count : String?
    let advertiser_info : Advertiser_info?
    let data : [AdvData]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case advertisements_count = "advertisements_count"
        case advertiser_info = "advertiser_info"
        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertisements_count = try values.decodeIfPresent(String.self, forKey: .advertisements_count)
        advertiser_info = try values.decodeIfPresent(Advertiser_info.self, forKey: .advertiser_info)
        data = try values.decodeIfPresent([AdvData].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}

struct Advertiser_info : Codable {
    let advertiser_id : Int?
    let advertiser_mobile : String?
    let advertiser_whatsapp : String?

    enum CodingKeys: String, CodingKey {

        case advertiser_id = "advertiser_id"
        case advertiser_mobile = "advertiser_mobile"
        case advertiser_whatsapp = "advertiser_whatsapp"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertiser_id = try values.decodeIfPresent(Int.self, forKey: .advertiser_id)
        advertiser_mobile = try values.decodeIfPresent(String.self, forKey: .advertiser_mobile)
        advertiser_whatsapp = try values.decodeIfPresent(String.self, forKey: .advertiser_whatsapp)
    }

}

struct AdvData : Codable {
    let adv_id : Int?
    let adv_type : String?
    let adv_advertiser_id : Int?
    let adv_special_status : String?
    let adv_promotional_image : String?
    let adv_title : String?
    var adv_is_favorite : Bool?
    let adv_price : String?
    let adv_distance : String?
    let adv_views : String?
    let adv_media : [Adv_media]?

    enum CodingKeys: String, CodingKey {

        case adv_id = "adv_id"
        case adv_type = "adv_type"
        case adv_advertiser_id = "adv_advertiser_id"
        case adv_special_status = "adv_special_status"
        case adv_promotional_image = "adv_promotional_image"
        case adv_title = "adv_title"
        case adv_is_favorite = "adv_is_favorite"
        case adv_price = "adv_price"
        case adv_distance = "adv_distance"
        case adv_views = "adv_views"
        case adv_media = "adv_media"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adv_id = try values.decodeIfPresent(Int.self, forKey: .adv_id)
        adv_type = try values.decodeIfPresent(String.self, forKey: .adv_type)
        adv_advertiser_id = try values.decodeIfPresent(Int.self, forKey: .adv_advertiser_id)
        adv_special_status = try values.decodeIfPresent(String.self, forKey: .adv_special_status)
        adv_promotional_image = try values.decodeIfPresent(String.self, forKey: .adv_promotional_image)
        adv_title = try values.decodeIfPresent(String.self, forKey: .adv_title)
        adv_is_favorite = try values.decodeIfPresent(Bool.self, forKey: .adv_is_favorite)
        adv_price = try values.decodeIfPresent(String.self, forKey: .adv_price)
        adv_distance = try values.decodeIfPresent(String.self, forKey: .adv_distance)
        adv_views = try values.decodeIfPresent(String.self, forKey: .adv_views)
        adv_media = try values.decodeIfPresent([Adv_media].self, forKey: .adv_media)
    }

}
