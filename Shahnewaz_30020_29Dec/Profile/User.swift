//
//  User.swift
//  Shahnewaz_30020_29Dec
//
//  Created by BJIT on 1/5/23.
//

import Foundation


struct User: Encodable, Decodable {
    let userId: String?
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let password: String
}
