//
//  MainViewController.swift
//  TATSDKSample


import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // go to sample place search page
    @IBAction func placeSearchAction(_ sender: Any) {
        performSegue(withIdentifier: "PlaceSearchSegue", sender: self)
    }
    
    // go to sample events page
    @IBAction func eventsAction(_ sender: Any) {
        performSegue(withIdentifier: "EventSegue", sender: self)
    }
    
    @IBAction func newsAction(_ sender: Any) {
        performSegue(withIdentifier: "NewsSegue", sender: self)
    }
    
    @IBAction func routesAction(_ sender: Any) {
        performSegue(withIdentifier: "RecommendedRoutesSegue", sender: self)
    }
}
