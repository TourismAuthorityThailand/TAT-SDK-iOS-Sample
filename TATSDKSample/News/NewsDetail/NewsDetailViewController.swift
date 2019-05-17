//
//  NewsDetailViewController.swift
//  TATSDKSample


import UIKit
import TATSDK


enum NewsTypeCell : Int {
    case name = 0
    case date = 1
    case location = 2
    case website = 3
    case detail = 4
   
}

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var newsDetailTableView: UITableView!
    
    var id : String! = nil
    var detailList : TATNewsDetail! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard Reachability.isConnectedToNetwork() else { alert(title: "No internet connection!"); newsDetailTableView.isHidden = true; return }
        getNewsDetail()
    }

    func getNewsDetail() {
        TATNews.getDetailAsync(id: id, language: .english ) { (result, error) in
            DispatchQueue.main.async {
                if let result = result {
                    self.detailList = result
                    self.newsDetailTableView.isHidden = false
                }else if let error = error {
                    print("error", error)
                    self.newsDetailTableView.isHidden = true
                }
                self.newsDetailTableView.reloadData()
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

extension NewsDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as? DetailCell
        guard detailList != nil else {
            return UITableViewCell.init()
        }
        switch NewsTypeCell.init(rawValue: indexPath.row)! {
        case .name:
            cell?.setDetail(title: "Name", detail: detailList.name, isHTMLDetail: false)
            return cell!
        case .date:
            cell?.setDetail(title: "Publish date", detail: !detailList.displayPublishedDate.isEmpty ? detailList.displayPublishedDate : "-", isHTMLDetail: false)
            return cell!
        case .location:
            cell?.setDetail(title: "Location", detail: !detailList.location.isEmpty ? detailList.location : "-", isHTMLDetail: false)
            return cell!
        case .website:
            cell?.setDetail(title: "Website", detail: detailList.urls?.count ?? 0 > 0 ? detailList.urls?.first?.absoluteString ?? "" : "-", isHTMLDetail: false)
            return cell!
        case .detail:
            cell?.setDetail(title: "Detail", detail: !detailList.htmlDetail.isEmpty ? detailList.htmlDetail : "-", isHTMLDetail: true)
            return cell!
       
        }
        
    }
}
