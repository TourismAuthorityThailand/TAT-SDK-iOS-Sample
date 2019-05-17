//
//  RecommendedRoutesViewController.swift
//  TATSDKSample


import UIKit
import TATSDK

enum EnumRegion {
    case all
    case central
    case southern
    case northern
    case northEastern
    case eastern
    case western
    
    func convertToTATRegion() -> TATRegion? {
        switch self {
        case .all:
            return nil
        case .central:
            return TATRegion.central
        case .southern:
            return TATRegion.southern
        case .northern:
            return TATRegion.northern
        case .northEastern:
            return TATRegion.northEastern
        case .eastern:
            return TATRegion.eastern
        case .western:
            return TATRegion.western
        }
    }
    
    func getFullName() -> String {
        switch self {
        case .all:
            return "All"
        case .central:
            return "Central"
        case .southern:
            return "Southern"
        case .northern:
            return "Northern"
        case .northEastern:
            return "NorthEastern"
        case .eastern:
            return "Eastern"
        case .western:
            return "Western"
        }
    }
}

class RecommendedRoutesViewController: UIViewController {

    @IBOutlet weak var dayListPicker: UIPickerView!
    @IBOutlet weak var regionListPicker: UIPickerView!
    @IBOutlet var heightDayList: NSLayoutConstraint!
    @IBOutlet var heightRegionList: NSLayoutConstraint!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var regionButton: UIButton!
    
    // condition list parameter for search route
    var dayList = ["Unknown","1 Day","2 Days","3 Days","4 Days","5 Days","6 Days","7 Days","8 Days","9 Days","10 Days","11 Days","12 Days"]
    var region : [EnumRegion] = [.all, .northern, .northEastern,.central, .western, .eastern ,.southern]

    var isUseLocation = true
    var routesResult : [TATRouteInfo] = []
    
    // number of day for route search
    var daySelected : Int = 0
    
    // region for route search
    var regionSelected : EnumRegion = .all
    
    // Location is Tourism Authority of Thailand.
    let lat : Double = 13.74918
    let long : Double  = 100.55785
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // style button
        dayButton.setTitle("Unknown", for: .normal)
        regionButton.setTitle(EnumRegion.all.getFullName(), for: .normal)
        dayButton.layer.borderWidth = 1
        dayButton.layer.borderColor = UIColor.gray.cgColor
        regionButton.layer.borderWidth = 1
        regionButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: RecommendedRoutesListViewController.classForCoder()){
            let routesListViewController = segue.destination as? RecommendedRoutesListViewController
            routesListViewController?.routesResult = routesResult
        }
    }
    
    func getRecommendRoutes() {
            /* sample parameter for recommended routes search */
        let dayParam = daySelected == 0 ? nil : daySelected
        
        var location: TATGeolocation? = nil
        if isUseLocation {
            location = TATGeolocation.init(latitude: lat, longitude: long)
        }
        
        TATRecommendedRoutes.findAsync(numberOfDays: dayParam, geolocation: location, region: regionSelected.convertToTATRegion(), language: .english ) { (result, error) in
            DispatchQueue.main.async {
                if let result = result {
                    self.routesResult = result
                } else if let error = error {
                    print("error", error)
                    self.routesResult = []
                }
                self.performSegue(withIdentifier: "RouteListSegue", sender: self)
            }
        }
    }

    @IBAction func dayAction(_ sender: UIButton) {
        heightDayList.isActive = !heightDayList.isActive
    }
    
    @IBAction func regionAction(_ sender: UIButton) {
        heightRegionList.isActive = !heightRegionList.isActive
    }
    
    @IBAction func searchRoutesAction(_ sender: Any) {
        guard Reachability.isConnectedToNetwork() else { alert(title:  "No internet connection!"); return }
        getRecommendRoutes()
    }
    
    @IBAction func isUseLocationSwitch(_ sender: UISwitch) {
        isUseLocation = sender.isOn
    }
    
    func alert(title: String) {
        let alert = UIAlertController.init(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "Ok", style: .default,handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

extension RecommendedRoutesViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == dayListPicker {
            return dayList.count
        } else {
           return region.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == dayListPicker {
            return dayList[row]
        } else {
            return region[row].getFullName()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dayListPicker {
            dayButton.setTitle(dayList[row], for: .normal)
            daySelected = row
        } else {
            regionButton.setTitle(region[row].getFullName(), for: .normal)
            regionSelected = region[row]
        }
    }
}
