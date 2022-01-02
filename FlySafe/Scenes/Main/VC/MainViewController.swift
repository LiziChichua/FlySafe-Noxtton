//
//  MainViewController.swift
//  FlySafe
//
//  Created by LiziChichua on 19.12.21.
//

import UIKit

class MainViewController: BaseViewController {
    
    //Networking test
    let networkService = DefaultNetworkService()
    var mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Register TV Cells
        mainView.homeTableView.register(HomeTVTopCell.self, forCellReuseIdentifier: "HomeTVTopCell")
        mainView.homeTableView.register(HomeTVBottomCell.self, forCellReuseIdentifier: "HomeTVBottomCell")
        
        //Set TV delegate and datasource
        mainView.homeTableView.delegate = self
        mainView.homeTableView.dataSource = self
        
        
        self.navigationController?.isNavigationBarHidden = true
        let apiManager = APIManager(with: networkService)
        apiManager.onError = { error in
            print (error)
        }
        
        //Works
//        apiManager.fetchSelf(token: "ad7ddf1f-1960-4599-be6e-c76d74798c17") { Response in
//            if let response = Response{
//                print (response.user)
//            }
//        }
       
        //Works
//        apiManager.createUser(userEmail: "nicolas45@gmail.com", userPassword: "123", userData: UserData(nationality: "Georgian", vaccine: "pfizer")) { response in
//            print (response)
//            }
        
        //Works
//        apiManager.addTravelPlan(token: "4d3f3196-d3eb-414f-91b6-2fb42d92426c", flightInfo: Flight(source: "TBS", destination: "GVA", date: "2021-12-19T18:38:00")) { response in
//            print (response?.travelPlan)
//        }
         
        //Works
//        apiManager.fetchAirports { airports in
//            print (airports)
//        }
        
        //Works
//        apiManager.logInUser(userEmail: "nika@example.com", userPassword: "123") { response in
//            print (response)
//        }
        
        //Works
//        apiManager.fetchVaccines { vaccines in
//            print (vaccines)
//        }
        
        //Works
//        apiManager.deleteTravelPlan(token: "3146379b-9e2d-4d5b-9410-18589cc10c80", flightID: "61bbabd93afbbefffa5b56c9") { response in
//            print (response)
//        }
        
        //Works
//        apiManager.editTravelPlan(token: "3146379b-9e2d-4d5b-9410-18589cc10c80", flightInfo: Flight(source: "TBS", destination: "GVA", date: "2022-12-19T18:38:50"), flightID: "61bbabd93afbbefffa5b56c9") { response in
//            print(response)
//        }
        
        //Works with or without given nationality, vaccine and transfer information
//        apiManager.fetchRestrictions(flight: Flight(source: "TBS", destination: "GVA", date: ""), nationality: nil, vaccine: nil, transfer: nil) { result in
//            print (result)
//        }
        
    }


}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVTopCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVBottomCell", for: indexPath)
            return cell
        }
    }
    
    
}
