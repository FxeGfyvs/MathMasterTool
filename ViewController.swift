import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var txtQuadEq: UITextField!
    @IBOutlet weak var btnSolve: UIButton!
    @IBOutlet weak var lblInstructions: UILabel!
    var m : Character = " "
    var s1 = "" as String
    var s2 = "" as String
    var coeffA = Int()
    var coeffB = Int()
    var coeffC = Int()
    @IBOutlet var swipe: UISwipeGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        btnSolve.titleLabel?.adjustsFontSizeToFitWidth = false
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        swipe.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipe)
    }
    @objc override func dismissKeyboard() {
        self.txtQuadEq.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func buttonDidPress(_ sender: AnyObject) {
        let q = txtQuadEq.text
        var arr = Array(q!)
        var i = arr.count
        var x = 0
        var cnt = 0
        while(cnt<i)
        {
            if(arr[x]==" ") {
                arr.remove(at: x)
                i=arr.count
            }
            x += 1
            cnt += 1
        }
             if check(arr) {
                quadForm(arr)
            }
    }
    func check(_ s: [Character])  -> Bool {
        let charset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz")
        let crossCheck = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz1234567890+-=^ ")
        var countVar = 0
        var flag = true
        var countEqualSign = 0
        var countPowers = 0
        var countInvalid = 0
        var countSquared = 0
        for index in 0..<s.count {
            let str : String = "\(s[index])"
            if str.lowercased().rangeOfCharacter(from: charset, options: [], range: nil) != nil
            {
                countVar += 1
                if countVar == 1 {
                    m = s[index]
                }
                else {
                    if m==s[index] {
                        flag = true
                        continue
                    }
                    else {
                        flag = false
                        break
                    }
                }
            }
            if(s[index]) == "=" {
                countEqualSign += 1
            }
            if index == s.count-1 && (s[index] == "+" || s[index] == "-" || s[index] == "^") {
                countInvalid += 1
                break;
            }
            else {
                if (s[index] == "+" || s[index] == "-")  && (s[index+1] == "+" || s[index+1] == "-") {
                    countInvalid += 1
                    break
                }
            }
            if s[index] == "^" {
                countPowers += 1
                if s[index + 1] != "2" {
                    countSquared += 1
                }
                if s[index - 1] != m {
                    countSquared += 1
                }
            }
            if str.lowercased().rangeOfCharacter(from: crossCheck, options: [], range: nil) == nil {
                countInvalid += 1
                break
            }
        }
        if countEqualSign==1 && countPowers >= 1 && countSquared == 0 && countInvalid == 0 {
            flag = true
        }
        else {
            flag = false
        }
        if flag == true {
            s1 = "Yes"
        }
        else {
            s1 = "No"
        }
        return flag
    }
    func quadForm(_ s: [Character])  {
        var rhs: String = ""
        var lhs: String = ""
        for index in 0 ..< s.count {
            if s[index] == "=" {
                for i in 0 ..< index {
                    lhs.append(s[i])
                }
                for i in index+1 ..< s.count {
                    rhs.append(s[i])
                }
            }
        }
        if lhs.lowercased().rangeOfCharacter(from: CharacterSet(charactersIn: "\(m)^2"), options: [], range: nil) != nil {
         rearrange(lhs, b: rhs)
        }
        else {
            rearrange(rhs, b: lhs)
        }
    }
    func rearrange(_ a: String, b: String)  {
        var r = Array(b)
        var lhs = a
        if(r[0] != "-") {
            r.insert(" ", at: 0)
        }
        r.append("-" as Character)
        r.append("0" as Character)
        r.append("+" as Character)
        var prevPos = 0
        for index in 0 ..<  r.count {
            if (r[index] == "+" || r[index] == "-") && index != 0 {
                for i in prevPos ..< index {
                    if r[i] == "+" || r[i] == " " {
                        lhs.append("-" as Character)
                    }
                    else if r[i] == "-" {
                        lhs.append("+" as Character)
                    }
                    else {
                        lhs.append(r[i])
                    }
                }
                prevPos = index
            }
        }
         arithmetic(lhs)
    }
    func arithmetic(_ s: String)  {
        var r = Array(s)
        var sar: [Character]
        var prevPos = 0
        var a : Int = 0
        var b : Int = 0
        var c : Int = 0
        var pos = 0
        var str1 = "" as String
        var str = "" as String
        if r[0] != "-" {
            r.insert(" ", at: 0)
        }
        for index in 1 ..< r.count {
            if r[index] == "+" || r[index] == "-" {
                for i in prevPos ..< index {
                    str.append(r[i])
                }
                sar = Array(str)
                if str.hasSuffix("\(m)^2") {
                    for j in 1 ..< sar.count {
                        if sar[j] == m {
                            pos = j
                            break
                        }
                    }
                    for j in 1 ..< pos {
                        str1.append(sar[j])
                    }
                    if sar[0] == "+" as Character || sar [0] == " " as Character {
                        if str1 == "" as String {
                            a += 1
                        }
                        else {
                            a += Int(str1)!
                        }
                    }
                    else {
                        if str1 == "" as String {
                            a -= 1
                        }
                        else {
                            a -= Int(str1)!
                        }
                    }
                }
                else if str.hasSuffix("\(m)") {
                    for j in 1 ..< sar.count {
                        if sar[j] == m {
                            pos = j
                            break
                        }
                    }
                    for j in 1 ..< pos {
                        str1.append(sar[j])
                    }
                    if sar[0] == "+" || sar [0] == " " {
                        if str1 == "" as String {
                            b += 1
                        }
                        else {
                            b += Int(str1)!
                        }
                    }
                    else {
                        if str1 == "" as String {
                            b -= 1
                        }
                        else {
                            b -= Int(str1)!
                        }
                    }
                }
                else if sar.count != 1 {
                    if "\(sar[sar.count-1])".lowercased().rangeOfCharacter(from: CharacterSet(charactersIn: "1234567890"), options: [], range: nil) == nil {
                        for i in 1 ..< (sar.count-1) {
                            str1.append(sar[i])
                        }
                    }
                    else {
                        for i in 1 ..< sar.count {
                            str1.append(sar[i])
                        }
                    }
                    if sar[0] == "+" || sar [0] == " " {
                        c += Int(str1)!
                    }
                    else {
                        c -= Int(str1)!
                    }
                }
                str = ""
                str1 = ""
                prevPos = index
                pos = 0
            }
        }
        coeffA = a
        coeffB = b
        coeffC = c
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultSegue" {
            if let destinationVC = segue.destination as? ResultView {
                if s1 == "No" {
                    destinationVC.flag = false
                }
                else {
                    destinationVC.flag = true
                    destinationVC.roots = s2
                    destinationVC.a = coeffA
                    destinationVC.b = coeffB
                    destinationVC.c = coeffC
                }
            }
        }
    }
    @IBAction func infoWasPressed(_ sender: AnyObject) {
        if (lblInstructions.alpha == 0.0) {
            lblInstructions.fadeIn()
        }
        else {
            lblInstructions.fadeOut()
        }
    }
}
