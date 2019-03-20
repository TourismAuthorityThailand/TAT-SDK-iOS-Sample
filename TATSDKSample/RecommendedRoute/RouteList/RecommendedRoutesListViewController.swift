//
//  RecommendedRoutesListViewController.swift
//  TATSDKSample


import UIKit
import TATSDK

class RecommendedRoutesListViewController: UIViewController {

    @IBOutlet weak var routesTableView: UITableView!
    
    var routesResult : [TATGetRoutesResult] = []
    var idSelected : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        routesTableView.tableFooterView = UIView.init()
        guard Reachability.isConnectedToNetwork() else { routesTableView.isHidden = true; return }
        guard routesResult.count > 0 else { routesTableView.isHidden = true; return }
        routesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: RouteDetailViewController.classForCoder()) {
            let routeDetailViewController = segue.destination as? RouteDetailViewController
            routeDetailViewController?.id = idSelected
        }
    }
    
    func alert(title: String) {
        let alert = UIAlertController.init(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "Ok", style: .default,handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

extension RecommendedRoutesListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routesResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteListCell") as? RouteListCell
        cell?.setDetailCell(info: routesResult[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idSelected = routesResult[indexPath.row].routeId
        tableView.deselectRow(at: indexPath, animated: true)
        guard Reachability.isConnectedToNetwork() else { alert(title: "No internet connection!"); return }
        performSegue(withIdentifier: "RouteDetailSegue", sender: self)
    }
    
}
