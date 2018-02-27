//
//  ViewController.swift
//  Number
//
//  Created by HY on 2018/2/27.
//  Copyright © 2018年 XY. All rights reserved.
//

import UIKit

struct XYModel:Codable {
    var age:Number?
    var name:Number?
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let dict = ["age":NSNull(),"name":123] as [String : Any]
        let data = try! JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            let model = try JSONDecoder().decode(XYModel.self, from: data)
            
            print(model)
        } catch  {
            print(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

