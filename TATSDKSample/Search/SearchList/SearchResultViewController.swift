//
//  SearchResultViewController.swift
//  TATSDKSample
//

import UIKit
import TATSDK

class SearchResultViewController: UIViewController {

    @IBOutlet weak var resultTable: UITableView!
    var listResult : [TATPlace]? = []
    var idSelected: String = ""
    var categorySelected : TATCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTable.tableFooterView = UIView.init()
        guard let listResult = listResult, listResult.count > 0 else {
            resultTable.isHidden = true
            return
        }
        resultTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // style navigation
        title = "Search Result"
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: DetailViewController.classForCoder()) {
            let detailViewController = segue.destination as? DetailViewController
            detailViewController?.id = idSelected
            detailViewController?.category = categorySelected?.code
        }
    }
}

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as? SearchResultCell
        cell?.setDetail(info: listResult?[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        idSelected = listResult?[indexPath.row].id ?? ""
        categorySelected = listResult?[indexPath.row].category
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }
}
