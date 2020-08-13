//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
    
    var viewModel: MenuListViewModel?
    let disposeBag = DisposeBag()
    let cellID = "MenuItemTableViewCell"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MenuListViewModel()
        
        
        viewModel?.menuObservable
            .bind(to: tableView
                .rx
                .items(cellIdentifier: cellID,
                       cellType: MenuItemTableViewCell.self)) { index, item, cell in
                        // index : index
                        // item : menu 배열중 하나가 들어온다.
                        // cell : 지정해준 Cell의 인스턴스
                        cell.title.text = item.name
                        cell.price.text = "\(item.price.currencyKR())"
                        cell.count.text = "\(item.count)"
                        
                        cell.onChaged = { [weak self] increase in
                            
                            self?.viewModel?.changeCount(item, increase)
                        }
        }.disposed(by: self.disposeBag)
        
        viewModel?.totalPrice
            .map { $0.currencyKR() }
            .bind(to: self.totalPrice.rx.text) // 순환참조 문제가 사라진다.
            .disposed(by: self.disposeBag)
        
//        viewModel?.totalPrice
//            .map {
//                $0.currencyKR()
//        }
//        .asDriver(onErrorJustReturn: "")
//        .drive(self.totalPrice.rx.text)
//        .disposed(by: self.disposeBag)
        
        viewModel?.itemCount
            .map { "\($0)"}
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.itemCountLabel.text = $0
            })
            .disposed(by: self.disposeBag)
        
        // 뷰컨트롤러에서는 뷰의 요소들만 지정한다.
//        viewModel =
//        viewModel.
//        updateUI()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        if identifier == "OrderViewController",
            let orderVC = segue.destination as? OrderViewController {
            // TODO: pass selected menus
        }
    }

    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }

    // MARK: - InterfaceBuilder Links

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var totalPrice: UILabel!

    @IBAction func onClear() {
        viewModel?.clearAllItemSelections()
    }

    @IBAction func onOrder(_ sender: UIButton) {
//        viewModel?.onOrder()
        
        viewModel?.menuObservable.onNext([
            Menu(name: "커피", price: 2000, count: Int.random(in: 0...3)),
            Menu(name: "라면", price: 5000, count: Int.random(in: 0...3)),
            Menu(name: "떡볶이", price: 4000, count: Int.random(in: 0...3)),
            Menu(name: "김밥", price: 2000, count: Int.random(in: 0...3)),
            Menu(name: "사이다", price: 500, count: Int.random(in: 0...3)),
        ])
        // TODO: no selection
        // showAlert("Order Fail", "No Orders")
//        performSegue(withIdentifier: "OrderViewController", sender: nil)
        
//        viewModel.totalPrice.onNext(100)
//        viewModel.itemsCount += 1
//        updateUI()

    }
    
    private func updateUI(){
//        self.totalPrice.text = viewModel.totalPrice.currencyKR()
//        self.itemCountLabel.text = "\(viewModel.itemsCount)"
    }
}
//
//extension MenuViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.viewModel.menus.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell") as! MenuItemTableViewCell
//
//        let menu = self.viewModel.menus[indexPath.row]
//        cell.title.text = menu.name
//        cell.price.text = "\(menu.price)"
//        cell.count.text = "\(menu.count)"
//
//        return cell
//    }
//}
