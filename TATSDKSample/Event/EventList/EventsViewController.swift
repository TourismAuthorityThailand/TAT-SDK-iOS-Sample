//
//  EventViewController.swift
//  TATSDKSample


import UIKit
import TATSDK

class EventsViewController: UIViewController {
    
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var sortBy : TATEventSortBy = .date
    var eventList : [TATEventInfo] = []
    var idSelected: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView.init()
        guard Reachability.isConnectedToNetwork() else { alert(title: "No internet connection!"); tableView.isHidden = true; return }
        getEvents()
        self.sortLabel.text = "Date"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: EventDetailViewController.classForCoder()) {
            let detailViewController = segue.destination as? EventDetailViewController
            detailViewController?.id = idSelected
        }
    }
    

    @IBAction func sortAction(_ sender: UIButton) {
        guard Reachability.isConnectedToNetwork() else { alert(title: "No internet connection!"); return }
        showActionSheetSort()
    }
    
    func getEvents() {
        
            /* sample parameters get events */
        // Location is Tourism Authority of Thailand.
        let lat : Double = 13.74918
        let long : Double  = 100.55785
        
        // Sort result support: 'distance' or 'date'
        TATEvents.findNearbyAsync(geolocation: TATGeolocation.init(latitude: lat, longitude: long),
                                  sort: .date,
                                  language: .english ) { (result, error) in
                                    DispatchQueue.main.async {
                                        if let result = result {
                                            self.eventList = result
                                        } else if let error = error {
                                            print("error", error)
                                            self.eventList = []
                                        }
                                        self.tableView.reloadData()
                                        self.tableView.isHidden = self.eventList.count == 0
                                    }
        }
    }
    
    func showActionSheetSort() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let date = UIAlertAction(title:  "By date", style: .default , handler:{ (UIAlertAction)in
            self.sortBy = .date
            self.sortLabel.text = "Date"
            self.getEvents()
        })
        
        let distance = UIAlertAction(title:  "By distance", style: .default , handler:{ (UIAlertAction)in
            self.sortBy = .distance
            self.sortLabel.text = "Distance"
            self.getEvents()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
        })
        
        alert.addAction(date)
        alert.addAction(distance)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func alert(title: String) {
        let alert = UIAlertController.init(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "Ok", style: .default,handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

extension EventsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        cell.setDetailCell(info: eventList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        idSelected = eventList[indexPath.row].id
        performSegue(withIdentifier: "EventDetailSegue", sender: self)
    }
}
