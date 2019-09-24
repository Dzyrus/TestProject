//
//  DetailViewController.swift
//  TestProject
//
//  Created by Daria on 24/09/2019.
//  Copyright © 2019 D.Misch. All rights reserved.
//

import UIKit



class DetailViewController: UIViewController, XMLParserDelegate {
    
    var passName:Bool=false
    var parser = XMLParser()
    var currency: [String] = []
    var datePicker = UIDatePicker()
    var scannedBarcode: String = ""
    
    @IBOutlet weak var barcode: UITextField!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var dateField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barcode.text = scannedBarcode
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(DetailViewController.dateChanged(datePicker:)), for: .valueChanged)
        dateField.inputView = datePicker
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func tapped (gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        getCurrency()
    }
    
    func getCurrency () {
        let url:String="http://www.cbr.ru/scripts/XML_daily.asp?date_req=\(String(dateField.text!))"
        let urlToSend: URL = URL(string: url)!
        // Parse the XML
        parser = XMLParser(contentsOf: urlToSend)!
        parser.delegate = self
        
        let success:Bool = parser.parse()
        
        if success {
            currencyValue.text = currency[currency.firstIndex(of: "USD")! + 1] + "RUB"
        } else {
            currencyValue.text = "Извините, нет данных на выбранный день."
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName=="CharCode" || elementName=="Value") {
            passName = true
            
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if(passName) {
            currency.append(string)
            
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName=="CharCode" || elementName=="Value")
        {
            passName=false
            
        }
        
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("failure error: ", parseError)
    }
    

}


