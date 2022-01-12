//
//  CashierViewController.swift
//  QRCheckOut
//
//  Created by Ömer Faruk KISIK on 12.01.2022.
//

import UIKit
import QRCodeReader
import AVFoundation
import Firebase

class CashierViewController: UIViewController {
    
    @IBOutlet weak var operationStatusLabel: UILabel!
    var willShowScanner = true
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            self.showOptionsDialog(to: result!.value)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if willShowScanner {
            readerVC.delegate = self
            readerVC.modalPresentationStyle = .fullScreen
            present(readerVC, animated: true, completion: {
                self.willShowScanner = false
                
            })
        }
    }
    
    func showOptionsDialog(to: String){
        var req = SendNotificationToUserRequest(to: to,
                                                data: nil)
        let alert = UIAlertController(title: "ÖDEME",
                                      message: "Ödeme durumu seçin.",
                                      preferredStyle: .actionSheet)
            
        alert.addAction(
            UIAlertAction(title: "Başarılı",style: .default, handler:{ (UIAlertAction)in
                req.data = NotificationDataNode(payment_status: PaymentData.SUCCEED)
                NetworkUtils.sendPaymentNotification(request: req,
                                                     completionHandler: {(result, err) in
                                                        self.readerVC.dismiss(animated: true, completion: nil)
                                                        if result {
                                                            self.operationStatusLabel.text = "İşlem sonucu iletildi! 👍"
                                                        } else {
                                                            self.operationStatusLabel.text = "İşlem sonucu iletilemedi! 👎"
                                                        }
                                                     })
        }))
            
        alert.addAction(
            UIAlertAction(title:"Devam Ediyor", style: .default, handler:{(UIAlertAction)in
                req.data = NotificationDataNode(payment_status: PaymentData.SUCCEED)
                NetworkUtils.sendPaymentNotification(request: req,
                                                     completionHandler: {(result, err) in
                                                        self.readerVC.dismiss(animated: true, completion: nil)
                                                        if result {
                                                            self.operationStatusLabel.text = "İşlem sonucu iletildi! 👍"
                                                        } else {
                                                            self.operationStatusLabel.text = "İşlem sonucu iletilemedi! 👎"
                                                        }
                                                     })
        }))

        alert.addAction(
            UIAlertAction(title: "Başarısız", style: .destructive, handler:{ (UIAlertAction) in
                req.data = NotificationDataNode(payment_status: PaymentData.SUCCEED)
                NetworkUtils.sendPaymentNotification(request: req,
                                                     completionHandler: {(result, err) in
                                                        self.readerVC.dismiss(animated: true, completion: nil)
                                                        if result {
                                                            self.operationStatusLabel.text = "İşlem sonucu iletildi! 👍"
                                                        } else {
                                                            self.operationStatusLabel.text = "İşlem sonucu iletilemedi! 👎"
                                                        }
                                                     })
        }))
            
        readerVC.present(alert, animated: true, completion: nil)
    }
    
}

extension CashierViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        Analytics.logEvent("read_qr", parameters: nil)
        self.showOptionsDialog(to: result.value)
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
    
}
