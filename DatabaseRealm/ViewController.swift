//
//  ViewController.swift
//  DatabaseRealm
//
//  Created by Yui Ogawa on 2022/08/31.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let memo: Memo? = read()
        
        titleTextField.text = memo?.title
        contentTextField.text = memo?.content
        
        titleTextField.delegate = self
        contentTextField.delegate = self
    }
    // キーボードの完了ボタンが押されたら、キーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func read() -> Memo? {
        return realm.objects(Memo.self).first
    }

    @IBAction func save() {
        let title: String = titleTextField.text!
        let content: String = contentTextField.text!
        
        let memo: Memo? = read()
        
        // すでにデータが保存されている場合は、メモの更新
        if memo != nil {
            try! realm.write {
                memo!.title = title
                memo!.content = content
            }
        } else {
            // データがない場合は新規作成をする
            let newMemo = Memo()
            newMemo.title = title
            newMemo.content = content
            
            try! realm.write {
                realm.add(newMemo)
            }
        }
        
        // 保存完了を表すアラートを表示
        let alert: UIAlertController = UIAlertController(title: "成功",
                                                         message: "保存しました",
                                                         preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil)
        )
        
        present(alert, animated: true, completion: nil)
    }

}

