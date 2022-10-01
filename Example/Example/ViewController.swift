//
//  ViewController.swift
//  Example
//
//  Created by Danilo Camarotto on 08/03/2022.
//

import UIKit
import DRCUtils
import Combine

struct MyStruct: Decodable {
    let origin: String
    let url: String
}

class ViewController: UIViewController {
    let url = "https://httpbin.org"
    let network = DCNetwork()
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        callAPI()
            .sink { error in
                print(error)
            } receiveValue: { myStruct in
                print(myStruct)
            }.store(in: &cancellables)
    }
    
    private func callAPI() -> Future<MyStruct, NetworkError> {
        network
            .request(url: url,
                     parameterBuilder: DCNetworkRequestBuilder().setPath("/get"))
    }
}
