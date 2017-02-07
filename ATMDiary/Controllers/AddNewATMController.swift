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
        
        let newEntity = ATMManager.sharedInstance.newATM()
        newEntity.name = tfName.text
        newEntity.address = tfAddress.text
        newEntity.lat = Double(tfLat.text!)!
        newEntity.long = Double(tfLong.text!)!
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
