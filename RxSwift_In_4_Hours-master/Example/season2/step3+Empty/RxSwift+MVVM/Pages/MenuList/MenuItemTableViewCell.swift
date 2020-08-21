//
//  MenuItemTableViewCell.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 07/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxRelay

class MenuItemTableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var count: UILabel!
    @IBOutlet var price: UILabel!
//    var a = BehaviorRelay 
    var onChaged: ((Int) -> Void)?
//    var viewModel: MenuListViewModel?
    
    @IBAction func onIncreaseCount() {
       
        onChaged?(+1)
    }

    @IBAction func onDecreaseCount() {
        onChaged?(-1)
    }
}
