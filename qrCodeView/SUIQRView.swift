//
//  SUIQRView.swift
//  qrCodeView
//
//  Created by Ayokunle Fatokimi on 25/06/2025.
//

import SwiftUI

struct SUIQRView: View {
    
    let repoInfo = AppUtility.sharedInstance.repoInfo
    
    var body: some View {
        VStack {
            var qrImage: UIImage {
                AppUtility.sharedInstance.generateQRCode(from: repoInfo) ?? .init()
            }
            Group {
//                Image(systemName: "xmark.circle")
//                    .resizable()
                Image(uiImage: qrImage)
                    .resizable()
            }
            .frame(width: 300, height: 300)
        }
    }
}

#Preview {
    SUIQRView()
}
