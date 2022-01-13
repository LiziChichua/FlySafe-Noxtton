//
//  FetchRestrictionsResponse.swift
//  FlySafe
//
//  Created by Nika Topuria on 19.12.21.
//

import Foundation

struct FetchRestrictionsResponse: Codable {
    let success: Bool
    let restricions: [String : Restrictions]?
}

struct Restrictions: Codable, Loopable {
    let type: String
    let generalRestrictions: GeneralRestrictions?
    let restrictionsByVaccination: RestrictionsByVaccination?
    let restrictionsByNationality: [RestrictionsByNationality]?
}

struct GeneralRestrictions: Codable, Loopable {
    let allowsTourists, allowsBusinessVisit, covidPassportRequired, pcrRequiredForNoneResidents: Bool?
    let pcrRequiredForResidents: Bool?
    let generalInformation: String?
    let moreInfoURL: String?

    enum CodingKeys: String, CodingKey {
        case allowsTourists, allowsBusinessVisit, covidPassportRequired, pcrRequiredForNoneResidents, pcrRequiredForResidents, generalInformation
        case moreInfoURL = "moreInfoUrl"
    }
}

struct RestrictionsByNationality: Codable {
    let type: String?
    let data: DetailsInfo?
}

struct DetailsInfo: Codable {
    let allowsTourists, allowsBusinessVisit, pcrRequired, fastTestRequired: Bool?
    let biometricPassportRequired, locatorFormRequired, covidPassportRequired: Bool?
}

struct RestrictionsByVaccination: Codable {
    let isAllowed: Bool?
    let dozesRequired, minDaysAfterVaccination, maxDaysAfterVaccination: Int?
}

