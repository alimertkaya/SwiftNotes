//
//  AnotherVC.swift
//  SwiftDependencyInjc
//
//  Created by Ali Mert Kaya on 11.09.2023.
//

import Foundation
import UIKit

class AnotherVC: UIViewController {
    
    private let providerProtocol : BackgroundProvider?
    
    init(providerProtocol : BackgroundProvider?){
        self.providerProtocol = providerProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder : NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = providerProtocol?.backgroundColor ?? .white
    }
}
