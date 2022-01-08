//
//  MainViewController.swift
//  FlySafe
//
//  Created by LiziChichua on 19.12.21.
//

import UIKit

class MainViewController: BaseViewController {
    
    var mainView = MainView()
    var gotoRestrictionsVC: (([String : Restrictions]) -> (Void))?
    let viewModel = MainViewModel()
    
    var source: String?
    var destination: String?
    var transfer: String?
    var date: String?
    var airportsList: [String]?
    
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
        
        
        viewmodel.travelPlanDidAdd = { [weak self] success in
            if success {
                let alert = UIAlertController(title: "Success", message: "Travel plan succesfylly added", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self?.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Failure", message: "Travel plan couldn't be added", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self?.present(alert, animated: true)
            }
        }
        
        
        viewmodel.travelPlanDidEdit = { [weak self] success in
            if success {
                let alert = UIAlertController(title: "Success", message: "Travel plan succesfylly edited", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self?.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Failure", message: "Travel plan couldn't be edited", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self?.present(alert, animated: true)
            }
        }
        
        
        viewmodel.travelPlanDidRemove = { [weak self] success in
            if success {
                let alert = UIAlertController(title: "Success", message: "Travel plan succesfylly deleted", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self?.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Failure", message: "Travel plan couldn't be deleted", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self?.present(alert, animated: true)
            }
        }
        
        
        viewmodel.restrictionsDidFetch = { [weak self] dict in
            self?.gotoRestrictionsVC?(dict)
        }
        
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Set closures for viewmodel
        initialiseVMClosures(viewmodel: viewModel)
        
        //Register TV Cells
        mainView.homeTableView.register(HomeTVTopCell.self, forCellReuseIdentifier: "HomeTVTopCell")
        mainView.homeTableView.register(HomeTVBottomCell.self, forCellReuseIdentifier: "HomeTVBottomCell")
        mainView.homeTableView.register(CheckResstrictionsButton.self, forCellReuseIdentifier: "CheckResstrictionsButton")
        
        //Set TV delegate and datasource
        mainView.homeTableView.delegate = self
        mainView.homeTableView.dataSource = self
        
        hideKeyboardWhenTappedAround()
        
        self.navigationController?.isNavigationBarHidden = true
    }
}

/////MARK: - Extensions

extension MainViewController: CheckRestrictionsDelegate {
    func checkRestrictionsPressed() {
        guard let source = self.source else {return}
        guard let destination = self.destination else {return}
        guard let date = self.date else {return}
        
        viewModel.fetchRestrictions(flightInfo: Flight(source: source, destination: destination, date: date), nationality: nil, vaccine: nil, transfer: transfer)
    }
}

//Tableview delegate methods
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//Tableview datasource methods
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVTopCell", for: indexPath) as! HomeTVTopCell
            if let airports = airportsList {
                cell.sourceAirport.optionArray = airports
                cell.transferAirport.optionArray = airports
                cell.destinationAirport.optionArray = airports
            }
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckResstrictionsButton", for: indexPath) as! CheckResstrictionsButton
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVBottomCell", for: indexPath) as! HomeTVBottomCell
            cell.delegate = self
            cell.tripPlan = TripPlan(source: "TBS", destination: "WSW", connections: ["SWF","KLP", "KHI", "SWF","KLP", "KHI"], date: "Tomorrow")
            return cell
        }
    
    }
    
}


//Update local values whenever user changes them
extension MainViewController: FlightInfoFieldsDelegate {
    func didSelectFlightDate(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.date = formatter.string(from: date)
    }
    
    func didSelectSource(source: String) {
        let sourceArray = source.components(separatedBy: ",")
        let sourceID = sourceArray.first
        self.source = sourceID
    }
    
    func didSelectDestination(destination: String) {
        let destinationArray = destination.components(separatedBy: ",")
        let destinationID = destinationArray.first
        self.destination = destinationID
    }
    
    func didSelectTransfer(transfer: String) {
        let transferArray = transfer.components(separatedBy: ",")
        let transferID = transferArray.first
        self.transfer = transferID
    }
    
}

