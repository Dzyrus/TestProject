//
//  ViewController.swift
//  TestProject
//
//  Created by Daria on 23/09/2019.
//  Copyright © 2019 D.Misch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var barcodeBar: UITextField!
    
    @IBAction func barcodeScanButton(_ sender: UIButton) {
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func tapped (gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc: DetailViewController = segue.destination as! DetailViewController
        dvc.scannedBarcode = barcodeBar.text!
    }

}
