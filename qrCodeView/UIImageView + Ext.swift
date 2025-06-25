//
//  UIImageView + Ext.swift
//  qrCodeView
//
//  Created by Ayokunle Fatokimi on 25/06/2025.
//

import Foundation
import UIKit
import CoreImage.CIFilterBuiltins


extension UIImageView {
    
    func generateQRCode(from string: String, color: UIColor? = nil) {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        if var outputImage = filter.outputImage?.transformed(by: transform) {
            
            outputImage = transformCIImageUsingColor(image: outputImage, color: color)
            
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                image = UIImage(cgImage: cgimg)
                return
            }
        }
        image = UIImage(systemName: "xmark.circle")
    }
    
    private func transformCIImageUsingColor(image: CIImage, color: UIColor? = nil) -> CIImage {
        guard let color = color else { return image }
        let colorParameters = [
            "inputColor0": CIColor(color: color), // Foreground
            "inputColor1": CIColor(color: UIColor.clear) // Background
        ]
        return image.applyingFilter("CIFalseColor", parameters: colorParameters)
    }
}
