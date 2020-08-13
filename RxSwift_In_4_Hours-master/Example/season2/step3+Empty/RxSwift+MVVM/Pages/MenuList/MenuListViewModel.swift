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
    var menus: [Menu]
    
    var menuObservable = BehaviorSubject<[Menu]>(value: [])
    
//    var itemsCount: Int = 5
    lazy var itemCount = menuObservable.map {
        $0.map {
            $0.count
        }.reduce(0, +)
    }
    
    lazy var totalPrice = menuObservable.map {
        $0.map {
            $0.price * $0.count
        }.reduce(0, +)
    }
    
    
    init() {
//        print("init viewmodel")
//        _ = APIService.fetchAllMenusRx()
//            .map { data -> [MenuItem] in
//                struct Response: Decodable {
//                    let menus: [MenuItem]
//                }
//                let response = try! JSONDecoder().decode(Response.self, from: data)
//
//                return response.menus
//        }
//        .map { menuItems -> [Menu] in
//            return menuItems.map {
//                Menu.fromMenuItems(menuItem: $0)
//            }
//        }
//        .take(1)
//        .bind(to: menuObservable)
        
        menus = [
            Menu(name: "튀김1", price: 4000, count: 0),
            Menu(name: "튀김2", price: 5000, count: 0),
            Menu(name: "튀김3", price: 3000, count: 0),
            Menu(name: "튀김4", price: 1000, count: 0),
            Menu(name: "튀김5", price: 2000, count: 0)
        ]
        
        menuObservable.onNext(menus)
    }
    // 각 동작은 뷰모델 안에서 수행
    func clearAllItemSelections() {
        _ = menuObservable.map {
            return $0.map {
                return Menu(name: $0.name, price: $0.price, count: 0)
            }
        }
        .take(1) // 얘는 한번만 수행할 놈이다라는 것을 말해준다.
        .subscribe(onNext: {
            self.menuObservable.onNext($0)
        }) // Dispose를 하지 않아도 종료됨
        
        // 클리어 버튼이 수행될때 마다 계속해서 스트림이 만들어 진다.
    }
    
    func changeCount(_ menu: Menu, _ increase: Int){
        _ = menuObservable.map {
            return $0.map {
                if $0.name == menu.name {
                    return Menu(name: $0.name, price: $0.price, count: $0.count + increase)
                }
                else {
                    return Menu(name: $0.name, price: $0.price, count: $0.count)
                }
            }
        }
        .take(1) // 얘는 한번만 수행할 놈이다라는 것을 말해준다.
        .subscribe(onNext: {
            self.menuObservable.onNext($0)
        }) // Dispose를 하지 않아도 종료됨
        
        // 클리어 버튼이 수행될때 마다 계속해서 스트림이 만들어 진다.
    }
    
    func onOrder(){
        
    }
}
