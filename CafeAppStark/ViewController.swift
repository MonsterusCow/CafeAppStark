//
//  ViewController.swift
//  CafeAppStark
//
//  Created by RYAN STARK on 9/10/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var FoodsView: UITextView!
    @IBOutlet weak var PricesView: UITextView!
    @IBOutlet weak var CartFoods: UITextView!
    @IBOutlet weak var CartPrices: UITextView!
    @IBOutlet weak var CartAddField: UITextField!
    @IBOutlet weak var AmountAddField: UITextField!
    @IBOutlet weak var adminField: UITextField!
    
    
    var fooods: [String] = ["Avocado", "Coffee", "Muffin", "Scone", "Poptart"]
    var prices: [Double] = [2.51, 4.11, 1.35, 1.07, 204]
    var errorAmount = 0
    var cart: [String:Double] = [:]
    var adminmode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CartAddField.delegate = self
        AmountAddField.delegate = self
        adminField.delegate = self
        FoodsView.text = ""
        PricesView.text = ""
        for i in 0..<fooods.count{
            FoodsView.text = "\(FoodsView.text!)\n \(i+1)) \(fooods[i])"
        }
        for i in 0..<prices.count{
            PricesView.text = "\(PricesView.text!)\n \(i+1)) $\(prices[i])"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if adminmode{
            if adminField.text != "admincode" {
                if CartAddField.text?.replacingOccurrences(of: " ", with: "") != "" && AmountAddField.text?.replacingOccurrences(of: " ", with: "") != ""{
                    for i in 0..<fooods.count{
                        if Int(AmountAddField.text!) != nil{
                            if CartAddField.text?.lowercased().replacingOccurrences(of: " ", with: "") == fooods[i].lowercased().replacingOccurrences(of: " ", with: ""){
                                var continuee = true
                                for (key,_) in cart {
                                    if key == fooods[i]{
                                        continuee = false
                                        nuhUH(alertName: "You already have that item in your cart")
                                        CartAddField.text = ""
                                        AmountAddField.text = ""
                                        break
                                    }
                                }
                                if continuee{
                                    CartFoods.text =  "\(CartFoods.text!)\n \(AmountAddField.text!) \(fooods[i])"
                                    if Int(AmountAddField.text!)! > 1 {
                                        CartFoods.text = "\(CartFoods.text!)s"
                                    }
                                    CartPrices.text =  "\(CartPrices.text!)\n $\(prices[i])"
                                    cart["\(fooods[i])"] = prices[i]
                                    CartAddField.text = ""
                                    AmountAddField.text = ""
                                    break
                                }
                            } else {
                                errorAmount = errorAmount+1
                                if errorAmount == fooods.count{
                                    nuhUH(alertName: "That is not a food available or you have typed a number here instead of a food")
                                    CartAddField.text = ""
                                    break
                                }
                            }
                        } else {
                            nuhUH(alertName: "There are more than numbers in the Amount field or you put a decimal")
                            AmountAddField.text = ""
                        }
                    }
                } else {
                    nuhUH(alertName: "One of the typing boxes are empty")
                    CartAddField.text = ""
                    AmountAddField.text = ""
                }
            } else {
                adminmode = true
                adminField.resignFirstResponder()
                CartAddField.placeholder = "Menu Item Here"
                AmountAddField.placeholder = "Price Here"
            }
        } else {
//            fooods.append(CartAddField.text!)
//            prices.append(Double(AmountAddField.text!)!)
        }\
        errorAmount = 0
        return CartAddField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        CartAddField.resignFirstResponder()
        AmountAddField.resignFirstResponder()
    }

    //alert function courticy of Matthew
    func nuhUH(alertName: String)
        {
            let alert = UIAlertController(title: "Error", message: alertName, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            
            alert.addAction(alertAction)
            
            self.present(alert, animated: true)
            
        }
}

