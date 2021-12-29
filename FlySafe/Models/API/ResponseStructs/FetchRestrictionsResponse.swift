//
//  FetchRestrictionsResponse.swift
//  FlySafe
//
//  Created by Nika Topuria on 19.12.21.
//

import Foundation

// MARK: - Welcome
struct FetchRestrictionsResponse: Codable {
    let success: Bool
    let restricions: [String : Restrictions]?
}

// MARK: - Airport Name
struct Restrictions: Codable {
    let type: String
    let generalRestrictions: GeneralRestrictions?
    let restrictionsByVaccination: RestrictionsByVaccination?
    let restrictionsByNationality: [RestrictionsByNationality]?
}

// MARK: - GeneralRestrictions
struct GeneralRestrictions: Codable {
    let allowsTourists, allowsBusinessVisit, covidPassportRequired, pcrRequiredForNoneResidents: Bool?
    let pcrRequiredForResidents: Bool?
    let generalInformation: String?
    let moreInfoURL: String?

    enum CodingKeys: String, CodingKey {
        case allowsTourists, allowsBusinessVisit, covidPassportRequired, pcrRequiredForNoneResidents, pcrRequiredForResidents, generalInformation
        case moreInfoURL = "moreInfoUrl"
    }
}

// MARK: - RestrictionsByNationality
struct RestrictionsByNationality: Codable {
    let type: String?
    let data: DetailsInfo?
}

// MARK: - DataClass
struct DetailsInfo: Codable {
    let allowsTourists, allowsBusinessVisit, pcrRequired, fastTestRequired: Bool?
    let biometricPassportRequired, locatorFormRequired, covidPassportRequired: Bool?
}

// MARK: - RestrictionsByVaccination
struct RestrictionsByVaccination: Codable {
    let isAllowed: Bool?
    let dozesRequired, minDaysAfterVaccination, maxDaysAfterVaccination: Int?
}

