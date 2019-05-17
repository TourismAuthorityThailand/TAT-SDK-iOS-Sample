//
//  RouteDetailViewController.swift
//  TATSDKSample


import UIKit
import TATSDK

class RouteDetailViewController: UIViewController {
    
    
    @IBOutlet weak var routeDetailTableView: UITableView!
    
    var id : String = ""
    var routeDetail : TATRouteDetail! = nil
    var stopsOnMap : [TATStop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getRouteDetail()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: RouteMapViewController.classForCoder()) {
            let routeMapViewController = segue.destination as? RouteMapViewController
            routeMapViewController?.stops = stopsOnMap
        }
    }
    

    func getRouteDetail(){
        // route id is parameter for get route detail
        TATRecommendedRoutes.getDetailAsync(id: id, language: .english) { (result, error) in
            DispatchQueue.main.async {
                if let result = result {
                    self.routeDetail = result
                } else {
                    print("error",error!)
                    self.routeDetailTableView.isHidden = true
                }
                self.routeDetailTableView.reloadData()
            }
        }
    }
    
    @IBAction func viewOnMapAction(_ sender: UIButton) {
        stopsOnMap = routeDetail.days[sender.tag].stops!
        performSegue(withIdentifier: "RouteMapSegue", sender: self)
    }
}

extension RouteDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return routeDetail == nil ? 0 : routeDetail.days.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? HeaderCell
        cellHeader?.setDetailCell(day: section + 1, index: section)
        return cellHeader!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeDetail.days[section].stops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteDetailCell") as? RouteDetailCell
        cell?.setDetailCell(info: routeDetail.days[indexPath.section].stops[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
