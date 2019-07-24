//
//  EventDetailViewController.swift
//  TATSDKSample
//

import UIKit
import TATSDK

enum EventTypeCell: Int {
    case name = 0
    case province = 1
    case eventType = 2
    case tel = 3
    case website = 4
    case detail = 5
   
}

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var id: String = ""
    var detailList : TATEventDetail? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard Reachability.isConnectedToNetwork() else { alert(title: "No internet connection!"); tableView.isHidden = true; return }
        getEventInfo()
    }
    

    private func getEventInfo(){
        TATEvents.getDetailAsync(id: id, language: .english) { (result, error) in
            DispatchQueue.main.async {
                if let result = result {
                    self.detailList = result
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                }else if let error = error {
                    print("error", error)
                    self.tableView.isHidden = true
                }
            }
        }
    }
    
    func alert(title: String) {
        let alert = UIAlertController.init(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "Ok", style: .default,handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}


extension EventDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as? DetailCell,
            detailList != nil
            else { return UITableViewCell.init() }
        switch EventTypeCell.init(rawValue: indexPath.row)! {
        case .name:
            cell.setDetail(title: "Name", detail: detailList?.name, isHTMLDetail: false)
            return cell
        case .province:
            var text = "-"
            if let content = detailList?.location { text = content }
            cell.setDetail(title: "Province", detail: text, isHTMLDetail: false)
            return cell
        case .eventType:
            var text = "-"
            if let content = detailList?.information?.eventTypes?.first { text = content }
            cell.setDetail(title: "Event Type", detail: text, isHTMLDetail: false)
            return cell
        case .tel:
            var text = "-"
            if let content = detailList?.contact?.phones?.first { text = content }
            cell.setDetail(title: "Tel", detail: text, isHTMLDetail: false)
            return cell
        case .website:
            var text = "-"
            if let content = detailList?.contact?.urls?.first?.absoluteString { text = content }
            cell.setDetail(title: "Website", detail: text, isHTMLDetail: false)
            return cell
        case .detail:
            var text = "-"
            if let content = detailList?.information?.htmlDetail { text = content }
            cell.setDetail(title: "Detail", detail: text, isHTMLDetail: true)
            return cell
    
        }
        
    }
}
