//
//  LoginModel.swift
//  AskHail
//
//  Created by Abdullah Tarek on 25/11/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
struct LoginModel : Codable {
    let status : Bool?
    let code : String?
    let data : LoginData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
    }

}

struct LoginData : Codable {
    var advertiser_id : Int?
    let advertiser_type : String?
    var advertiser_name : String?
    var advertiser_email : String?
    var advertiser_mobile : String?
    let advertiser_api_token : String?
    let advertiser_firebase_token : String?
    let advertiser_package_id : String?
    let advertiser_side : String?
    let advertiser_capacity : String?
    let advertiser_delegation_number : String?
    let advertiser_licence_number : String?
    let advertiser_type_id : Int?
    let advertiser_id_number : String?

    enum CodingKeys: String, CodingKey {

        case advertiser_id = "advertiser_id"
        case advertiser_type = "advertiser_type"
        case advertiser_name = "advertiser_name"
        case advertiser_email = "advertiser_email"
        case advertiser_mobile = "advertiser_mobile"
        case advertiser_api_token = "advertiser_api_token"
        case advertiser_firebase_token = "advertiser_firebase_token"
        case advertiser_package_id = "advertiser_package_id"
        case advertiser_side = "advertiser_side"
        case advertiser_capacity = "advertiser_capacity"
        case advertiser_delegation_number = "advertiser_delegation_number"
        case advertiser_licence_number = "advertiser_licence_number"
        case advertiser_type_id = "advertiser_type_id"
        case advertiser_id_number = "advertiser_id_number"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertiser_id = try values.decodeIfPresent(Int.self, forKey: .advertiser_id)
        advertiser_type = try values.decodeIfPresent(String.self, forKey: .advertiser_type)
        advertiser_name = try values.decodeIfPresent(String.self, forKey: .advertiser_name)
        advertiser_email = try values.decodeIfPresent(String.self, forKey: .advertiser_email)
        advertiser_mobile = try values.decodeIfPresent(String.self, forKey: .advertiser_mobile)
        advertiser_api_token = try values.decodeIfPresent(String.self, forKey: .advertiser_api_token)
        advertiser_firebase_token = try values.decodeIfPresent(String.self, forKey: .advertiser_firebase_token)
        advertiser_package_id = try values.decodeIfPresent(String.self, forKey: .advertiser_package_id)
        advertiser_side = try values.decodeIfPresent(String.self, forKey: .advertiser_side)
        advertiser_capacity = try values.decodeIfPresent(String.self, forKey: .advertiser_capacity)
        advertiser_delegation_number = try values.decodeIfPresent(String.self, forKey: .advertiser_delegation_number)
        advertiser_licence_number = try values.decodeIfPresent(String.self, forKey: .advertiser_licence_number)
        advertiser_type_id = try values.decodeIfPresent(Int.self, forKey: .advertiser_type_id)
        advertiser_id_number = try values.decodeIfPresent(String.self, forKey: .advertiser_id_number)
    }

}

import Foundation
import UIKit

typealias UserDataModel = LoginData

class AuthService {
    
    private init () { }
    
    private let userDataKey = "_User_|_Data_"
    private let packageExpireKey = "packageExpireKey"
    private static let userDefault = UserDefaults.standard
    
    fileprivate func getUserData() -> LoginData? {
        let defaults = UserDefaults.standard
        guard let savedPerson = defaults.object(forKey: userDataKey) as? Data,
              let loadedData = try? JSONDecoder().decode(UserDataModel.self, from: savedPerson)
        else { return nil }
        return loadedData
    }
    
    fileprivate func setUserData(_ newValue: LoginData?) {
        // guard let newValue = newValue else { return }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(newValue) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: userDataKey)
        } else {
            fatalError("Unable To Save User Data")
        }
    }
    
    static var userData: UserDataModel? {
        get {
            let authService = AuthService()
            return authService.getUserData()
        } set {
            let authService = AuthService()
            authService.setUserData(newValue)
        }
    }
    
    
}


