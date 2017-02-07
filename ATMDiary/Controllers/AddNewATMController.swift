//
//  AddNewATMController.swift
//  ATMDiary
//
//  Created by  on 2/7/17.
//  Copyright © 2017 thanhnv. All rights reserved.
//

import UIKit

class AddNewATMController: UIViewController {

    @IBOutlet weak private var tfName: CustomTextField!
    @IBOutlet weak private var tfAddress: CustomTextField!
    @IBOutlet weak private var tfLat: CustomTextField!
    @IBOutlet weak private var tfLong: CustomTextField!
    
    
    weak var mainVC: MainController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let latitude = mainVC?.locationManager.location?.coordinate.latitude, let longitude = mainVC?.locationManager.location?.coordinate.longitude else {
            return
        }
        tfLat.text = "\(latitude)"
        tfLong.text = "\(longitude)"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tfName.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func close(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: Any) {
        
        guard let name = tfName.text, let address = tfAddress.text, let latText = tfLat.text, let longText = tfLong.text else {
            return
        }
        
        guard let lat = Double(latText), let long = Double(longText) else {
            let alertVC = UIAlertController(title: nil, message: "Please enter valid coordinate.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(action)
            present(alertVC, animated: true, completion: nil)
            return
        }
        
        let newEntity = ATMManager.sharedInstance.newATM()
        newEntity.name = name.characters.count == 0 ? "Name Test \(arc4random()%200)" : name
        newEntity.address = address.characters.count == 0 ? "Address Test \(arc4random()%200)" : address
        newEntity.lat = lat
        newEntity.long = long
        do {
            let result = try ATMManager.sharedInstance.saveData()
            if result {
                print("OK ")
                mainVC?.addNew(atm: newEntity)
                close(nil)
            }
        } catch _ {
            print("error")
        }
    }
    

}
