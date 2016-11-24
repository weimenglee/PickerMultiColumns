//
//  ViewController.swift
//  PickerMultiColumns
//
//  Created by Wei-Meng Lee on 20/9/15.
//  Copyright © 2015 Wei-Meng Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var brands:[String]!           //---array---
    var models:[String:[String]]!  //---dictionary of string arrays---
    
    var brandSelected: Int!        //---the brand which is currently selected---
    var modelSelected: [Int]!      //---the model which is currently selected---

    var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        models = [
            "Apple" : ["iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone 6"],
            "Samsung": ["Note 2", "Note 3", "Galaxy S4", "Galaxy S5"],
            "Nokia": ["Lumia 1320", "Lumia 1520", "Lumia 1020"],
            "HTC": ["HTC One", "HTC One M8"],
            "Google": ["Nexus 5", "Nexus 4", "Nexus 10", "Nexus 8"],
        ]
        
        //---save the brands as an array---
        brands = Array(models.keys)
        
        //---init the models selected for each brand to the first item---
        modelSelected = [Int](repeating: 0, count: brands.count)
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 20, width: self.view.bounds.size.width, height: 250))
        pickerView.backgroundColor = UIColor.black
        pickerView.delegate = self
        self.view.addSubview(pickerView)
        brandSelected = 0
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return brands.count                //---number of brands---
        case 1:
            let brand = brands[brandSelected]
            return (models[brand]?.count)!     //---number of models for the selected brand---
        default: break
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return brands[row]                 //---the current brand---
        case 1:
            let brand = brands[brandSelected]  //---the model for the selected brand---
            return models[brand]![row]
        default: break
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            brandSelected = row
            
            //---reload all the models for the selected brand---
            pickerView.reloadComponent(1)
        
            //---set the model to the one previously selected---
            pickerView.selectRow(modelSelected[row], inComponent: 1, animated: true)
            
        case 1:
            //---get the brand selected---
            let brand = brands[brandSelected]
            
            //---get the model selected---
            print(models[brand]![row])
            
            //---save the model selected for the brand---
            modelSelected[brandSelected] = row
            
        default: break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch component {
        case 0:
            //---display brands in green---
            let title = brands[row]
            let attString = NSAttributedString(string: title,
                attributes: [NSForegroundColorAttributeName: UIColor.green])
            return attString
        case 1:
            //---display models in red---
            let brand = brands[brandSelected]
            let title =  models[brand]![row]
            let attString = NSAttributedString(string: title,
                attributes: [NSForegroundColorAttributeName: UIColor.red])
        return attString
        default: break
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
