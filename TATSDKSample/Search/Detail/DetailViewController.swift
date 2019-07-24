//
//  DetailViewController.swift
//  TATSDKSample
//

import UIKit
import TATSDK

enum TypeCell : Int {
    case name = 0
    case address = 1
    case detail = 2
    case tel = 3
    case website = 4
    case facilities = 5
    case services = 6
    case paymentOptions = 7
}

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    
    var id : String! = ""
    var category : TATCategoryCode? = nil
    var detailList : DetailObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.tableFooterView = UIView.init()
        checkGetDetailForCategory(type: category ?? .all)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //style navigation
        title = "Place Detail"
    }
    
    func checkGetDetailForCategory(type: TATCategoryCode){
        guard Reachability.isConnectedToNetwork() else {
            alert(title: "Internet Connection not Available!")
            detailTableView.isHidden = true
            return }
        // check category for get place detail each category
        switch type {
        case .attraction:
            getAttractionInfo()
            break
        case .accommodation:
            getAccommodationInfo()
            break
        case .restaurant:
            getRestaurantInfo()
            break
        case .shop:
            getShopInfo()
            break
        case .other:
            getOtherInfo()
            break
        default:
            print("error")
        }
    }
    
    private func getAttractionInfo(){
        TATPlaces.getAttractionAsync(id: id, language: .english) { (result, error) in
            DispatchQueue.main.async {
                if let result = result {
                    self.detailList = DetailObject.init(attraction: result)
                    self.detailTableView.reloadData()
                }else if let error = error {
                    print("error", error)
                    self.detailTableView.isHidden = true
                }
            }
        }
    }

    private func getAccommodationInfo(){
        TATPlaces.getAccommodationAsync(id: id, language: .english) { (result, error) in
            DispatchQueue.main.async {
                if let result = result {
                    self.detailList = DetailObject.init(accommodation: result)
                    self.detailTableView.reloadData()
                }else if let error = error {
                    print("error", error)
                    self.detailTableView.isHidden = true
                }
            }
        }
    }
    
   private func getRestaurantInfo(){
        TATPlaces.getRestaurantAsync(id: id, language: .english) { (result, error) in
             DispatchQueue.main.async {
                 if let result = result {
                self.detailList = DetailObject.init(restaurant: result)
                self.detailTableView.reloadData()
                 }else if let error = error {
                    print("error", error)
                    self.detailTableView.isHidden = true
                }
            }
        }
    }
    
   private func getShopInfo(){
        TATPlaces.getShopAsync(id: id, language: .english) { (result, error) in
             DispatchQueue.main.async {
                 if let result = result {
                self.detailList = DetailObject.init(shop: result)
                self.detailTableView.reloadData()
                 }else if let error = error {
                    print("error", error)
                    self.detailTableView.isHidden = true
                }
            }
        }
    }
    
   private func getOtherInfo(){
        TATPlaces.getOtherPlaceAsync(id: id, language: .english) { (result, error) in
             DispatchQueue.main.async {
                 if let result = result {
                self.detailList = DetailObject.init(other: result)
                self.detailTableView.reloadData()
                 }else if let error = error {
                    print("error", error)
                    self.detailTableView.isHidden = true
                }
            }
        }
    }
    
    func alert(title: String) {
        let alert = UIAlertController.init(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as? DetailCell
        guard detailList != nil else {
            return UITableViewCell.init()
        }
        switch TypeCell.init(rawValue: indexPath.row)! {
        case .name:
            cell?.setDetail(title: "Name", detail: detailList?.name, isHTMLDetail: false)
            return cell!
        case .address:
            cell?.setDetail(title: "Address", detail: detailList?.address, isHTMLDetail: false)
            return cell!
        case .detail:
            cell?.setDetail(title: "Detail", detail: detailList?.detail, isHTMLDetail: false)
            return cell!
        case .tel:
            cell?.setDetail(title: "Tel", detail: detailList?.tel, isHTMLDetail: false)
            return cell!
        case .website:
            cell?.setDetail(title: "Website", detail: detailList?.website, isHTMLDetail: false)
            return cell!
        case .facilities:
            cell?.setDetail(title: "Facilities", detail: detailList?.facilities, isHTMLDetail: false)
            return cell!
        case .services:
            cell?.setDetail(title: "Services", detail: detailList?.services, isHTMLDetail: false)
            return cell!
        case .paymentOptions:
            cell?.setDetail(title: "Payment options", detail: detailList?.paymentOptions, isHTMLDetail: false)
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}
