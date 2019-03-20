//
//  SearchViewController.swift
//  TATSDKSample
//


import UIKit
import TATSDK

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var listCategorySearch: [TATCategory] = []
    var listSearchResult : [TATPlacesSearchResult] = []
    var isUseLocation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        searchTextField.placeholder = "Type here to search"
        // Do any additional setup after loading the view.
        guard !Reachability.isConnectedToNetwork() else { return }
        alert(title: "Internet Connection not Available!")
    }
    
    @IBAction func attractionSeletAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        guard sender.isSelected else { listCategorySearch = listCategorySearch.filter { $0 != .attraction }; return  }
        sender.setImage(UIImage.init(named: "checkbox_selected"), for: .selected)
        listCategorySearch.append(.attraction)
    }
    
    @IBAction func accommodationSeletAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        guard sender.isSelected else { listCategorySearch = listCategorySearch.filter { $0 != .accommodation }; return  }
        sender.setImage(UIImage.init(named: "checkbox_selected"), for: .selected)
        listCategorySearch.append(.accommodation)
    }
    
    @IBAction func restaurantSeletAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        guard sender.isSelected else { listCategorySearch = listCategorySearch.filter { $0 != .restaurant }; return  }
        sender.setImage(UIImage.init(named: "checkbox_selected"), for: .selected)
        listCategorySearch.append(.restaurant)
    }
    
    @IBAction func shopSelectAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        guard sender.isSelected else { listCategorySearch = listCategorySearch.filter { $0 != .shop }; return  }
        sender.setImage(UIImage.init(named: "checkbox_selected"), for: .selected)
        listCategorySearch.append(.shop)
    }
    
    @IBAction func otherSelectAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        guard sender.isSelected else { listCategorySearch = listCategorySearch.filter { $0 != .other }; return  }
        sender.setImage(UIImage.init(named: "checkbox_selected"), for: .selected)
        listCategorySearch.append(.other)
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        guard Reachability.isConnectedToNetwork() else { alert(title: "Internet Connection not Available!"); return }
        search()
    }
    
    @IBAction func isUseLocationSwitch(_ sender: UISwitch) {
       isUseLocation = sender.isOn
    }
    
    func search(){
            /* sample parameter for search place */
    // keyword for search place
        let keyword = self.searchTextField.text ?? ""
    // Location is Tourism Authority of Thailand.
        let lat : Double = 13.74918
        let long : Double  = 100.55785
    // Distance from latitude and longitude point.
        let radius : Double  = 10
    // Number of result.
        let numberOfResult : Double  = 10
       
        let parameter = isUseLocation ? TATPlacesSearchParameter.init(keyword: keyword,
                                                                      latitude: lat,
                                                                      longitude: long,
                                                                      categories: self.listCategorySearch,
                                                                      radius: radius,
                                                                      numberOfResult: numberOfResult,
                                                                      language: TATLanguage.english) :
                                        TATPlacesSearchParameter.init(keyword: keyword,
                                                                      categories: self.listCategorySearch,
                                                                      radius: radius,
                                                                      numberOfResult: numberOfResult,
                                                                      language: TATLanguage.english)

         TATPlacesSearch.executeAsync(parameter) { (result, error) in
                DispatchQueue.main.async {
                    if let result = result {
                        self.listSearchResult = (result.results)!
                    }else if let error = error {
                        print("error", error)
                        self.listSearchResult = []
                    }
                    self.performSegue(withIdentifier: "SearchResultSegue", sender: self)
                }
            }
    }
    
    func alert(title: String) {
        let alert = UIAlertController.init(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: SearchResultViewController.classForCoder()) {
            let resultViewController = segue.destination as? SearchResultViewController
            resultViewController!.listResult = listSearchResult
        }
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
