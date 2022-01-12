//
//  ViewController.swift
//  QRCheckOut
//
//  Created by Ömer Faruk KISIK on 11.01.2022.
//

import UIKit

class HomeViewController: UIViewController {

   
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var cashierView: UIView!
    
    @IBOutlet weak var customerView: UIView!
    
    override func viewDidLoad() {
        setGradientBackground()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func setGradientBackground() {
        let colorTop = UIColor.clear.cgColor
        let colorBottom = UIColor.black.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0,
                                     y: self.view.frame.height/2,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height/2)
            //self.view.bounds
        
        bgImageView.layer.insertSublayer(gradientLayer, at:0)
        
        cashierView.roundCorners(radius: 8)
        cashierView.addBorder(color: UIColor.label.cgColor, width: 2)
        cashierView.addGestureRecognizer(
            UITapGestureRecognizer(target: self,
                                   action: #selector(onTapCashier(_:)))
        )
        
        customerView.roundCorners(radius: 8)
        customerView.addBorder(color: UIColor.label.cgColor, width: 2)
        customerView.addGestureRecognizer(
            UITapGestureRecognizer(target: self,
                                   action: #selector(onTapCustomer(_:)))
        )
    }
    
    @objc func onTapCashier(_ sender: UITapGestureRecognizer){
        UIDevice.vibrate()
        performSegue(withIdentifier: "showCashierViewControllerAsModal",
                     sender: nil)
    }
    
    @objc func onTapCustomer(_ sender: UITapGestureRecognizer){
        UIDevice.vibrate()
        performSegue(withIdentifier: "showCustomerViewControllerAsModal",
                     sender: nil)
    }
    
    @IBAction func onTapCrash(_ sender: Any) {
        assert(false)
    }
    
}

