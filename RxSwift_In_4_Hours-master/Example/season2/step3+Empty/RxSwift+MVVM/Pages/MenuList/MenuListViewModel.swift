//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by 이주혁 on 2020/06/27.
//  Copyright © 2020 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift

class MenuListViewModel {
    var menus: [Menu] = [
        Menu(name: "튀김1", price: 100, count: 0),
        Menu(name: "튀김1", price: 100, count: 0),
        Menu(name: "튀김1", price: 100, count: 0),
        Menu(name: "튀김1", price: 100, count: 0)
    ]
    
    var itemsCount: Int = 5
//    var totalPrice: Int = 10000
    var totalPrice: PublishSubject<Int> = PublishSubject()
}
