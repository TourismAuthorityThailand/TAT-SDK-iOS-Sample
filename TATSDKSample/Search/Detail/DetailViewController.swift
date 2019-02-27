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
    var category : TATCategory! = .all
    var detailList : DetailObject! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.tableFooterView = UIView.init()
        checkGetDetailForCategory(type: category)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //style navigation
        title = "Place Detail"
    }
    
    func checkGetDetailForCategory(type: TATCategory){
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
        TATGetAttractionDetail.executeAsync(TATGetPlaceDetailParameter.init(placeId: id, language: TATLanguage.english)) { (result, error) in
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
        TATGetAccommodationDetail.executeAsync(TATGetPlaceDetailParameter.init(placeId: id, language: TATLanguage.english)) { (result, error) in
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
        TATGetRestaurantDetail.executeAsync(TATGetPlaceDetailParameter.init(placeId: id, language: TATLanguage.english)) { (result, error) in
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
        TATGetShopDetail.executeAsync(TATGetPlaceDetailParameter.init(placeId: id, language: TATLanguage.english)) { (result, error) in
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
        TATGetOtherPlaceDetail.executeAsync(TATGetPlaceDetailParameter.init(placeId: id, language: TATLanguage.english)) { (result, error) in
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
            cell?.setDetail(title: "Name", detail: detailList.name)
            return cell!
        case .address:
            cell?.setDetail(title: "Address", detail: detailList.address)
            return cell!
        case .detail:
            cell?.setDetail(title: "Detail", detail: detailList.detail)
            return cell!
        case .tel:
            cell?.setDetail(title: "Tel", detail: detailList.tel)
            return cell!
        case .website:
            cell?.setDetail(title: "Website", detail: detailList.website)
            return cell!
        case .facilities:
            cell?.setDetail(title: "Facilities", detail: detailList.facilities)
            return cell!
        case .services:
            cell?.setDetail(title: "Services", detail: detailList.services)
            return cell!
        case .paymentOptions:
            cell?.setDetail(title: "Payment options", detail: detailList.paymentOptions)
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}
