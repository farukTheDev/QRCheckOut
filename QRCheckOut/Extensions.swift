//
//  Extensions.swift
//  QRCheckOut
//
//  Created by Ömer Faruk KISIK on 11.01.2022.
//

import Foundation
import AudioToolbox
import UIKit
import Firebase

extension UIView {
    func roundCorners(radius: CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func addBorder(color: CGColor, width: CGFloat){
        self.layer.borderWidth = width
        self.layer.borderColor = color
    }
}

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(1519)
    }
}

extension String {
    func generateQRCode() -> UIImage? {
        
        Analytics.logEvent("generated_qr", parameters: nil)
        let data = self.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 12, y: 12)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }

}
