//
//  ViewController.swift
//  HavaDurumu
//
//  Created by Flyco Developer on 22.05.2018.
//  Copyright © 2018 Flyco Global. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK : IBOutlets
    @IBOutlet var cityName: UITextField!
    @IBOutlet var showButton: UIButton!
    
    //MARK: IBActions
    @IBAction func goToTodayWeather(_ sender: Any) {
        
         if cityName.text == "" {
            let alert = UIAlertController(title: "Hata var", message: "Lütfen şehir adını boş bırakmayınız", preferredStyle: UIAlertControllerStyle.alert)
            let cancelButton = UIAlertAction(title: "İptal", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TodayWeatherStoaryBoardID") as! TodayWeatherTableViewController
            vc.cityName = self.cityName.text!;
            self.show(vc, sender: nil)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showButton.layer.cornerRadius = 4
        showButton.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

