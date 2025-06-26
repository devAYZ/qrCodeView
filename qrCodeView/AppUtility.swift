//
//  AppUtility.swift
//  qrCodeView
//
//  Created by Ayokunle Fatokimi on 25/06/2025.
//

import Foundation
import UIKit
import CoreImage.CIFilterBuiltins

final class AppUtility {
    
    static let sharedInstance = AppUtility()
    
    private init() {}
    
    let repoInfo = "Created by Ayokunle Fatokimi on 25/06/2025 - https://github.com/devAYZ/qrCodeView"
    
    func generateQRCode(from string: String, color: UIColor? = nil) -> UIImage? {
        guard #available(iOS 13.0, *) else {
            let data = string.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            
            if let filter = CIFilter(name: "CIQRCodeGenerator") {
                filter.setValue(data, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 3, y: 3)
                
                
                if var output = filter.outputImage?.transformed(by: transform) {
                    output = transformCIImageUsingColor(image: output, color: color)
                    let size = CGSize(width: 800, height: 800)
                    UIGraphicsBeginImageContextWithOptions(size, false, 0)
                    defer { UIGraphicsEndImageContext() }
                    UIImage(ciImage: output).draw(in: CGRect(origin: .zero, size: size))
                    if let qrcodeImage = UIGraphicsGetImageFromCurrentImageContext() {
                        if let imageData = qrcodeImage.jpegData(compressionQuality: 1){
                            return UIImage(data: imageData)
                        }
                    }
                    
                }
            }
            
            return UIImage(systemName: "xmark.circle")
        }
        
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        if var outputImage = filter.outputImage?.transformed(by: transform) {
            
            outputImage = transformCIImageUsingColor(image: outputImage, color: color)
            
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle")
    }
    
    private func transformCIImageUsingColor(image: CIImage, color: UIColor? = nil)-> CIImage {
        guard let color = color else { return image }
        let colorParameters = [
            "inputColor0": CIColor(color: color), // Foreground
            "inputColor1": CIColor(color: UIColor.clear) // Background
        ]
        return image.applyingFilter("CIFalseColor", parameters: colorParameters)
    }
    
}
