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
                    output = paintCIImage(image: output, withColor: color)
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
            
            outputImage = paintCIImage(image: outputImage, withColor: color)
            
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle")
    }
    
    private func paintCIImage(image: CIImage, withColor: UIColor? = nil)-> CIImage {
        guard let color = withColor else { return image }
        let colorParameters = [
            "inputColor0": CIColor(color: color), // Foreground
            "inputColor1": CIColor(color: UIColor.clear) // Background
        ]
        return image.applyingFilter("CIFalseColor", parameters: colorParameters)
    }
    
    
    @discardableResult
    func generateQRCode_V2(from string: String, qrColor: UIColor? = nil) -> UIImage? {
        let filter = CIFilter.qrCodeGenerator()
        let context = CIContext()
        filter.setValue(Data(string.utf8), forKey: "inputMessage")
        
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        guard let output = filter.outputImage?.transformed(by: transform) else {
            return nil
        }
        
        let coloredOutput = paintCIImage(image: output, withColor: qrColor)
        guard let cgimg = context.createCGImage(coloredOutput, from: coloredOutput.extent) else {
            return nil
        }
        
        return UIImage(cgImage: cgimg)
    }
}
