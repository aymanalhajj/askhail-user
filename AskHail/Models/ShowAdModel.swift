//
//  ShowAdModel.swift
//  AskHail
//
//  Created by Abdullah Tarek on 02/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

struct ShowAdModel : Codable {
    let status : Bool?
    let code : String?
    let data : ShowAdData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(ShowAdData.self, forKey: .data)
    }

}

struct ShowAdData : Codable {
    let advertisement_details : Advertisement_details?
    let comments_count : String?
    let comments_data : [Comments_data]?
    let comments_pagination : Comments_pagination?

    enum CodingKeys: String, CodingKey {

        case advertisement_details = "advertisement_details"
        case comments_count = "comments_count"
        case comments_data = "comments_data"
        case comments_pagination = "comments_pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertisement_details = try values.decodeIfPresent(Advertisement_details.self, forKey: .advertisement_details)
        comments_count = try values.decodeIfPresent(String.self, forKey: .comments_count)
        comments_data = try values.decodeIfPresent([Comments_data].self, forKey: .comments_data)
        comments_pagination = try values.decodeIfPresent(Comments_pagination.self, forKey: .comments_pagination)
    }

}

struct Advertisement_details : Codable {
    let isWaiting :Bool?
    let adv_id : Int?
    let adv_is_favorite : Bool?
    let adv_special_status : String?
    let adv_media : [Adv_media]?
    let adv_promotional_image : String?
    let adv_title : String?
    let adv_price : String?
    let adv_distance : String?
    let adv_views : String?
    let adv_custom_published_date : String?
    let adv_custom_last_update_date : String?
    let adv_last_update : String?
    let adv_description : String?
    let adv_specifications : [Adv_specifications]?
    let adv_location : String?
    let adv_latitude : String?
    let adv_longitude : String?
    let adv_advertiser_name : String?
    let adv_advertiser_advs_count : String?
    let adv_if_any_contact_available : Bool?
    let adv_call_number_status : String?
    let adv_call_number : String?
    let adv_whatsapp_number_status : String?
    let adv_whatsapp_number : String?
    let adv_created_at : String?
    let adv_updated_at : String?
    let adv_advertiser_id : Int?
    let specification_answer_Id : Int?
    let adv_type : String?
    let adv_region : Adv_region?
    let adv_city : Adv_city?
    let adv_block : Adv_block?
    let adv_side : Adv_side?

    enum CodingKeys: String, CodingKey {

        case isWaiting = "isWaiting"
        case adv_id = "adv_id"
        case adv_is_favorite = "adv_is_favorite"
        case adv_special_status = "adv_special_status"
        case adv_media = "adv_media"
        case adv_promotional_image = "adv_promotional_image"
        case adv_title = "adv_title"
        case adv_price = "adv_price"
        case adv_distance = "adv_distance"
        case adv_views = "adv_views"
        case adv_custom_published_date = "adv_custom_published_date"
        case adv_custom_last_update_date = "adv_custom_last_update_date"
        case adv_last_update = "adv_last_update"
        case adv_description = "adv_description"
        case adv_specifications = "adv_specifications"
        case adv_location = "adv_location"
        case adv_latitude = "adv_latitude"
        case adv_longitude = "adv_longitude"
        case adv_advertiser_name = "adv_advertiser_name"
        case adv_advertiser_advs_count = "adv_advertiser_advs_count"
        case adv_if_any_contact_available = "adv_if_any_contact_available"
        case adv_call_number_status = "adv_call_number_status"
        case adv_call_number = "adv_call_number"
        case adv_whatsapp_number_status = "adv_whatsapp_number_status"
        case adv_created_at = "adv_created_at"
        case adv_updated_at = "adv_updated_at"
        case adv_whatsapp_number = "adv_whatsapp_number"
        case adv_advertiser_id = "adv_advertiser_id"
        case specification_answer_Id = "specification_answer_Id"
        case adv_type = "adv_type"
        case adv_region = "adv_region"
        case adv_city = "adv_city"
        case adv_block = "adv_block"
        case adv_side = "adv_side"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isWaiting = try values.decodeIfPresent(Bool.self, forKey: .isWaiting)
        adv_id = try values.decodeIfPresent(Int.self, forKey: .adv_id)
        adv_is_favorite = try values.decodeIfPresent(Bool.self, forKey: .adv_is_favorite)
        adv_special_status = try values.decodeIfPresent(String.self, forKey: .adv_special_status)
        adv_media = try values.decodeIfPresent([Adv_media].self, forKey: .adv_media)
        adv_promotional_image = try values.decodeIfPresent(String.self, forKey: .adv_promotional_image)
        adv_title = try values.decodeIfPresent(String.self, forKey: .adv_title)
        adv_price = try values.decodeIfPresent(String.self, forKey: .adv_price)
        adv_distance = try values.decodeIfPresent(String.self, forKey: .adv_distance)
        adv_views = try values.decodeIfPresent(String.self, forKey: .adv_views)
        adv_custom_published_date = try values.decodeIfPresent(String.self, forKey: .adv_custom_published_date)
        adv_custom_last_update_date = try values.decodeIfPresent(String.self, forKey: .adv_custom_last_update_date)
        adv_last_update = try values.decodeIfPresent(String.self, forKey: .adv_last_update)
        adv_description = try values.decodeIfPresent(String.self, forKey: .adv_description)
        adv_specifications = try values.decodeIfPresent([Adv_specifications].self, forKey: .adv_specifications)
        adv_location = try values.decodeIfPresent(String.self, forKey: .adv_location)
        adv_latitude = try values.decodeIfPresent(String.self, forKey: .adv_latitude)
        adv_longitude = try values.decodeIfPresent(String.self, forKey: .adv_longitude)
        adv_advertiser_name = try values.decodeIfPresent(String.self, forKey: .adv_advertiser_name)
        adv_advertiser_advs_count = try values.decodeIfPresent(String.self, forKey: .adv_advertiser_advs_count)
        adv_if_any_contact_available = try values.decodeIfPresent(Bool.self, forKey: .adv_if_any_contact_available)
        adv_call_number_status = try values.decodeIfPresent(String.self, forKey: .adv_call_number_status)
        adv_call_number = try values.decodeIfPresent(String.self, forKey: .adv_call_number)
        adv_whatsapp_number_status = try values.decodeIfPresent(String.self, forKey: .adv_whatsapp_number_status)
        adv_created_at = try values.decodeIfPresent(String.self, forKey: .adv_created_at)
        adv_updated_at = try values.decodeIfPresent(String.self, forKey: .adv_updated_at)
        adv_whatsapp_number = try values.decodeIfPresent(String.self, forKey: .adv_whatsapp_number)
        adv_advertiser_id = try values.decodeIfPresent(Int.self, forKey: .adv_advertiser_id)
        specification_answer_Id = try values.decodeIfPresent(Int.self, forKey: .adv_advertiser_id)
        adv_type = try values.decodeIfPresent(String.self, forKey: .adv_type)
        adv_region = try values.decodeIfPresent(Adv_region.self, forKey: .adv_region)
        adv_city = try values.decodeIfPresent(Adv_city.self, forKey: .adv_city)
        adv_block = try values.decodeIfPresent(Adv_block.self, forKey: .adv_block)
        adv_side = try values.decodeIfPresent(Adv_side.self, forKey: .adv_side)
    }

}

struct Adv_city : Codable {
    let city_id : Int?
    let city_region : City_region?
    let city_name : String?
    let admin_city_name : String?

    enum CodingKeys: String, CodingKey {

        case city_id = "city_id"
        case city_region = "city_region"
        case city_name = "city_name"
        case admin_city_name = "admin_city_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city_id = try values.decodeIfPresent(Int.self, forKey: .city_id)
        city_region = try values.decodeIfPresent(City_region.self, forKey: .city_region)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        admin_city_name = try values.decodeIfPresent(String.self, forKey: .admin_city_name)
    }

}


struct Adv_region : Codable {
    let region_id : Int?
    let region_name : String?

    enum CodingKeys: String, CodingKey {

        case region_id = "region_id"
        case region_name = "region_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        region_id = try values.decodeIfPresent(Int.self, forKey: .region_id)
        region_name = try values.decodeIfPresent(String.self, forKey: .region_name)
    }

}
struct Adv_side : Codable {
    let side_id : Int?
    let side_name : String?

    enum CodingKeys: String, CodingKey {

        case side_id = "side_id"
        case side_name = "side_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        side_id = try values.decodeIfPresent(Int.self, forKey: .side_id)
        side_name = try values.decodeIfPresent(String.self, forKey: .side_name)
    }

}


struct Adv_block : Codable {
    let block_id : String?
    let block_city : Block_city?
    let block_name : String?
    let admin_block_name : String?

    enum CodingKeys: String, CodingKey {

        case block_id = "block_id"
        case block_city = "block_city"
        case block_name = "block_name"
        case admin_block_name = "admin_block_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        block_id = try values.decodeIfPresent(String.self, forKey: .block_id)
        block_city = try values.decodeIfPresent(Block_city.self, forKey: .block_city)
        block_name = try values.decodeIfPresent(String.self, forKey: .block_name)
        admin_block_name = try values.decodeIfPresent(String.self, forKey: .admin_block_name)
    }

}


struct Adv_specifications : Codable {
    let specification_id : Int?
    let specification_adv_id : Int?
    let specification_section_feature : Specification_section_feature?
    let specification_answer : String?

    enum CodingKeys: String, CodingKey {

        case specification_id = "specification_id"
        case specification_adv_id = "specification_adv_id"
        case specification_section_feature = "specification_section_feature"
        case specification_answer = "specification_answer"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        specification_id = try values.decodeIfPresent(Int.self, forKey: .specification_id)
        specification_adv_id = try values.decodeIfPresent(Int.self, forKey: .specification_adv_id)
        specification_section_feature = try values.decodeIfPresent(Specification_section_feature.self, forKey: .specification_section_feature)
        specification_answer = try values.decodeIfPresent(String.self, forKey: .specification_answer)
    }

}

struct Comments_data : Codable {
    var comment_id : Int?
    let comment_voter_id : Int?
    let comment_voter_name : String?
    let comment_text : String?
    let comment_text_custom_date : String?
    var comment_if_advertiser_reply_yet : Bool?
    var comment_advertiser_reply : String?
    let comment_advertiser_reply_custom_date : String?
    let comment_created_at : String?
    let comment_updated_at : String?

    enum CodingKeys: String, CodingKey {

        case comment_id = "comment_id"
        case comment_voter_id = "comment_voter_id"
        case comment_voter_name = "comment_voter_name"
        case comment_text = "comment_text"
        case comment_text_custom_date = "comment_text_custom_date"
        case comment_if_advertiser_reply_yet = "comment_if_advertiser_reply_yet"
        case comment_advertiser_reply = "comment_advertiser_reply"
        case comment_advertiser_reply_custom_date = "comment_advertiser_reply_custom_date"
        case comment_created_at = "comment_created_at"
        case comment_updated_at = "comment_updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        comment_id = try values.decodeIfPresent(Int.self, forKey: .comment_id)
        comment_voter_id = try values.decodeIfPresent(Int.self, forKey: .comment_voter_id)
        comment_voter_name = try values.decodeIfPresent(String.self, forKey: .comment_voter_name)
        comment_text = try values.decodeIfPresent(String.self, forKey: .comment_text)
        comment_text_custom_date = try values.decodeIfPresent(String.self, forKey: .comment_text_custom_date)
        comment_if_advertiser_reply_yet = try values.decodeIfPresent(Bool.self, forKey: .comment_if_advertiser_reply_yet)
        comment_advertiser_reply = try values.decodeIfPresent(String.self, forKey: .comment_advertiser_reply)
        comment_advertiser_reply_custom_date = try values.decodeIfPresent(String.self, forKey: .comment_advertiser_reply_custom_date)
        comment_created_at = try values.decodeIfPresent(String.self, forKey: .comment_created_at)
        comment_updated_at = try values.decodeIfPresent(String.self, forKey: .comment_updated_at)
    }

}

struct Comments_pagination : Codable {
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

struct Specification_section_feature : Codable {
    let feature_id : Int?
    let feature_section : Feature_section?
    let feature_name : String?
    let feature_type : String?

    enum CodingKeys: String, CodingKey {

        case feature_id = "feature_id"
        case feature_section = "feature_section"
        case feature_name = "feature_name"
        case feature_type = "feature_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        feature_id = try values.decodeIfPresent(Int.self, forKey: .feature_id)
        feature_section = try values.decodeIfPresent(Feature_section.self, forKey: .feature_section)
        feature_name = try values.decodeIfPresent(String.self, forKey: .feature_name)
        feature_type = try values.decodeIfPresent(String.self, forKey: .feature_type)
    }

}

struct Feature_section : Codable {
    let section_id : Int?
    let section_name : String?
    let section_image : String?

    enum CodingKeys: String, CodingKey {

        case section_id = "section_id"
        case section_name = "section_name"
        case section_image = "section_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        section_id = try values.decodeIfPresent(Int.self, forKey: .section_id)
        section_name = try values.decodeIfPresent(String.self, forKey: .section_name)
        section_image = try values.decodeIfPresent(String.self, forKey: .section_image)
    }

}
