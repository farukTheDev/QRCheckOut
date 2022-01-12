//
//  CustomerViewController.swift
//  QRCheckOut
//
//  Created by Ömer Faruk KISIK on 12.01.2022.
//

import UIKit

class CustomerViewController: UIViewController {

    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var paymentStatusLabel: UILabel!
    
    var paymentStatus = PaymentData.STAND_BY {
        didSet {
            switch paymentStatus {
            case PaymentData.IN_PROGRESS:
                paymentStatusLabel.backgroundColor = .systemYellow
            case PaymentData.SUCCEED:
                paymentStatusLabel.backgroundColor = .systemGreen
            case PaymentData.FAILED:
                paymentStatusLabel.backgroundColor = .systemRed
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentStatusLabel.roundCorners(radius: 2)
        guard let token = KeychainManager.getString(key: "fcmToken") else {
            return
        }
        qrCodeImageView.image = token.generateQRCode()
    }
    
}
