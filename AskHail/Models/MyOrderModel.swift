//
//  MyOrderModel.swift
//  AskHail
//
//  Created by bodaa on 11/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

struct MyOrderModel : Codable {
    let status : Bool?
    let code : String?
    let data : MyOrderData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(MyOrderData.self, forKey: .data)
    }

}

struct MyOrderData : Codable {
    let data : [OrderData]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([OrderData].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}

struct OrderData : Codable {
    let order_id : Int?
    let order_advertiser_id : Int?
    let order_advertiser_name : String?
    let order_title : String?
    let order_price : String?
    let order_custom_date : String?
    let order_date_status : String?
    let order_last_update : String?
    let order_created_at : String?
    let order_updated_at : String?

    enum CodingKeys: String, CodingKey {

        case order_id = "order_id"
        case order_advertiser_id = "order_advertiser_id"
        case order_advertiser_name = "order_advertiser_name"
        case order_title = "order_title"
        case order_price = "order_price"
        case order_custom_date = "order_custom_date"
        case order_date_status = "order_date_status"
        case order_last_update = "order_last_update"
        case order_created_at = "order_created_at"
        case order_updated_at = "order_updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
        order_advertiser_id = try values.decodeIfPresent(Int.self, forKey: .order_advertiser_id)
        order_advertiser_name = try values.decodeIfPresent(String.self, forKey: .order_advertiser_name)
        order_title = try values.decodeIfPresent(String.self, forKey: .order_title)
        order_price = try values.decodeIfPresent(String.self, forKey: .order_price)
        order_custom_date = try values.decodeIfPresent(String.self, forKey: .order_custom_date)
        order_date_status = try values.decodeIfPresent(String.self, forKey: .order_date_status)
        order_last_update = try values.decodeIfPresent(String.self, forKey: .order_last_update)
        order_created_at = try values.decodeIfPresent(String.self, forKey: .order_created_at)
        order_updated_at = try values.decodeIfPresent(String.self, forKey: .order_updated_at)
    }

}

