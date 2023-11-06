//
//  HomeModel.swift
//  AskHail
//
//  Created by Abdullah Tarek on 23/11/2020.
//  Copyright © 2020 Abdullah Tarek. All rights reserved.
//

import Foundation
struct HomeModel : Codable {
    let status : Bool?
    let code : String?
    let data : HomeData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(HomeData.self, forKey: .data)
    }

}

struct HomeData : Codable {
    let notifications_count : String?
    let special_advertisements : [Special_advertisements]?
    let real_estate : [Real_estate]?
    let business : [Business]?
    let famous : [Famous]?

    enum CodingKeys: String, CodingKey {

        case notifications_count = "notifications_count"
        case special_advertisements = "special_advertisements"
        case real_estate = "real_estate"
        case business = "business"
        case famous = "famous"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        notifications_count = try values.decodeIfPresent(String.self, forKey: .notifications_count)
        special_advertisements = try values.decodeIfPresent([Special_advertisements].self, forKey: .special_advertisements)
        real_estate = try values.decodeIfPresent([Real_estate].self, forKey: .real_estate)
        business = try values.decodeIfPresent([Business].self, forKey: .business)
        famous = try values.decodeIfPresent([Famous].self, forKey: .famous)
    }

}


struct Special_advertisements : Codable {
    let adv_id : Int?
    let adv_type: String?
    let adv_special_status : String?
    let adv_promotional_image : String?
    let adv_title : String?
    var adv_is_favorite : Bool?
    let adv_price : String?
    let adv_distance : String?
    let adv_views : String?
    let adv_advertiser_id : Int?
    
    enum CodingKeys: String, CodingKey {

        case adv_id = "adv_id"
        case adv_type = "adv_type"
        case adv_special_status = "adv_special_status"
        case adv_promotional_image = "adv_promotional_image"
        case adv_title = "adv_title"
        case adv_is_favorite = "adv_is_favorite"
        case adv_price = "adv_price"
        case adv_distance = "adv_distance"
        case adv_views = "adv_views"
        case adv_advertiser_id = "adv_advertiser_id"
        
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
        adv_type = try values.decodeIfPresent(String.self, forKey: .adv_type)
        adv_advertiser_id = try values.decodeIfPresent(Int.self, forKey: .adv_advertiser_id)
    }

}

struct Real_estate : Codable {
    let section_id : Int?
    let section_name : String?
    let section_image : String?
    let section_type : String?
    let section_business_type : String?

    enum CodingKeys: String, CodingKey {

        case section_id = "section_id"
        case section_name = "section_name"
        case section_image = "section_image"
        case section_type = "section_type"
        case section_business_type = "section_business_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        section_id = try values.decodeIfPresent(Int.self, forKey: .section_id)
        section_name = try values.decodeIfPresent(String.self, forKey: .section_name)
        section_image = try values.decodeIfPresent(String.self, forKey: .section_image)
        section_type = try values.decodeIfPresent(String.self, forKey: .section_type)
        section_business_type = try values.decodeIfPresent(String.self, forKey: .section_business_type)
    }

}

struct Business : Codable {
    let section_id : Int?
    let section_name : String?
    let section_image : String?
    let section_type : String?
    let section_business_type : String?

    enum CodingKeys: String, CodingKey {

        case section_id = "section_id"
        case section_name = "section_name"
        case section_image = "section_image"
        case section_type = "section_type"
        case section_business_type = "section_business_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        section_id = try values.decodeIfPresent(Int.self, forKey: .section_id)
        section_name = try values.decodeIfPresent(String.self, forKey: .section_name)
        section_image = try values.decodeIfPresent(String.self, forKey: .section_image)
        section_type = try values.decodeIfPresent(String.self, forKey: .section_type)
        section_business_type = try values.decodeIfPresent(String.self, forKey: .section_business_type)
    }

}



struct Famous : Codable {
    let section_id : Int?
    let section_name : String?
    let section_image : String?
    let section_type : String?
    let section_business_type : String?

    enum CodingKeys: String, CodingKey {

        case section_id = "section_id"
        case section_name = "section_name"
        case section_image = "section_image"
        case section_type = "section_type"
        case section_business_type = "section_business_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        section_id = try values.decodeIfPresent(Int.self, forKey: .section_id)
        section_name = try values.decodeIfPresent(String.self, forKey: .section_name)
        section_image = try values.decodeIfPresent(String.self, forKey: .section_image)
        section_type = try values.decodeIfPresent(String.self, forKey: .section_type)
        section_business_type = try values.decodeIfPresent(String.self, forKey: .section_business_type)
    }

}


