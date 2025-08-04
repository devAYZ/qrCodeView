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
    
    @discardableResult
    func generateQRCode(from string: String, qrColor: UIColor? = nil) -> UIImage? {
        let filter = CIFilter.qrCodeGenerator()
        let context = CIContext()
        filter.setValue(Data(string.utf8), forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        guard let output = filter.outputImage?.transformed(by: transform) else {
            return nil
        }
        
        let coloredOutput = paintCIImage(image: output, withColor: qrColor)
        guard let cgImage = context.createCGImage(coloredOutput, from: coloredOutput.extent) else {
            return nil
        }
        
        image = UIImage(cgImage: cgImage)
        return UIImage(cgImage: cgImage)
    }
    
    private func paintCIImage(image: CIImage, withColor: UIColor? = nil) -> CIImage {
        guard let color = withColor else { return image }
        let colorParameters = [
            "inputColor0": CIColor(color: color), // Foreground
            "inputColor1": CIColor(color: UIColor.clear) // Background
        ]
        return image.applyingFilter("CIFalseColor", parameters: colorParameters)
    }
}
