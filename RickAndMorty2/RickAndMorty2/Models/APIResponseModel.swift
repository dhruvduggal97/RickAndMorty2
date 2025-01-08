//
//  APIResponseModel.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//

import Foundation

struct APIResponseModel : Codable {
    let info : Info
    let results : [Character]
}

struct Info : Codable {
    let count : Int
    let pages : Int
    let next : String?
    let prev : String?
}

struct Location : Codable {
    let name : String
    let url : String
}

struct Character : Codable {
    let id : Int
    let name : String
    let status : String
    let species : String
    let type : String
    let gender : String
    let origin : Location
    let location : Location
    let image : String
    let episode : [String]
    let url : String
    let created : String

}
