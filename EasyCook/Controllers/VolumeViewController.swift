//
//  VolumeViewController.swift
//  EasyCook
//
//  Created by janis.muiznieks on 24/02/2021.
//

import UIKit

class VolumeViewController: UIViewController {

    @IBOutlet weak var cupsLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var convertedVolumeLabel: UILabel!
    @IBOutlet weak var volumeSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func volumeSliderChanged(_ sender: UISlider, forEvent event: UIEvent) {
        updateVolumeSliderLabel(value: sender.value)
        

    }
    
    @IBAction func volumeSegmentContolChanged(_ sender: UISegmentedControl) {
    }
    
    
    func convertVolumeFrom(cups: Double) -> (milliliters: Double, grams: Double){
        let milliliter = (Double(cups) * 236.5882)
        let gram = (Double(cups) * 125)
        
        return(milliliter, gram)
    }
    
    func updateVolumeSliderLabel(value: Float){
        let cupVolume = Double(String(format: "%.1F", Double(value)))
        cupsLabel.text = "\(cupVolume ?? 0) Cups"
        if cupVolume == 1{
            cupsLabel.text = "1 Cup"
        }
        
        for i in 1...10 {
            
            if cupVolume! - Double(i) == 0.7{
                cupsLabel.text! = "\(i) 3/4 Cups"
            }
            if cupVolume! - Double(i) == 0.6 {
                cupsLabel.text! = "\(i) 2/3 Cups"
            }
            if cupVolume! - Double(i) == 0.5{
                cupsLabel.text! = "\(i) 1/2 Cups"
            }
            if cupVolume! - Double(i) == 0.3 {
                cupsLabel.text! = "\(i) 1/3 Cups"
            }
            if cupVolume! - Double(i) == 0.2{
                cupsLabel.text! = "\(i) 1/4 Cups"
            }
        }
        switch cupVolume {
        case 1.7:
            cupsLabel.text = "1 3/4 Cup"
        case 1.6:
            cupsLabel.text = "1 2/3 Cup"
        case 1.5:
            cupsLabel.text = "1 1/2 Cup"
        case 1.3:
            cupsLabel.text = "1 1/3 Cup"
        case 1.2:
            cupsLabel.text = "1 1/4 Cup"
        default:
            break
        }
        switch cupVolume {
        case 0.7:
            cupsLabel.text = "3/4 Cup"
        case 0.6:
            cupsLabel.text = "2/3 Cup"
        case 0.5:
            cupsLabel.text = "1/2 Cup"
        case 0.3:
            cupsLabel.text = "1/3 Cup"
        case 0.2:
            cupsLabel.text = "1/4 Cup"
        default:
            break
        }
        
        var volumeString = ""
        switch volumeSegmentControl.selectedSegmentIndex {
        case 0:
            let mlVolumeString = String(format: "%.1F", convertVolumeFrom(cups: cupVolume!).milliliters)
            volumeString = mlVolumeString + " ml"
        default:
            let gramsVolumeString = String(format: "%.1F", convertVolumeFrom(cups: cupVolume!).grams)
            volumeString = gramsVolumeString + " g"
        }
        convertedVolumeLabel.text = volumeString
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "volumeInfo" {
        // Get the new view controller using segue.destination.
            let vc = segue.destination as! AppInfoViewController
        // Pass the selected object to the new view controller.
            vc.infoText = "Here you can convert Cups to Milliliters or Grams"
        }
    }
    

}


