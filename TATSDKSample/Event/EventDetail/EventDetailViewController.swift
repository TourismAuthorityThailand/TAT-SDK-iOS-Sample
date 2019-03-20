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
    var detailList : TATGetEventDetailResult! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard Reachability.isConnectedToNetwork() else { alert(title: "No internet connection!"); tableView.isHidden = true; return }
        getEventInfo()
    }
    

    private func getEventInfo(){
        TATGetEventDetail.executeAsync(TATGetEventDetailParameter.init(eventId: id, language: TATLanguage.english)) { (result, error) in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as? DetailCell
        guard detailList != nil else {
            return UITableViewCell.init()
        }
        switch EventTypeCell.init(rawValue: indexPath.row)! {
        case .name:
            cell?.setDetail(title: "Name", detail: detailList.name, isHTMLDetail: false)
            return cell!
        case .province:
            cell?.setDetail(title: "Province", detail: !detailList.province.isEmpty ? detailList.province : "-", isHTMLDetail: false)
            return cell!
        case .eventType:
            cell?.setDetail(title: "Event Type", detail: detailList.info.eventType.count > 0 ? detailList.info.eventType.first! : "-", isHTMLDetail: false)
            return cell!
        case .tel:
            cell?.setDetail(title: "Tel", detail: detailList.contact.phones.count > 0 ? detailList.contact.phones.first! : "-", isHTMLDetail: false)
            return cell!
        case .website:
            cell?.setDetail(title: "Website", detail: detailList.contact.urls.count > 0 ? detailList.contact.urls.first! : "-", isHTMLDetail: false)
            return cell!
        case .detail:
            cell?.setDetail(title: "Detail", detail: !detailList.info.htmlDetail.isEmpty ? detailList.info.htmlDetail : "-", isHTMLDetail: true)
            return cell!
    
        }
        
    }
}
