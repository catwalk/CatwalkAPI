//
//  ViewController.swift
//  Copyright © 2021 CATWALK. All rights reserved.
//

import UIKit
import CatwalkAPI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createRequest()
        
    }
    
    func createRequest() {
        CTWAPIClient.shared.apiToken = "YOUR_TOKEN"

        CTWAPIClient.shared.fetchSimilars(for: "YOUR_SKU") { (result: Result<[String], CTWAPIClient.CTWAPIServiceError>) in
            switch result {
                case .success(let similars):
                    print(similars)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }


}

