//
//  ShowOrderModel.swift
//  AskHail
//
//  Created by bodaa on 11/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct ShowOrderModel : Codable {
    let status : Bool?
    let code : String?
    let data : ShowOrderData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(ShowOrderData.self, forKey: .data)
    }

}

struct ShowOrderData : Codable {
    let order_details : Order_details?
    let comments_count : String?
    let comments_data : [Comments_data]?
    let comments_pagination : Comments_pagination?

    enum CodingKeys: String, CodingKey {

        case order_details = "order_details"
        case comments_count = "comments_count"
        case comments_data = "comments_data"
        case comments_pagination = "comments_pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_details = try values.decodeIfPresent(Order_details.self, forKey: .order_details)
        comments_count = try values.decodeIfPresent(String.self, forKey: .comments_count)
        comments_data = try values.decodeIfPresent([Comments_data].self, forKey: .comments_data)
        comments_pagination = try values.decodeIfPresent(Comments_pagination.self, forKey: .comments_pagination)
    }

}

struct Order_details : Codable {
    let order_id : Int?
    let order_title : String?
    let order_price : String?
    let order_custom_published_date : String?
    let order_custom_last_update_date : String?
    let order_description : String?
    let order_specifications : [Order_specifications]?
    let order_region : String?
    let order_city : String?
    let order_block : String?
    let order_side : Order_side?
    let order_main_section : Order_main_section?
    let order_sub_section : Order_sub_section?
    let order_advertiser_id : Int?
    let order_advertiser_name : String?
    let order_advertiser_advs_count : String?
    let order_if_any_contact_available : Bool?
    let order_last_update : String?
    let order_created_at : String?
    let order_updated_at : String?
    let order_call_number : String?
    let order_whatsapp_number : String?
    let order_call_number_status : String?
    let order_whatsapp_number_status : String?

    enum CodingKeys: String, CodingKey {

        case order_id = "order_id"
        case order_title = "order_title"
        case order_price = "order_price"
        case order_custom_published_date = "order_custom_published_date"
        case order_custom_last_update_date = "order_custom_last_update_date"
        case order_description = "order_description"
        case order_specifications = "order_specifications"
        case order_region = "order_region"
        case order_city = "order_city"
        case order_block = "order_block"
        case order_side = "order_side"
        case order_main_section = "order_main_section"
        case order_sub_section = "order_sub_section"
        case order_advertiser_id = "order_advertiser_id"
        case order_advertiser_name = "order_advertiser_name"
        case order_advertiser_advs_count = "order_advertiser_advs_count"
        case order_if_any_contact_available = "order_if_any_contact_available"
        case order_last_update = "order_last_update"
        case order_created_at = "order_created_at"
        case order_updated_at = "order_updated_at"
        case order_call_number = "order_call_number"
        case order_whatsapp_number = "order_whatsapp_number"
        case order_call_number_status = "order_call_number_status"
        case order_whatsapp_number_status = "order_whatsapp_number_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
        order_title = try values.decodeIfPresent(String.self, forKey: .order_title)
        order_price = try values.decodeIfPresent(String.self, forKey: .order_price)
        order_custom_published_date = try values.decodeIfPresent(String.self, forKey: .order_custom_published_date)
        order_custom_last_update_date = try values.decodeIfPresent(String.self, forKey: .order_custom_last_update_date)
        order_description = try values.decodeIfPresent(String.self, forKey: .order_description)
        order_specifications = try values.decodeIfPresent([Order_specifications].self, forKey: .order_specifications)
        order_region = try values.decodeIfPresent(String.self, forKey: .order_region)
        order_city = try values.decodeIfPresent(String.self, forKey: .order_city)
        order_block = try values.decodeIfPresent(String.self, forKey: .order_block)
        order_side = try values.decodeIfPresent(Order_side.self, forKey: .order_side)
        order_main_section = try values.decodeIfPresent(Order_main_section.self, forKey: .order_main_section)
        order_sub_section = try values.decodeIfPresent(Order_sub_section.self, forKey: .order_sub_section)
        order_advertiser_id = try values.decodeIfPresent(Int.self, forKey: .order_advertiser_id)
        order_advertiser_name = try values.decodeIfPresent(String.self, forKey: .order_advertiser_name)
        order_advertiser_advs_count = try values.decodeIfPresent(String.self, forKey: .order_advertiser_advs_count)
        order_if_any_contact_available = try values.decodeIfPresent(Bool.self, forKey: .order_if_any_contact_available)
        order_last_update = try values.decodeIfPresent(String.self, forKey: .order_last_update)
        order_created_at = try values.decodeIfPresent(String.self, forKey: .order_created_at)
        order_updated_at = try values.decodeIfPresent(String.self, forKey: .order_updated_at)
        order_call_number = try values.decodeIfPresent(String.self, forKey: .order_call_number)
        order_whatsapp_number = try values.decodeIfPresent(String.self, forKey: .order_whatsapp_number)
        order_call_number_status = try values.decodeIfPresent(String.self, forKey: .order_call_number_status)
        order_whatsapp_number_status = try values.decodeIfPresent(String.self, forKey: .order_whatsapp_number_status)
    }

}
struct Order_side : Codable {
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
struct Order_main_section : Codable {
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
struct Order_sub_section : Codable {
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


struct Order_block : Codable {
    let block_id : Int?
    let block_name : String?

    enum CodingKeys: String, CodingKey {

        case block_id = "block_id"
        case block_name = "block_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        block_id = try values.decodeIfPresent(Int.self, forKey: .block_id)
        block_name = try values.decodeIfPresent(String.self, forKey: .block_name)
    }

}
