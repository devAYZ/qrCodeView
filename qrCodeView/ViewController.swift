//
//  ViewController.swift
//  qrCodeView
//
//  Created by Ayokunle Fatokimi on 25/06/2025.
//

import UIKit

class ViewController: UIViewController {

    // MARK: IB Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //imageView.image = AppUtility.sharedInstance.generateQRCode(from: "", color: .blue)
        
        imageView.generateQRCode(from: "")
    }


}

