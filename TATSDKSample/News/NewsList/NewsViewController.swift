//
//  NewsViewController.swift
//  TATSDKSample


import UIKit
import TATSDK

class NewsViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    var newsList : [TATNewsInfo] = []
    var idSelected : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.tableFooterView = UIView.init()
        guard Reachability.isConnectedToNetwork() else { alert(title: "No internet connection!"); newsTableView.isHidden = true; return }
        getNews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: NewsDetailViewController.classForCoder()) {
            let detailViewController = segue.destination as? NewsDetailViewController
            detailViewController?.id = idSelected
        }
    }
    
    func getNews(){
        TATNews.feedAsync(language: .english) { (result, error) in
            DispatchQueue.main.async {
                if let result = result {
                    self.newsList = (result)
                }else if let error = error {
                    print("error", error)
                    self.newsList = []
                }
                self.newsTableView.reloadData()
                self.newsTableView.isHidden = self.newsList.count == 0
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

extension NewsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        cell.setDetailCell(info: newsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        idSelected = newsList[indexPath.row].id
        performSegue(withIdentifier: "NewsDetailSegue", sender: self)
    }
}
