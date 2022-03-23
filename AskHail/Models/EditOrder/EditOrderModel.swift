//
//  EditOrderModel.swift
//  AskHail
//
//  Created by bodaa on 13/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

//MARK:Edit Section

struct OrderEditSectionModel : Codable {
    let status : Bool?
    let code : String?
    let data : OrderEditSectionData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(OrderEditSectionData.self, forKey: .data)
    }

}

struct OrderEditSectionData : Codable {
    let order_id : Int?
    let order_main_section_id : Int?
    let order_sub_section_id : Int?

    enum CodingKeys: String, CodingKey {

        case order_id = "order_id"
        case order_main_section_id = "order_main_section_id"
        case order_sub_section_id = "order_sub_section_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
        order_main_section_id = try values.decodeIfPresent(Int.self, forKey: .order_main_section_id)
        order_sub_section_id = try values.decodeIfPresent(Int.self, forKey: .order_sub_section_id)
    }

}

//MARK:Edit Details

struct OrderEditDetailsModel : Codable {
    let status : Bool?
    let code : String?
    let data : OrderEditDetailsData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(OrderEditDetailsData.self, forKey: .data)
    }

}

struct OrderEditDetailsData : Codable {
    let order_id : Int?
    let order_title : String?
    let order_description : String?
    let order_price : String?
    let order_block_id : Int?
    let order_side_id : Int?
    let order_specifications : [Order_specifications]?

    enum CodingKeys: String, CodingKey {

        case order_id = "order_id"
        case order_title = "order_title"
        case order_description = "order_description"
        case order_price = "order_price"
        case order_block_id = "order_block_id"
        case order_side_id = "order_side_id"
        case order_specifications = "order_specifications"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
        order_title = try values.decodeIfPresent(String.self, forKey: .order_title)
        order_description = try values.decodeIfPresent(String.self, forKey: .order_description)
        order_price = try values.decodeIfPresent(String.self, forKey: .order_price)
        order_block_id = try values.decodeIfPresent(Int.self, forKey: .order_block_id)
        order_side_id = try values.decodeIfPresent(Int.self, forKey: .order_side_id)
        order_specifications = try values.decodeIfPresent([Order_specifications].self, forKey: .order_specifications)
    }

}

struct Order_specifications : Codable {
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


//MARK:Edit Contact Way

struct OrderEditContactsModel : Codable {
    let status : Bool?
    let code : String?
    let data : OrderEditContactsData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(OrderEditContactsData.self, forKey: .data)
    }

}

struct OrderEditContactsData : Codable {
    let order_id : Int?
    let order_call_number_status : String?
    let order_call_number : String?
    let order_whatsapp_number_status : String?
    let order_whatsapp_number : String?

    enum CodingKeys: String, CodingKey {

        case order_id = "order_id"
        case order_call_number_status = "order_call_number_status"
        case order_call_number = "order_call_number"
        case order_whatsapp_number_status = "order_whatsapp_number_status"
        case order_whatsapp_number = "order_whatsapp_number"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
        order_call_number_status = try values.decodeIfPresent(String.self, forKey: .order_call_number_status)
        order_call_number = try values.decodeIfPresent(String.self, forKey: .order_call_number)
        order_whatsapp_number_status = try values.decodeIfPresent(String.self, forKey: .order_whatsapp_number_status)
        order_whatsapp_number = try values.decodeIfPresent(String.self, forKey: .order_whatsapp_number)
    }

}



//MARK:Success Edit Section

struct OrderSuccessEditModel : Codable {
    let status : Bool?
    let code : String?
    let data : OrderSuccessEditData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(OrderSuccessEditData.self, forKey: .data)
    }

}

struct OrderSuccessEditData : Codable {
    let message : String?
    let order_id : Int?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case order_id = "order_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
    }

}



