import UIKit
import Expression
class CalculatorViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        past_equation.adjustsFontSizeToFitWidth = true
        self.title = "Calculator"
    }
    @IBOutlet var past_equation: UILabel!
    var number:Int = 0
    @IBOutlet weak var label: UILabel!
    var empty = true
    var first = 0
    var operation = ""
    var noddd = true
    var isitfirstnumber = true
    var answerevalue = 0.0
    @IBAction func buttton(_ sender: UIButton) {
        if(operation.count < 30){
            label.textColor = UIColor.black
            label.adjustsFontSizeToFitWidth = true
            print(noddd)
            if(noddd == true){
                label.text = ""
                label.text = "" + (sender.titleLabel?.text)!
                operation = operation + (sender.titleLabel?.text)!
                print(operation)
                label.text = operation
            }else{
                if(isitfirstnumber == true){
                    operation = (sender.titleLabel?.text)!
                    label.text = operation
                    noddd = true
                }else{
                    operation = operation + (sender.titleLabel?.text)!
                    print(operation)
                    label.text = operation
                    noddd = true
                }
            }
        }
    }
    @IBAction func operations(_ sender: UIButton) {
        if(operation.count < 30){
            if(label.text != ""){
                empty = false
            }
            label.textColor = UIColor.black
            label.adjustsFontSizeToFitWidth = true
            if(sender.titleLabel?.text == "+"){
                if(empty == false){
                    if(operation !=  ""){
                        if(String(operation.last!) == "x" || String(operation.last!) == "÷"){
                            print("error")
                        }else{
                            if(operation !=  ""){
                                if(String(operation.last!) != "+"){
                                    operation = operation + "+"
                                }
                                isitfirstnumber = false
                                label.text = operation
                            }
                        }
                    }
                }
            }else if (sender.titleLabel?.text == "-"){
                if(empty == false){
                    isitfirstnumber = false
                    operation = operation + "-"
                    label.text = operation
                }
            }else if (sender.titleLabel?.text == "("){
                if(operation != ""){
                    if(Int(String(operation.last!)) == nil){
                        isitfirstnumber = false
                        operation = operation + "("
                        label.text = operation
                    }else{
                        isitfirstnumber = false
                        operation = operation + "*("
                        label.text = operation
                    }
                }else{
                    isitfirstnumber = false
                    operation = operation + "("
                    label.text = operation
                }
            }else if (sender.titleLabel?.text == "."){
                if(empty == false){
                    if(operation !=  ""){
                        if(Int(String(operation.last!)) == nil || String(operation.last!) == "/" || String(operation.last!) == "-" || String(operation.last!) == "+" || noddd == false){
                            print("error")
                        }else{
                            isitfirstnumber = false
                            operation = operation + "."
                            label.text = operation
                        }
                    }
                }
            }else if (sender.titleLabel?.text == "x"){
                if(empty == false){
                    if(operation !=  ""){
                        if(String(operation.last!) == "*" || String(operation.last!) == "/" || String(operation.last!) == "-" || String(operation.last!) == "+"){
                            print("error")
                        }else{
                            isitfirstnumber = false
                            operation = operation + "*"
                            label.text = operation
                        }
                    }
                }
            }else if (sender.titleLabel?.text == "÷"){
                if(empty == false){
                    if(operation !=  ""){
                        print(operation.last!)
                        if(String(operation.last!) == "*" || String(operation.last!) == "/" || String(operation.last!) == "-"){
                            print("error")
                        }else{
                            isitfirstnumber = false
                            operation = operation + "/"
                            label.text = operation
                        }
                    }
                }
            }else if (sender.titleLabel?.text == "=" || sender.titleLabel?.text == "√"){
                outer : if(operation.replacingOccurrences(of: "+", with: "") == "" || operation.replacingOccurrences(of: "-", with: "") == "" || operation.replacingOccurrences(of: "/", with: "") == "" || operation.replacingOccurrences(of: "*", with: "") == "" ){
                    print("error,user stupid")
                    return
                }else{
                    operation = operation.replacingOccurrences(of: ")(", with: ")*(")
                    operation = operation.replacingOccurrences(of: "+-", with: "-")
                    operation = operation.replacingOccurrences(of: "-+", with: "-")
                    operation = operation.replacingOccurrences(of: "--", with: "+")
                    var st1ring = "+"
                    let initial = operation.count
                    for y in 1 ... operation.count{
                        print(y)
                        st1ring = "+"
                        for _ in 1 ... (initial-y+1){
                            st1ring = st1ring + "+"
                        }
                        print(st1ring)
                        operation = operation.replacingOccurrences(of: st1ring, with: "+")
                    }
                    operation = operation.replacingOccurrences(of: "+-", with: "-")
                    operation = operation.replacingOccurrences(of: "-+", with: "-")
                    operation = operation.replacingOccurrences(of: "Ans", with: "(" + String(answerevalue) + ")")
                    if(sender.titleLabel?.text == "√"){
                        operation = "sqrt(" + operation + ")"
                    }
                    print(operation)
                    do{
                        let result = try Expression(operation).evaluate()
                        if(result.isInfinite || result.isNaN){
                            label.textColor = UIColor.red
                            label.adjustsFontSizeToFitWidth = true
                            label.text = String(describing: result)
                            noddd = false
                            break outer
                        }
                        past_equation.text = operation.replacingOccurrences(of: ".0", with: "") + " = " + String(describing: result).replacingOccurrences(of: ".0", with: "")
                        label.text = String(describing: result).replacingOccurrences(of: ".0", with: "")
                        answerevalue = result
                        operation = "Ans"
                        isitfirstnumber = true
                        noddd = false
                    }catch{
                        label.textColor = UIColor.red
                        label.adjustsFontSizeToFitWidth = true
                        label.text = "\(error)"
                    }
                }
            }
            print(operation)
        }
    }
    @IBOutlet var deletebutton: UIButton!
    @IBAction func editdelete(_ sender: Any) {
        if(operation != "" && operation != "Ans"){
            if(noddd == false){
                label.textColor = UIColor.white
                label.adjustsFontSizeToFitWidth = true
                operation = String(operation.dropLast())
                label.text = operation
                noddd = true
            }else{
                operation = String(operation.dropLast())
                label.text = operation
            }
        }else if(operation == "Ans"){
            operation = ""
            label.text = operation
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func ac(_ sender: Any) {
        operation = ""
        label.text = ""
        noddd = true
        isitfirstnumber = true
        answerevalue = 0
        past_equation.text = ""
    }
}
extension String {
    private func allNumsToDouble() -> String {
        let symbolsCharSet = ".,"
        let fullCharSet = "0123456789" + symbolsCharSet
        var i = 0
        var result = ""
        var chars = Array(self)
        while i < chars.count {
            if fullCharSet.contains(chars[i]) {
                var numString = String(chars[i])
                i += 1
                loop: while i < chars.count {
                    if fullCharSet.contains(chars[i]) {
                        numString += String(chars[i])
                        i += 1
                    } else {
                        break loop
                    }
                }
                if let num = Double(numString) {
                    result += "\(num)"
                } else {
                    result += numString
                }
            } else {
                result += String(chars[i])
                i += 1
            }
        }
        return result
    }
    func calculate() -> Double? {
        let transformedString = allNumsToDouble()
        let expr = NSExpression(format: transformedString)
        return expr.expressionValue(with: nil, context: nil) as? Double
    }
}
extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
