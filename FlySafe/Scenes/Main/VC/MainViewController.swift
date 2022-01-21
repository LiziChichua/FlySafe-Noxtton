//
//  MainViewController.swift
//  FlySafe
//
//  Created by LiziChichua on 19.12.21.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func didTapSideMenuButton()
}

class MainViewController: BaseViewController {
    
    var mainView = MainView()
    var gotoRestrictionsVC: (([String : Restrictions], TravelPlan, Bool) -> (Void))?
    let viewModel = MainViewModel()
    weak var delegate: MainViewControllerDelegate?
    
    var userToken: String? {
        didSet {
            //   print (userToken)
        }
    }
    var userTravelPlans: [TravelPlan]?
    var travelPlan: TravelPlan?
    var airportsList: [String]?
    var userData: User? {
        didSet {
            if let name = userData?.data.name {
                DispatchQueue.main.async {
                    self.mainView.greetingLabel.text! += name
                }
            }
        }
    }
    
    @objc func reloadTableview() {
        if let userToken = userToken {
            viewModel.fetchTravelPlans(token: userToken)
        }
    }
    
    
    func checkRestrictionsPressed(_ travelPlan: TravelPlan?, saveButtonEnabled: Bool) {
        //If triggered from saved travelPlans
        if let travelPlan = travelPlan {
            if let userData = userData {
                //                print (travelPlan)
                viewModel.fetchRestrictions(travelPlan: travelPlan, nationality: userData.data.nationality, vaccine: userData.data.vaccine, saveButtonEnabled: saveButtonEnabled)
            } else {
                viewModel.fetchRestrictions(travelPlan: travelPlan, nationality: nil, vaccine: nil, saveButtonEnabled: saveButtonEnabled)
            }
        } else {
            //If triggered from not saved travelPlan
            if let travelPlan = self.travelPlan {
                if let userData = userData {
                    viewModel.fetchRestrictions(travelPlan: travelPlan, nationality: userData.data.nationality, vaccine: userData.data.vaccine, saveButtonEnabled: saveButtonEnabled)
                } else {
                    viewModel.fetchRestrictions(travelPlan: travelPlan, nationality: nil, vaccine: nil, saveButtonEnabled: saveButtonEnabled)
                }
            } else {
                (mainView.homeTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! CheckResstrictionsButton).checkRestrictions.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
            }
        }
    }
    
    
    func didTapEdit(travelPlan: TravelPlan) {
        let vc = PopOverViewController()
        vc.didPressSave = { [weak self] travelPlan in
            if let userToken = self?.userToken{
                self?.viewModel.editTravelPlan(token: userToken, travelPlan: travelPlan)
            }
        }
        vc.travelPlan = travelPlan
        vc.airportsList = self.airportsList
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func didTapDelete(flightID: String) {
        let actionSheet = UIAlertController(title: "Do you want to delete your flight?", message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            if let userToken = self?.userToken {
                self?.viewModel.deleteTravelPlan(token: userToken, flightID: flightID)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    func initialiseVMClosures(viewmodel: MainViewModel) {
        
        viewmodel.airportsDidFetch = { [weak self] result in
            var airports = [String]()
            result.forEach { airport in
                airports.append("\(airport.code), \(airport.city), \(airport.country)")
            }
            self?.airportsList = airports
            DispatchQueue.main.async {
                self?.mainView.homeTableView.reloadData()
            }
        }
        
        viewmodel.didFetchUserData = { [weak self] result in
            self?.userData = result
        }
        
        
        viewmodel.travelPlansDidFetch = { [weak self] result in
            self?.userTravelPlans = result
            DispatchQueue.main.async {
                self?.mainView.homeTableView.reloadData()
            }
        }
        
        
        viewmodel.travelPlanDidEdit = { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    let alert = UIAlertController(title: "Success", message: "Travel plan succesfylly edited", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in
                        self?.reloadTableview()
                    }))
                    self?.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "Failure", message: "Travel plan couldn't be edited", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in
                        self?.reloadTableview()
                    }))
                    self?.present(alert, animated: true)
                }
            }
            
        }
        
        
        viewmodel.travelPlanDidRemove = { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    let alert = UIAlertController(title: "Success", message: "Travel plan succesfylly deleted", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in
                        self?.reloadTableview()
                    }))
                    self?.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "Failure", message: "Travel plan couldn't be deleted", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in
                        self?.reloadTableview()
                    }))
                    self?.present(alert, animated: true)
                }
            }
            
        }
        
        viewmodel.didFetchLocation = { location in
            let lat = Double(location.coordinate.longitude)
            let long = Double(location.coordinate.longitude)
            viewmodel.fetchWeather(lat: lat, lon: long)
        }
        
        
        viewmodel.restrictionsDidFetch = { [weak self] dict, flightInfo, saveButtonEnabled in
            if let travelPlan = self?.travelPlan {
                DispatchQueue.main.async {
                    (self?.mainView.homeTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! CheckResstrictionsButton).checkRestrictions.stopAnimation(animationStyle: .normal, revertAfterDelay: 0.5)
                    self?.gotoRestrictionsVC?(dict, travelPlan, saveButtonEnabled)
                }
            } else if let flightInfo = flightInfo {
                self?.gotoRestrictionsVC?(dict, flightInfo, saveButtonEnabled)
            }
        }
        
        viewmodel.didFetchWeather = { [weak self] weatherInfo in
            DispatchQueue.main.async {
                self?.mainView.locationLabel.text = "\(weatherInfo.location?.name ?? ""), \(weatherInfo.location?.country ?? "")"
                self?.mainView.temperatureLabel.text = "\(weatherInfo.currentInfo?.celsius ?? 0)°C"
            }
        }
    }
    
    
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set listener for new travel plan entries.
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(reloadTableview), name: Notification.Name("TravelPlanAdded"), object: nil)
        
        //Set closures for viewmodel
        initialiseVMClosures(viewmodel: viewModel)
        
        //Set user token in viewModel
        viewModel.userToken = userToken
        
        //Register TV Cells
        mainView.homeTableView.register(HomeTVTopCell.self, forCellReuseIdentifier: "HomeTVTopCell")
        mainView.homeTableView.register(SummaryListTitleCell.self, forCellReuseIdentifier: "SummaryListTitleCell")
        mainView.homeTableView.register(HomeTVBottomCell.self, forCellReuseIdentifier: "HomeTVBottomCell")
        mainView.homeTableView.register(CheckResstrictionsButton.self, forCellReuseIdentifier: "CheckResstrictionsButton")
        
        //Set TV delegate and datasource
        mainView.homeTableView.delegate = self
        mainView.homeTableView.dataSource = self
        
        hideKeyboardWhenTappedAround()
        
        self.navigationController?.isNavigationBarHidden = true
        mainView.menuButton.addTarget(self, action: #selector(sideMenuButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func sideMenuButtonPressed() {
        delegate?.didTapSideMenuButton()
    }
}

/////MARK: - Extensions

//Tableview delegate methods
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//Tableview datasource methods
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let travelPlans = userTravelPlans{
            return 3 + travelPlans.count
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVTopCell", for: indexPath) as! HomeTVTopCell
            cell.airportsList = self.airportsList
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckResstrictionsButton", for: indexPath) as! CheckResstrictionsButton
            cell.restrictionsDidGetPressed = { [weak self] travelPlan in
                self?.checkRestrictionsPressed(travelPlan, saveButtonEnabled: true)
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryListTitleCell", for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVBottomCell", for: indexPath) as! HomeTVBottomCell
            cell.allignSubviews()
            cell.restrictionsDidGetPressed = { [weak self] travelPlan in
                self?.checkRestrictionsPressed(travelPlan, saveButtonEnabled: false)
            }
            cell.editPressed = { [weak self] tripPlan in
                self?.didTapEdit(travelPlan: tripPlan)
            }
            cell.deletePressed = { [weak self] planID in
                self?.didTapDelete(flightID: planID)
            }
            if let travelPlanList = userTravelPlans {
                let travelPlan = travelPlanList[indexPath.row - 3]
                cell.travelPlan = travelPlan
            }
            return cell
        }
        
    }
    
}


//Update local values whenever user changes them
extension MainViewController: FlightInfoFieldsDelegate {
    
    func didMakeSelection(flightStructure: [(FlightTypes, String)], date: Date) {
        var source: String?
        var transfer: String?
        var destination: String?
        var dateString: String?
        
        if flightStructure[0].1 != "" {
            let sourceArray = flightStructure[0].1.components(separatedBy: ",")
            if let sourceID = sourceArray.first{
                source = sourceID
            }
        }
        
        if flightStructure[flightStructure.count-1].1 != "" {
            let destinationArray = flightStructure[flightStructure.count-1].1.components(separatedBy: ",")
            if let destinationID = destinationArray.first {
                destination = destinationID
            }
        }
        
        var tempTransferList = [String]()
        
        flightStructure.filter { $0.0 == .transfer }.forEach ({
            let transferArray = $0.1.components(separatedBy: ",")
            if let transferID = transferArray.first {
                tempTransferList.append(transferID)
            }
        })
        
        transfer = tempTransferList.joined(separator: ",")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateString = formatter.string(from: date)
        
        if let source = source, let destination = destination, let transfer = transfer, let date = dateString {
            self.travelPlan = TravelPlan(source: source, destination: destination, date: date, transfer: transfer, user: nil, id: nil)
        }
        
    }
    
}

