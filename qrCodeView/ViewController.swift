//
//  ViewController.swift
//  qrCodeView
//
//  Created by Ayokunle Fatokimi on 25/06/2025.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    // MARK: IB Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var checkSUIViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.generateQRCode(from: AppUtility.sharedInstance.repoInfo,
                                 qrColor: .blue)
        
        checkSUIViewButton.addTarget(self, action: #selector(handelCheckSUIView), for: .touchUpInside)
    }

    
    @objc func handelCheckSUIView() {
        let hostSUIView = UIHostingController(rootView: SUIQRView())
        //present(hostSUIView, animated: true)
        navigationController?.pushViewController(hostSUIView, animated: true)
    }

}

