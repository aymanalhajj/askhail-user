//
//  AllSpecialAdaModel.swift
//  AskHail
//
//  Created by Abdullah Tarek on 24/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct AllSpecialAdsModel : Codable {
    let status : Bool?
    let code : String?
    let data : AllSpecialAdsData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(AllSpecialAdsData.self, forKey: .data)
    }

}

struct AllSpecialAdsData : Codable {
    let data : [AdsData]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([AdsData].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}

struct AdsData : Codable {
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
        adv_advertiser_id = try values.decodeIfPresent(Int.self, forKey: .adv_advertiser_id)
        adv_special_status = try values.decodeIfPresent(String.self, forKey: .adv_special_status)
        adv_promotional_image = try values.decodeIfPresent(String.self, forKey: .adv_promotional_image)
        adv_title = try values.decodeIfPresent(String.self, forKey: .adv_title)
        adv_is_favorite = try values.decodeIfPresent(Bool.self, forKey: .adv_is_favorite)
        adv_price = try values.decodeIfPresent(String.self, forKey: .adv_price)
        adv_distance = try values.decodeIfPresent(String.self, forKey: .adv_distance)
        adv_views = try values.decodeIfPresent(String.self, forKey: .adv_views)
        adv_media = try values.decodeIfPresent([Adv_media].self, forKey: .adv_media)
        adv_type = try values.decodeIfPresent(String.self, forKey: .adv_type)
    }

}

struct Pagination : Codable {
    let current_page : Int?
    let last_page : Int?
    let per_page : Int?
    let total : Int?
    let has_more_pages : Bool?

    enum CodingKeys: String, CodingKey {

        case current_page = "current_page"
        case last_page = "last_page"
        case per_page = "per_page"
        case total = "total"
        case has_more_pages = "has_more_pages"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        current_page = try values.decodeIfPresent(Int.self, forKey: .current_page)
        last_page = try values.decodeIfPresent(Int.self, forKey: .last_page)
        per_page = try values.decodeIfPresent(Int.self, forKey: .per_page)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        has_more_pages = try values.decodeIfPresent(Bool.self, forKey: .has_more_pages)
    }

}

struct Adv_media : Codable {
    let media_id : Int?
    let media_adv_id : Int?
    let media_video : String?
    let media_image : String?
    let media_video_duration : Int?

    enum CodingKeys: String, CodingKey {

        case media_id = "media_id"
        case media_adv_id = "media_adv_id"
        case media_video = "media_video"
        case media_image = "media_image"
        case media_video_duration = "media_video_duration"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        media_id = try values.decodeIfPresent(Int.self, forKey: .media_id)
        media_adv_id = try values.decodeIfPresent(Int.self, forKey: .media_adv_id)
        media_video = try values.decodeIfPresent(String.self, forKey: .media_video)
        media_image = try values.decodeIfPresent(String.self, forKey: .media_image)
        media_video_duration = try values.decodeIfPresent(Int.self, forKey: .media_video_duration)
    }

}
