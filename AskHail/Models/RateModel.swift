//
//  RateModel.swift
//  AskHail
//
//  Created by bodaa on 15/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation

//MARK:-Add Rate

struct AddRateModel: Codable {
    let status : Bool?
    let code : String?
    let data : AddRateData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(AddRateData.self, forKey: .data)
    }

}

struct AddRateData : Codable {
    let message : String?
    let rate : Rate?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case rate = "rate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        rate = try values.decodeIfPresent(Rate.self, forKey: .rate)
    }

}

struct Rate : Codable {
    let rate_id : Int?
    let rate_voter_id : Int?
    let rate_voter_name : String?
    let rate : Double?
    let rate_custom_date : String?
    let rate_created_at : String?
    let rate_updated_at : String?

    enum CodingKeys: String, CodingKey {

        case rate_id = "rate_id"
        case rate_voter_id = "rate_voter_id"
        case rate_voter_name = "rate_voter_name"
        case rate = "rate"
        case rate_custom_date = "rate_custom_date"
        case rate_created_at = "rate_created_at"
        case rate_updated_at = "rate_updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rate_id = try values.decodeIfPresent(Int.self, forKey: .rate_id)
        rate_voter_id = try values.decodeIfPresent(Int.self, forKey: .rate_voter_id)
        rate_voter_name = try values.decodeIfPresent(String.self, forKey: .rate_voter_name)
        rate = try values.decodeIfPresent(Double.self, forKey: .rate)
        rate_custom_date = try values.decodeIfPresent(String.self, forKey: .rate_custom_date)
        rate_created_at = try values.decodeIfPresent(String.self, forKey: .rate_created_at)
        rate_updated_at = try values.decodeIfPresent(String.self, forKey: .rate_updated_at)
    }

}


//MARK:ShowRate
struct ShowRateModel : Codable {
    let status : Bool?
    let code : String?
    let data : ShowRateData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(ShowRateData.self, forKey: .data)
    }

}

struct ShowRateData : Codable {
    let data : [Rate]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([Rate].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}
