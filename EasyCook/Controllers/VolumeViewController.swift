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
        updateCupLabel(value: sender.value)

    }
    
    @IBAction func volumeSegmentContolChanged(_ sender: UISegmentedControl) {
    }
    func updateCupLabel(value: Float){
        let cupVolume = Double(String(format: "%.1F", Double(value)))
        if cupVolume == 1 {
            cupsLabel.text = "1 Cup"
        }
    }
    
    func convertVolumeFrom(cups: Double) -> (milliliters: Double, grams: Double){
        let milliliter = (Double(cups) * 236.5882)
        let gram = (Double(cups) * 125)
        
        return(milliliter, gram)
    }
    
    func updateVolumeSliderLabel(value: Float){
        let cupVolume = Double(String(format: "%.1F", Double(value)))
        cupsLabel.text = "\(cupVolume ?? 0) Cups"
        
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


