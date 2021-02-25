//
//  TempViewController.swift
//  EasyCook
//
//  Created by janis.muiznieks on 24/02/2021.
//

import UIKit

class TempViewController: UIViewController {

    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var tempSlider: UISlider!
    @IBOutlet weak var convertedTempLabel: UILabel!
    @IBOutlet weak var tempSegmentControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tempSlideChanged (_ sender: UISlider, forEvent event: UIEvent) {
            updateTempSliderLabel(value: sender.value)
    }
    
    @IBAction func tempSegmentControlChanged(_ sender: UISegmentedControl) {
    }
    func convertedTempFrom(celsius: Int) -> (fahrenheit: Double, kelvin: Double){
        let fahrenheit = (Double(celsius) * 9 / 5 ) + 32
        let kelvin = Double(celsius) + 273.15
        
        return(fahrenheit, kelvin)
    }
    
    func updateTempSliderLabel(value: Float){
        let celsiusTemp = Int(value)
        celsiusLabel.text = "\(celsiusTemp) º C"
        
        var tempString = ""
        switch tempSegmentControl.selectedSegmentIndex {
        case 0:
            let fahrenheitTempString = String(format: "%.2F", convertedTempFrom(celsius: celsiusTemp).fahrenheit)
            tempString = fahrenheitTempString + " º F"
        default:
            let kelvinTempString = String(format: "%.2F", convertedTempFrom(celsius: celsiusTemp).kelvin)
            tempString = kelvinTempString + " º K"
        }
        convertedTempLabel.text = tempString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "temperatureInfo" {
            // Get the new view controller using segue.destination.
                let vc = segue.destination as! AppInfoViewController
            // Pass the selected object to the new view controller.
                vc.infoText = "Here you can convert Celsius to Fahreinheit or Kelvin"
        }
    }
    
    
    
}



