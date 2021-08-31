//
//  File.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import UIKit

public extension UIToolbar {
    
    static func accessoryToolBar(with target: Any?, title: String?, action: Selector?) -> UIToolbar {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: title ?? "Done", style: .done, target: target, action: action)
        
        toolbar.items = [flexButton, doneButton]
        
        return toolbar
    }
}
