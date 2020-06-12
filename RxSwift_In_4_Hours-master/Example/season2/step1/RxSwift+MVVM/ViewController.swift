//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import RxSwift
import SwiftyJSON
import UIKit

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var editView: UITextView!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        self.disposable?.dispose()
        //        self.disposable?.forEach{ $0.dispose() }
    }
    
    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
            }, completion: { [weak self] _ in
                self?.view.layoutIfNeeded()
        })
    }
    
    
    func downloadJson(_ url: String) -> Observable<String>{
        
        
        //         1. 비동기로 생기는 데이터를 Observable로 감싸서 리턴하는 방법
        // create 로 emmiter를 생성하여 emmiter를 통해 원하는 정보를 onNext로 전달한다.
        return Observable.create() { emitter in
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url) { (data, _, err) in
                guard err == nil else {
                    emitter.onError(err!)
                    return
                }
                
                if let dat = data, let json = String(data: dat, encoding: .utf8) {
                    emitter.onNext(json)
                }
                
                emitter.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
        return Observable.from(["Helllo","World"])
        //        return Observable.create { emitter in
        //            emitter.onNext("Hello World")
        //            emitter.onCompleted()
        //            return Disposables.create()
        //        }
        //        return Observable.from(["Hello", "World"])
    }
    
    
    
    // MARK: SYNC
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    
    // 2. Observable로 오는 데이터를 받아서 처리하는 방법
    @IBAction func onLoad() {
        self.editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)
        
        let jsonObservable = downloadJson(MEMBER_LIST_URL)
        //            .map{json in json?.count ?? 0}
        //            .filter{cnt in cnt > 0 }
        //            .map{ "\($0)"}
        //            .observeOn(MainScheduler.instance)
        //            .subscribe(onNext:{ json in
        //                self.editView.text = json
        //                self.setVisibleWithAnimation(self.activityIndicator, false)
        //            })
        let helloObservable = Observable.just("Hello World")
        
        Observable.zip(jsonObservable, helloObservable) { $1 + "\n" + $0 }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { json in
                self.editView.text = json
                self.setVisibleWithAnimation(self.activityIndicator, false)
            })
            .disposed(by: self.disposeBag)
        
        //        self.disposable?.append(d)
        //        self.disposable.insert(d)
        
        //        let _ = downloadJson(MEMBER_LIST_URL)
        //            .subscribe { event in
        //                switch event {
        //                case .next(let data):
        //                    DispatchQueue.main.async {
        ////                        self.editView.text = data
        ////                        self.setVisibleWithAnimation(self.activityIndicator, false)
        //                    }
        //                    print(data)
        //
        //                case .completed:
        //                    print("completed")
        //                    break
        //                case .error(_):
        //                    break
        //                }
        //        }
        //disp.dispose()
    }
}



// 나중에 생기는 데이터 : Obsevable
// 나중에 오면 : subscribe
class 나중에생기는데이터<T> {
    private var task: (@escaping (T) -> Void) -> Void
    
    init(task: @escaping (@escaping (T) -> Void) -> Void) {
        self.task = task
    }
    
    func 나중에오면(_ f: @escaping (T) -> Void) {
        task(f)
    }
}

