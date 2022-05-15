//
//  AboutUsModel.swift
//  AskHail
//
//  Created by Abdullah Tarek on 23/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
import Foundation
struct AboutUsModel : Codable {
    let status : Bool?
    let code : String?
    let data : AboutUsDataData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(AboutUsDataData.self, forKey: .data)
    }

}
struct AboutUsDataData : Codable {
    let app_name : String?
    let app_logo : String?
    let app_description : String?
    let app_mobile : String?
    let app_twitter : String?
    let app_snapchat : String?
    let app_instagram : String?
    let app_whatsapp : String?
    let app_e_payment_activation : Bool?
    let app_banner : String?
    let app_banner_url : String?
    let app_real_estate_license : String?
    let app_enable_show_count : Bool?

    enum CodingKeys: String, CodingKey {

        case app_name = "app_name"
        case app_logo = "app_logo"
        case app_description = "app_description"
        case app_mobile = "app_mobile"
        case app_twitter = "app_twitter"
        case app_snapchat = "app_snapchat"
        case app_instagram = "app_instagram"
        case app_whatsapp = "app_whatsapp"
        case app_e_payment_activation = "app_e_payment_activation"
        case app_banner = "app_banner"
        case app_banner_url = "app_banner_url"
        case app_real_estate_license = "app_real_estate_license"
        case app_enable_show_count = "app_enable_show_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        app_name = try values.decodeIfPresent(String.self, forKey: .app_name)
        app_logo = try values.decodeIfPresent(String.self, forKey: .app_logo)
        app_description = try values.decodeIfPresent(String.self, forKey: .app_description)
        app_mobile = try values.decodeIfPresent(String.self, forKey: .app_mobile)
        app_twitter = try values.decodeIfPresent(String.self, forKey: .app_twitter)
        app_snapchat = try values.decodeIfPresent(String.self, forKey: .app_snapchat)
        app_instagram = try values.decodeIfPresent(String.self, forKey: .app_instagram)
        app_whatsapp = try values.decodeIfPresent(String.self, forKey: .app_whatsapp)
        app_e_payment_activation = try values.decodeIfPresent(Bool.self, forKey: .app_e_payment_activation)
        app_banner = try values.decodeIfPresent(String.self, forKey: .app_banner)
        app_banner_url = try values.decodeIfPresent(String.self, forKey: .app_banner_url)
        app_real_estate_license = try values.decodeIfPresent(String.self, forKey: .app_real_estate_license)
        app_enable_show_count = try values.decodeIfPresent(Bool.self, forKey: .app_enable_show_count)
    }

}
