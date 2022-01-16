//
//  RestrictionTableViewCell.swift
//  FlySafe
//
//  Created by LiziChichua on 02.01.22.
//

import UIKit

class RestrictionTableViewCell: UITableViewCell {
    
    var restrictions: (String , Restrictions)? {
        didSet {
            guard let restrictions = restrictions else {return}
            //Set main title
            sourceToDestinationLabel.text = restrictions.0
            let info = restrictions.1
            
            /////MARK: - General restrictions
            
            let generalRestrictions = info.generalRestrictions
            
            touristsAllowedLabel.text = "Tourists allowed: \(generalRestrictions.allowsTourists == true ? "Yes" : "No" )"
            
            businessVisitsAllowedLabel.text = "Business visits allowed: \(generalRestrictions.allowsBusinessVisit == true ? "Yes" : "No")"
            
            covidPassportRequiredLabel.text = "Covid passport required: \(generalRestrictions.covidPassportRequired == true ? "Yes" : "No")"
            
            PSRTestForNonResidentsLabel.text = "PCR test for non-residents: \(generalRestrictions.pcrRequiredForNoneResidents == true ? "Yes" : "No")"
            
            PSRTestForResidentsLabel.text = "PCR test for residents: \(generalRestrictions.pcrRequiredForResidents == true ? "Yes" : "No")"
            
            generalInformationTextLabel.text = "General Information: \(generalRestrictions.generalInformation ?? "No Information")"
            
            
            /////MARK: - Restrictions by vaccination
            
            if let restrictionsByVaccination = info.restrictionsByVaccination {
                vaccinatedVisitorsAllowedLabel.text = "Vaccinated Visitors allowed: \(restrictionsByVaccination.isAllowed == true ? "Yes" : "No" )"
                
                if let dozesRequired = restrictionsByVaccination.dozesRequired {
                    dozesRequiredLabel.text = "Dozes required: \(dozesRequired)"
                } else {
                    dozesRequiredLabel.text = "Dozes required: No Information"
                }
                
                if let minDays = restrictionsByVaccination.minDaysAfterVaccination {
                    MinDaysAfterVaccinationLabel.text = "Min days after vaccination: \(minDays)"
                } else {
                    MinDaysAfterVaccinationLabel.text = "Min days after vaccination: No Information"
                }
                
                if let maxDays = restrictionsByVaccination.maxDaysAfterVaccination {
                    MaxDaysAfterVaccinationLabel.text = "Max days after vaccination: \(maxDays)"
                } else {
                    MaxDaysAfterVaccinationLabel.text = "Max days after vaccination: No Information"
                }
            } else {
                vaccinatedVisitorsAllowedLabel.text = "Vaccinated Visitors allowed: No information"
                MinDaysAfterVaccinationLabel.text = "Min days after vaccination: No information"
                MaxDaysAfterVaccinationLabel.text = "Max days after vaccination: No information"
                dozesRequiredLabel.text = "Dozes required: No information"
            }
            
            
            
            /////MARK: - Restrictions by nationality
            
            if let restrictionsByNationality = info.restrictionsByNationality  {
                
                restrictionsByNationality.forEach({
                    switch $0.type {
                    case "Visit Type":
                        touristsAllowedByNationalityLabel.text = "Tourists allowed: \($0.data?.allowsTourists == true ? "Yes" : "No" )"
                        businessVisitsAllowedByNationalityLabel.text = "Business visits allowed: \($0.data?.allowsBusinessVisit == true ? "Yes" : "No" )"
                    case "Covid Test":
                        PCRTestsAcceptedLabel.text = "PCR tests accepted: \($0.data?.pcrRequired == true ? "Yes" : "No" )"
                        quickTestsAcceptedLabel.text = "Quick tests accepted: \($0.data?.fastTestRequired == true ? "Yes" : "No" )"
                    case "Documents Required":
                        covidPassportRequiredByNationalityLabel.text = "Covid passport required: \($0.data?.covidPassportRequired == true ? "Yes" : "No" )"
                        biometricPassportRequiredLabel.text = "Biometric passport required: \($0.data?.biometricPassportRequired == true ? "Yes" : "No" )"
                        locatorFormRequiredLabel.text = "Locator form required: \($0.data?.locatorFormRequired == true ? "Yes" : "No" )"
                    default:
                        print ("Received extra restrictions")
                    }
                })
                
                
            } else {
                touristsAllowedByNationalityLabel.text = "Tourists allowed: No Information"
                businessVisitsAllowedByNationalityLabel.text = "Business visits allowed: No Information"
                PCRTestsAcceptedLabel.text = "PCR tests accepted: No Information"
                quickTestsAcceptedLabel.text = "Quick tests accepted: No Information"
                covidPassportRequiredByNationalityLabel.text = "Covid passport required: No Information"
                biometricPassportRequiredLabel.text = "Biometric passport required: No Information"
                locatorFormRequiredLabel.text = "Locator form required: No Information"
            }
            
        }
    }
    
    
    
    //Source to Destination Label
    let sourceToDestinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //General Restrictions Label
    let generalRestrictionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "General Restrictions:"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Tourists allowed Label
    let touristsAllowedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Business visits allowed Label
    let businessVisitsAllowedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Covid passport required Label
    let covidPassportRequiredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //PCR test for non-residents Label
    let PSRTestForNonResidentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //PCR test for residents Label
    let PSRTestForResidentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //General information Label
    let generalInformationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //General information Text Label
    let generalInformationTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Restrictions By Vaccination Label
    let restrictionsByVacctinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Restrictions By Vaccination:"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Vaccinated Visitors allowed Label
    let vaccinatedVisitorsAllowedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Dozes required Label
    let dozesRequiredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Min days after vaccination Label
    let MinDaysAfterVaccinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Max days after vaccination Label
    let MaxDaysAfterVaccinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Restrictions By Nationality Label
    let restrictionsByNationalityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Restrictions By Nationality:"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Tourists allowed By Nationality Label
    let touristsAllowedByNationalityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Business visits allowed By Nationality Label
    let businessVisitsAllowedByNationalityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Covid passport required By Nationality Label
    let covidPassportRequiredByNationalityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //PCR tests accepted Label
    let PCRTestsAcceptedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Quick tests accepted Label
    let quickTestsAcceptedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Biometric passport required Label
    let biometricPassportRequiredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Locator form required Label
    let locatorFormRequiredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    //Dashed Line View
    let dashedLineView: DashedLineView = {
        let view = DashedLineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sizeToFit()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Add subviews
        self.addSubview(sourceToDestinationLabel)
        self.addSubview(generalRestrictionsLabel)
        self.addSubview(touristsAllowedLabel)
        self.addSubview(businessVisitsAllowedLabel)
        self.addSubview(covidPassportRequiredLabel)
        self.addSubview(PSRTestForNonResidentsLabel)
        self.addSubview(PSRTestForResidentsLabel)
        self.addSubview(generalInformationLabel)
        self.addSubview(generalInformationTextLabel)
        self.addSubview(restrictionsByVacctinationLabel)
        self.addSubview(vaccinatedVisitorsAllowedLabel)
        self.addSubview(dozesRequiredLabel)
        self.addSubview(MinDaysAfterVaccinationLabel)
        self.addSubview(MaxDaysAfterVaccinationLabel)
        self.addSubview(restrictionsByNationalityLabel)
        self.addSubview(touristsAllowedByNationalityLabel)
        self.addSubview(businessVisitsAllowedByNationalityLabel)
        self.addSubview(covidPassportRequiredByNationalityLabel)
        self.addSubview(PCRTestsAcceptedLabel)
        self.addSubview(quickTestsAcceptedLabel)
        self.addSubview(biometricPassportRequiredLabel)
        self.addSubview(locatorFormRequiredLabel)
        self.addSubview(dashedLineView)
        
        //Constraints
        NSLayoutConstraint.activate([
            sourceToDestinationLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            sourceToDestinationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            sourceToDestinationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            sourceToDestinationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            generalRestrictionsLabel.topAnchor.constraint(equalTo: sourceToDestinationLabel.bottomAnchor, constant: 20),
            generalRestrictionsLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            generalRestrictionsLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            generalRestrictionsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            touristsAllowedLabel.topAnchor.constraint(equalTo: generalRestrictionsLabel.bottomAnchor, constant: 10),
            touristsAllowedLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            touristsAllowedLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            touristsAllowedLabel.heightAnchor.constraint(equalToConstant: 20),
            
            businessVisitsAllowedLabel.topAnchor.constraint(equalTo: touristsAllowedLabel.bottomAnchor, constant: 0),
            businessVisitsAllowedLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            businessVisitsAllowedLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            businessVisitsAllowedLabel.heightAnchor.constraint(equalToConstant: 20),
            
            covidPassportRequiredLabel.topAnchor.constraint(equalTo: businessVisitsAllowedLabel.bottomAnchor, constant: 0),
            covidPassportRequiredLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            covidPassportRequiredLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            covidPassportRequiredLabel.heightAnchor.constraint(equalToConstant: 20),
            
            PSRTestForNonResidentsLabel.topAnchor.constraint(equalTo: covidPassportRequiredLabel.bottomAnchor, constant: 0),
            PSRTestForNonResidentsLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            PSRTestForNonResidentsLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            PSRTestForNonResidentsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            PSRTestForResidentsLabel.topAnchor.constraint(equalTo: PSRTestForNonResidentsLabel.bottomAnchor, constant: 0),
            PSRTestForResidentsLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            PSRTestForResidentsLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            PSRTestForResidentsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            generalInformationLabel.topAnchor.constraint(equalTo: PSRTestForResidentsLabel.bottomAnchor, constant: 15),
            generalInformationLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            generalInformationLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            generalInformationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            generalInformationTextLabel.topAnchor.constraint(equalTo: generalInformationLabel.bottomAnchor, constant: 10),
            generalInformationTextLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            generalInformationTextLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            
            restrictionsByVacctinationLabel.topAnchor.constraint(equalTo: generalInformationTextLabel.bottomAnchor, constant: 15),
            restrictionsByVacctinationLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            restrictionsByVacctinationLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            restrictionsByVacctinationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            vaccinatedVisitorsAllowedLabel.topAnchor.constraint(equalTo: restrictionsByVacctinationLabel.bottomAnchor, constant: 10),
            vaccinatedVisitorsAllowedLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            vaccinatedVisitorsAllowedLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            vaccinatedVisitorsAllowedLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dozesRequiredLabel.topAnchor.constraint(equalTo: vaccinatedVisitorsAllowedLabel.bottomAnchor, constant: 0),
            dozesRequiredLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            dozesRequiredLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            dozesRequiredLabel.heightAnchor.constraint(equalToConstant: 20),
            
            MinDaysAfterVaccinationLabel.topAnchor.constraint(equalTo: dozesRequiredLabel.bottomAnchor, constant: 0),
            MinDaysAfterVaccinationLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            MinDaysAfterVaccinationLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            MinDaysAfterVaccinationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            MaxDaysAfterVaccinationLabel.topAnchor.constraint(equalTo: MinDaysAfterVaccinationLabel.bottomAnchor, constant: 0),
            MaxDaysAfterVaccinationLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            MaxDaysAfterVaccinationLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            MaxDaysAfterVaccinationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            restrictionsByNationalityLabel.topAnchor.constraint(equalTo: MaxDaysAfterVaccinationLabel.bottomAnchor, constant: 15),
            restrictionsByNationalityLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            restrictionsByNationalityLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            restrictionsByNationalityLabel.heightAnchor.constraint(equalToConstant: 20),
            
            touristsAllowedByNationalityLabel.topAnchor.constraint(equalTo: restrictionsByNationalityLabel.bottomAnchor, constant: 10),
            touristsAllowedByNationalityLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            touristsAllowedByNationalityLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            touristsAllowedByNationalityLabel.heightAnchor.constraint(equalToConstant: 20),
            
            businessVisitsAllowedByNationalityLabel.topAnchor.constraint(equalTo: touristsAllowedByNationalityLabel.bottomAnchor, constant: 0),
            businessVisitsAllowedByNationalityLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            businessVisitsAllowedByNationalityLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            businessVisitsAllowedByNationalityLabel.heightAnchor.constraint(equalToConstant: 20),
            
            covidPassportRequiredByNationalityLabel.topAnchor.constraint(equalTo: businessVisitsAllowedByNationalityLabel.bottomAnchor, constant: 0),
            covidPassportRequiredByNationalityLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            covidPassportRequiredByNationalityLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            covidPassportRequiredByNationalityLabel.heightAnchor.constraint(equalToConstant: 20),
            
            PCRTestsAcceptedLabel.topAnchor.constraint(equalTo: covidPassportRequiredByNationalityLabel.bottomAnchor, constant: 0),
            PCRTestsAcceptedLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            PCRTestsAcceptedLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            PCRTestsAcceptedLabel.heightAnchor.constraint(equalToConstant: 20),
            
            quickTestsAcceptedLabel.topAnchor.constraint(equalTo: PCRTestsAcceptedLabel.bottomAnchor, constant: 0),
            quickTestsAcceptedLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            quickTestsAcceptedLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            quickTestsAcceptedLabel.heightAnchor.constraint(equalToConstant: 20),
            
            biometricPassportRequiredLabel.topAnchor.constraint(equalTo: quickTestsAcceptedLabel.bottomAnchor, constant: 0),
            biometricPassportRequiredLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            biometricPassportRequiredLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            biometricPassportRequiredLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locatorFormRequiredLabel.topAnchor.constraint(equalTo: biometricPassportRequiredLabel.bottomAnchor, constant: 0),
            locatorFormRequiredLabel.leadingAnchor.constraint(equalTo: sourceToDestinationLabel.leadingAnchor),
            locatorFormRequiredLabel.trailingAnchor.constraint(equalTo: sourceToDestinationLabel.trailingAnchor),
            locatorFormRequiredLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dashedLineView.topAnchor.constraint(equalTo: locatorFormRequiredLabel.bottomAnchor, constant: 15),
            dashedLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dashedLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dashedLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
