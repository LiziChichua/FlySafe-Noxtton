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
    let restricions: Restricions
}

// MARK: - Restricions
struct Restricions: Codable {
    let gva: Gva
    let ber: BER

    enum CodingKeys: String, CodingKey {
        case gva = "GVA"
        case ber = "BER"
    }
}

// MARK: - Airport Name
struct BER: Codable {
    let type: String
    let generalRestrictions: GeneralRestrictions
}

// MARK: - GeneralRestrictions
struct GeneralRestrictions: Codable {
    let allowsTourists, allowsBusinessVisit, covidPassportRequired, pcrRequiredForNoneResidents: Bool
    let pcrRequiredForResidents: Bool
    let generalInformation: String
    let moreInfoURL: String

    enum CodingKeys: String, CodingKey {
        case allowsTourists, allowsBusinessVisit, covidPassportRequired, pcrRequiredForNoneResidents, pcrRequiredForResidents, generalInformation
        case moreInfoURL = "moreInfoUrl"
    }
}

// MARK: - Gva
struct Gva: Codable {
    let type: String
    let generalRestrictions: GeneralRestrictions
    let restrictionsByVaccination: RestrictionsByVaccination
    let restrictionsByNationality: [RestrictionsByNationality]
}

// MARK: - RestrictionsByNationality
struct RestrictionsByNationality: Codable {
    let type: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let allowsTourists, allowsBusinessVisit, pcrRequired, fastTestRequired: Bool?
    let biometricPassportRequired, locatorFormRequired, covidPassportRequired: Bool?
}

// MARK: - RestrictionsByVaccination
struct RestrictionsByVaccination: Codable {
    let isAllowed: Bool
    let dozesRequired, minDaysAfterVaccination, maxDaysAfterVaccination: Int
}

