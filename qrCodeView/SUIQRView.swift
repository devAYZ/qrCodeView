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
                AppUtility.sharedInstance.generateQRCode_V2(from: repoInfo, qrColor: .blue) ?? .init()
            }
            Group {
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
