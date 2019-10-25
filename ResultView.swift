import UIKit
import SystemConfiguration
class ResultView: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var resultWebView: UIWebView!
    @IBOutlet weak var lblInvalid: UILabel!
    @IBOutlet weak var lblHeadInput: UILabel!
    @IBOutlet weak var lblInputEqn: UILabel!
    @IBOutlet weak var lblInputCoeff: UILabel!
    @IBOutlet weak var lblHeadDiscriminant: UILabel!
    @IBOutlet weak var lblDiscEval: UILabel!
    @IBOutlet weak var lblDiscCondition: UILabel!
    @IBOutlet weak var segControlResult: UISegmentedControl!
    @IBOutlet weak var lblImaginaryResult: UILabel!
    @IBOutlet weak var lblHeadResult: UILabel!
    var roots = "" as String
    var factMethod = String()
    var formulaMethod = String()
    var flag = true
    var a = Int()
    var b = Int()
    var c = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(a,b,c)
        resultWebView.delegate = self
        resultWebView.isHidden = true
        if !self.connectedToNetwork() {
            if flag == true {
                lblInputEqn.text = exponentize(getInputString())
                lblInputCoeff.text = "a = \(a), b = \(b), c = \(c)"
                var D: Double = (Double((b*b)-(4*a*c)))
                let disc = exponentize("D = b^2 - 4ac = ")
                var evalDisc = exponentize("(\(b))^2 - 4(\(a))(\(c)) = ")
                evalDisc += exponentize("\(b*b) - (\(4*a*c)) = \(D)")
                lblDiscEval.text = disc + evalDisc
                var discCond = ""
                if D<0 {
                    discCond = "D < 0. Therefore, both roots are imaginary(complex)."
                    segControlResult.isHidden = true
                    resultWebView.isHidden = true
                    lblImaginaryResult.isHidden = false
                }
                else if D == 0 {
                    discCond = "D = 0. Therefore, both roots are equal."
                }
                else {
                    discCond = "D > 0. Therefore, both roots are real and unequal."
                }
                lblDiscCondition.text = discCond
                var r1 = Double()
                var r2 = Double()
                var s2 = String()
                if D<0 {
                    s2 = "Roots are Imaginary"
                }
                else {
                    D = sqrt(D)
                    s2 = ""
                    r1 = ( (-Double(b)) + D ) / Double((2*a))
                    r2 = ( (-Double(b)) - D ) / Double((2*a))
                    if "\(r1)".count > 10 {
                        s2 += "{ \(r1), <br> \(r2) }"
                    }
                    else {
                        s2 += "{ \(r1), \(r2) }"
                    }
                }
                let path = Bundle.main.bundlePath
                let baseURL = URL(fileURLWithPath: path)
                roots = "<!DOCTYPE html><html><head></head><body><div style=\"font-size: 14pt; color: black; text-align:center;\">Solution Set: <br/>"
                roots += s2
                roots += "<br/><br/><span style=\"color:red; font-size:10pt;\">Please connect to the internet to view step-by-step solution.</span>"
                roots += "</div></body></html>"
                resultWebView.loadHTMLString(roots, baseURL: baseURL)
                factMethod = "<!DOCTYPE html><html><head></head><body><div style=\"font-size: 14pt; color: black; text-align:center;\">"
                factMethod += "<span style=\"color:red; font-size:10pt;\">Please connect to the internet to view step-by-step solution.</span>"
                factMethod += "</div></body></html>"
                formulaMethod = "<!DOCTYPE html><html><head></head><body><div style=\"font-size: 14pt; color: black; text-align:center;\">"
                formulaMethod += "<span style=\"color:red; font-size:10pt;\">Please connect to the internet to view step-by-step solution.</span>"
                factMethod += "</div></body></html>"
            }
            else {
                resultWebView.isHidden = true
            }
        }
        else {
            if flag == true {
                lblInputEqn.text = exponentize(getInputString())
                lblInputCoeff.text = "a = \(a), b = \(b), c = \(c)"
                var D: Double = (Double((b*b)-(4*a*c)))
                let disc = exponentize("D = b^2 - 4ac = ")
                var evalDisc = exponentize("(\(b))^2 - 4(\(a))(\(c)) = ")
                evalDisc += exponentize("\(b*b) - (\(4*a*c)) = \(D)")
                lblDiscEval.text = disc + evalDisc
                var discCond = ""
                if D<0 {
                    discCond = "D < 0. Therefore, both roots are imaginary(complex)."
                    segControlResult.isHidden = true
                    resultWebView.isHidden = true
                    lblImaginaryResult.isHidden = false
                }
                else if D == 0 {
                    discCond = "D = 0. Therefore, both roots are equal."
                }
                else {
                    discCond = "D > 0. Therefore, both roots are real and unequal."
                }
                lblDiscCondition.text = discCond
                var formulaString = "<!DOCTYPE html><html><head><title>MathJax TeX Test Page</title><script type=\"text/javascript\" async  src=\'https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML'></script></head><body><div style=\"font-size: 10pt; color: black; text-align:center;\">"
                formulaString += "`x = (-b +- sqrt(b^2 - 4ac))/(2a)`<br><br> "
                formulaString += "`x = (-(\(b)) +- sqrt((\(b))^2 - 4xx(\(a))xx(\(c))))/(2xx(\(a)))`<br><br>"
                formulaString += "`x = (-(\(b)) +- sqrt((\(b*b)) - (\(4*a*c))))/((\(2*a)))` <br><br>"
                let resultEquation1 = "`(-(\(b)) + sqrt((\((b*b)-(4*a*c)))))/((\(2*a)))` "
                let resultEquation2 = " `(-(\(b)) - sqrt((\((b*b)-(4*a*c)))))/((\(2*a)))`"
                formulaString += "`x=`"+resultEquation1 + "`or`" + "`x=`"+resultEquation2 + "<br><br>"
                let underRoot = sqrt(Double((b*b)-(4*a*c)))
                if floor(underRoot) == underRoot {
                    formulaString += "`x=(-(\(b)) + \(underRoot))/((\(2*a))) or x=(-(\(b)) - \(underRoot))/((\(2*a)))`<br><br>"
                    formulaString += "`x=\(Double(-b)+underRoot)/(\(2*a)) or "
                    formulaString += "x=\(Double(-b)-underRoot)/(\(2*a))`<br><br>"
                    formulaString += "`x=\((Double(-b)+underRoot)/(Double(2*a))) or "
                    formulaString += "x=\((Double(-b)-underRoot)/(Double(2*a)))`"
                }
                else {
                    formulaString += "`x~~\((Double(-b)+underRoot)/(Double(2*a))) or "
                    formulaString += "x~~\((Double(-b)-underRoot)/(Double(2*a)))`"
                }
                formulaString += "</div></body></html>"
                formulaMethod = formulaString
                var r1 = Double()
                var r2 = Double()
                var isDouble = Bool()
                var s2 = String()
                if D<0 {
                    s2 = "Roots are Imaginary"
                }
                else {
                    D = sqrt(D)
                    s2 = ""
                    r1 = ( (-Double(b)) + D ) / Double((2*a))
                    r2 = ( (-Double(b)) - D ) / Double((2*a))
                    if floor(r1) == r1 && floor(r2) == r2 {
                        isDouble = false
                        if "\(r1)".count > 10 {
                            s2 += "`{ \(r1),` <br>` \(r2) }`"
                        }
                        else {
                            s2 += "`{ \(r1), \(r2) }`"
                        }
                    }
                    else {
                        isDouble = true
                        s2 += "`{`" + resultEquation1 + "," + resultEquation2 + "`}`<br><br> `~~ { \(r1),` ` \(r2) }`"
                    }
                }
                let path = Bundle.main.bundlePath
                let baseURL = URL(fileURLWithPath: path)
                if isDouble {
                    roots = "<!DOCTYPE html><html><head><title>MathJax TeX Test Page</title><script type=\"text/javascript\" async  src=\'https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML'></script></head><body><div style=\"font-size: 12pt; color: black; text-align:center;\">Solution Set: <br><br>"
                }
                else {
                    roots = "<!DOCTYPE html><html><head><title>MathJax TeX Test Page</title><script type=\"text/javascript\" async  src=\'https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML'></script></head><body><div style=\"font-size: 18pt; color: black; text-align:center;\">Solution Set: <br>"
                }
                roots += s2
                roots += "</div></body></html>"
                if (D>0) {
                    resultWebView.loadHTMLString(roots, baseURL: baseURL)
                }
                if floor(r1) != r1 || floor(r2) != r2 { 
                    factMethod = "<body><div style=\"font-size: 18pt; color: black; text-align:center;\">Factorisation method not applicable. Use formula method instead.</div></body>"
                }
                else {
                    var factString = String()
                    factString = "<!DOCTYPE html><html><head><title>MathJax TeX Test Page</title><script type=\"text/javascript\" async  src=\'https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML'></script></head><body><div style=\"font-size: 12pt; color: black; text-align:left;\">"
                    if abs(r1) == abs(r2) { 
                        let a_HCF = HCF(a, n: c)
                        let inputString = getInputString(a/a_HCF, b: b/a_HCF, c: c/a_HCF)
                        if a_HCF > 1 { 
                            factString = "<!DOCTYPE html><html><head><title>MathJax TeX Test Page</title><script type=\"text/javascript\" async  src=\'https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML'></script></head><body><div style=\"font-size: 12pt; color: black; text-align:left;\">"
                            factString += "Step 1: Take `\(a_HCF)` common:<br>`=>"+getInputString()+"`<br>`=> \(a_HCF)("+inputString+") = 0` <br> ` => "+inputString+" = 0`<br/>"
                            factString += "Step 2: Using the identity: `a^2 - b^2 = (a+b)(a-b)` to expand the left hand side: <br>`=>"+inputString+"=0 `<br> `=> (x+\(Int(r1)))(x-\(Int(-r2))) = 0` <br/>"
                            factString += "Step 3: Using the zero product rule: <br> `=> (x+\(Int(r1)))(x-\(Int(-r2))) = 0`<br/>`=> x = -\(Int(-r2)) or x = \(Int(r1))` "
                        }
                        else { 
                            factString += "Step 1: Using the identity: `a^2 - b^2 = (a+b)(a-b)` to expand the left hand side: <br>`=>"+inputString+"=0 `<br> `=> (x+\(Int(r1)))(x-\(Int(-r2))) = 0` <br/>"
                            factString += "Step 2: Using the zero product rule: <br> `=> (x+\(Int(r1)))(x-\(Int(-r2))) = 0`<br/>`=> x = -\(Int(-r2)) or x = \(Int(r1))` "
                        }
                    }
                    else if (c == 0) {
                        let a_HCF = HCF(a, n: b)
                        let inputString = getInputString(a/a_HCF, b: b/a_HCF, c: c/a_HCF)
                        var r = Int()
                        if r1 != 0 {
                            r = Int(r1)
                        }
                        else {
                            r = Int(r2)
                        }
                        if a_HCF > 1 { 
                            factString += "Step 1: Take `\(a_HCF)` common:<br>`=>"+getInputString()+"`<br>`=> \(a_HCF)("+inputString+") = 0` <br> ` => "+inputString+" = 0`<br/>"
                            var s3 = String();
                            if r > 0 {
                                s3 = "`=> x(x-\(r)) = 0`<br/>"
                                factString += "Step 2: Take `x` common: <br/> `=> "+inputString+" = 0` <br/> " + s3
                            }
                            else {
                                s3 = "`=> x(x+\(-r)) = 0`<br/>"
                                factString += "Step 2: Take `x` common: <br/> `=> "+inputString+" = 0` <br/> " + s3
                            }
                            factString += "Step 3: Using the zero product rule: <br>"+s3+"`=> x = 0 or x = \(r)`<br/>"
                        }
                        else {
                            var s3 = String();
                            if r > 0 {
                                s3 = "`=> x(x-\(r)) = 0`<br/>"
                                factString += "Step 1: Take `x` common: <br/> `=> "+inputString+" = 0` <br/> " + s3
                            }
                            else {
                                s3 = "`=> x(x+\(-r)) = 0`<br/>"
                                factString += "Step 1: Take `x` common: <br/> `=> "+inputString+" = 0` <br/> " + s3
                            }
                            factString += "Step 2: Using the zero product rule: <br>"+s3+"`=> x = 0 or x = \(r)`<br/>"
                        }
                    }
                    else {
                        factString = "<!DOCTYPE html><html><head><title>MathJax TeX Test Page</title><script type=\"text/javascript\" async  src=\'https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML'></script></head><body><div style=\"font-size: 12pt; color: black; text-align:left;\">"
                        var factors = String()
                        let a_HCF = HCF(a, n: b, o: c)
                        if (r1 != 1 && r2 != 1) {
                            factors = factorise(a*c, f:false)
                        }
                        else {
                            factors = factorise(a*c, f:true)
                        }
                        factString += "Step 1: Factorise the product of 'a' and 'c':<br>`a xx c = \((a*c)) = "+factors+"`<br/>"
                        factString += "Step 2: Express b as a sum of two factors from above:<br> `b = \(b) = `"+getFactorString(a_HCF*Int(r1), q: a_HCF*Int(r2), s: Int(b))
                        let splitTerms = getSplitTerms(a_HCF*Int(r1), q: a_HCF*Int(r2), s: Int(b))
                        var b_HCF = HCF(a, n: splitTerms[0])
                        var c_HCF = HCF(splitTerms[1], n: c)
                        if a < 0 {
                            b_HCF = -b_HCF
                        }
                        if splitTerms[1] < 0 {
                            c_HCF = -c_HCF
                        }
                        var b_HCF_s = String()
                        var c_HCF_s = String()
                        var p_s = String()
                        var q_s = String()
                        if b_HCF < 0 {
                            b_HCF_s = "- \(-b_HCF)"
                        }
                        else {
                            if b_HCF == 1 {
                                b_HCF_s = ""
                            }
                            else {
                                b_HCF_s = "\(b_HCF)"
                            }
                        }
                        if c_HCF < 0 {
                            c_HCF_s = "- \(-c_HCF)"
                        }
                        else {
                            c_HCF_s = "+ \(c_HCF)"
                        }
                        if splitTerms[0]/b_HCF < 0 {
                            p_s = "- \(-(splitTerms[0]/b_HCF))"
                        }
                        else {
                            p_s = "+ \(splitTerms[0]/b_HCF)"
                        }
                        if c/c_HCF < 0 {
                            q_s = "- \(-(c/c_HCF))"
                        }
                        else {
                            q_s = "+ \(c/c_HCF)"
                        }
                        if (a/b_HCF) == 1 {
                            factString += "Step 4: Factorise the equation:<br/>`=> \(b_HCF_s)x(x \(p_s)) \(c_HCF_s)(x \(p_s))=0`<br/>"
                            factString += "`=> (\(b_HCF_s)x \(c_HCF_s))(x \(p_s)) = 0`<br/>"
                            factString += "Step 5: Using the zero product rule: <br/>"
                            factString += "`=> (\(b_HCF_s)x \(c_HCF_s)) = 0 or (x \(p_s)) = 0`<br/>"
                            factString += "`=> x = \(Int(r2)) or x = \(Int(r1))` "
                        }
                        else {
                            factString += "Step 4: Factorise the equation:<br/>`=> \(b_HCF_s)x(\(a/b_HCF)x \(p_s)) \(c_HCF_s)(\(splitTerms[1]/c_HCF)x \(q_s))=0`<br/>"
                            factString += "`=> (\(b_HCF_s)x \(c_HCF_s))(\(a/b_HCF)x \(p_s)) = 0`<br/>"
                            factString += "Step 5: Using the zero product rule: <br/>"
                            factString += "`=> (\(b_HCF_s)x \(c_HCF_s)) = 0 or (\(a/b_HCF)x \(p_s)) = 0`<br/>"
                            factString += "`=> x = \(Int(r2)) or x = \(Int(r1))` "
                        }
                    }
                    factString += "</div></body></html>"
                    factMethod = factString
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if flag == true {
        }
        else {
            lblInvalid.isHidden = false
            lblHeadInput.isHidden = true
            lblInputEqn.isHidden = true
            lblInputCoeff.isHidden = true
            lblHeadDiscriminant.isHidden = true
            lblDiscEval.isHidden = true
            lblDiscCondition.isHidden = true
            lblHeadResult.isHidden = true
            resultWebView.isHidden = true
            segControlResult.isHidden = true
        }
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        resultWebView.isHidden = true
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        resultWebView.isHidden = false
    }
    @IBAction func valueDidChange(_ sender: UISegmentedControl) {
        let path = Bundle.main.bundlePath
        let baseURL = URL(fileURLWithPath: path)
        if sender.selectedSegmentIndex == 0 {
            resultWebView.loadHTMLString(roots, baseURL: baseURL)
        }
        else if sender.selectedSegmentIndex == 1 {
           resultWebView.loadHTMLString(factMethod, baseURL: baseURL)
        }
        else {
            resultWebView.loadHTMLString(formulaMethod, baseURL: baseURL)
        }
    }
    func exponentize(_ str: String) -> String {
        let supers = [
            "1": "\u{00B9}",
            "2": "\u{00B2}",
            "3": "\u{00B3}",
            "4": "\u{2074}",
            "5": "\u{2075}",
            "6": "\u{2076}",
            "7": "\u{2077}",
            "8": "\u{2078}",
            "9": "\u{2079}" ]
        var newStr = ""
        var isExp = false
        for (_, char) in str.enumerated() {
            if char == "^" {
                isExp = true
            } else {
                if isExp {
                    let key = String(char)
                    if supers.keys.contains(key) {
                        newStr.append(Character(supers[key]!))
                    } else {
                        isExp = false
                        newStr.append(char)
                    }
                } else {
                    newStr.append(char)
                }
            }
        }
        return newStr
    }
    func getFactorString(_ p: Int, q: Int, s: Int) -> String {
        var s1 = String()
        var s2 = String()
        var s11 = String()
        var s22 = String()
        if abs(p) != 1 {
            s1 = "("+factorise(p, f:false)+")"
        }
        else {
            s1 = "(1)"
        }
        if abs(p) != 1 {
            s11 = factorise(p, f:false)
        }
        else {
            s11 = "1"
         }
        if abs(q) != 1 {
            s2 = "("+factorise(q, f:false)+")"
        }
        else {
            s2 = "(1)"
        }
        if abs(q) != 1 {
            s22 = factorise(q, f:false)
        }
        else {
            s22 = "1"
        }
        var ret = String()
        let inpString = getInputString()
        var sqTerm = String()
        var cTerm = String()
        if self.c<0 {
            cTerm = "-\(-self.c)"
        }
        else if self.c>0 {
            cTerm = "+ \(self.c)"
        }
        for index in 0..<inpString.count {
            if inpString[index] != "^" {
                sqTerm += inpString[index]
            }
            else {
                sqTerm += inpString[index]
                sqTerm += inpString[index+1]
                sqTerm += " "
                break;
            }
        }
        let const = "Step 3: Rewrite equation after splitting the middle term:<br>`=> "+inpString+"`<br/>`=>"+sqTerm
        if s1.count > 4 || s2.count > 4 {
            let pp = multArray(factorise(p))
            let qq = multArray(factorise(q))
            if abs(p)+abs(q) == s {
                ret =  "`"+s1+"+"+s2+" = \(pp) + \(qq)`<br/>" + const + "+ \(pp)x + \(qq)x " + cTerm + "=0`<br/>"
            }
            else if abs(p)-abs(q) == s {
                ret =  "`"+s1+"-"+s2+" = \(pp) - \(qq)`<br/>" + const + "+ \(pp)x - \(qq)x " + cTerm + "=0`<br/>"
            }
            else if -abs(p)+abs(q) == s {
                ret =  "`-"+s1+"+"+s2+" = -\(pp) + \(qq)`<br/>" + const + "- \(pp)x + \(qq)x " + cTerm + "=0`<br/>"
            }
            else if -abs(p)-abs(q) == s{
                ret = "`-"+s1+"-"+s2+" = -\(pp) - \(qq)`<br/>" + const + "- \(pp)x - \(qq)x " + cTerm + "=0`<br/>"
            }
            else {
                ret =  "Error."
            }
        }
        else {
            let pp = Int(s11.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
            let qq = Int(s22.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
            if abs(p)+abs(q) == s {
                ret =  "`"+s1+"+"+s2+"`<br/>" + const + "+ \(pp)x + \(qq)x " + cTerm + "=0`<br/>"
            }
            else if abs(p)-abs(q) == s {
                ret =  "`"+s1+"-"+s2+"`<br/>" + const + "+ \(pp)x - \(qq)x " + cTerm + "=0`<br/>"
            }
            else if -abs(p)+abs(q) == s {
                ret =  "`-"+s1+"+"+s2+"`<br/>" + const + "- \(pp)x + \(qq)x " + cTerm + "=0`<br/>"
            }
            else if -abs(p)-abs(q) == s{
                ret = "`-"+s1+"-"+s2+"`<br/>" + const + "- \(pp)x - \(qq)x " + cTerm + "=0`<br/>"
            }
            else {
                ret =  "Error."
            }
        }
        return ret
    }
    func getSplitTerms(_ p: Int, q: Int, s: Int) -> [Int] {
        var s1 = String()
        var s2 = String()
        if abs(p) != 1 {
            s1 = factorise(p, f:false)
        }
        else {
            s1 = "1"
        }
        if abs(q) != 1 {
            s2 = factorise(q, f:false)
        }
        else {
            s2 = "1"
        }
        var ret: [Int] = []
        if s1.count > 2 || s2.count > 2 {
            if abs(p)+abs(q) == s {
                ret.append(multArray(factorise(p)))
                ret.append(multArray(factorise(q)))
            }
            else if abs(p)-abs(q) == s {
                ret.append(multArray(factorise(p)))
                ret.append(-multArray(factorise(q)))
            }
            else if -abs(p)+abs(q) == s {
                ret.append(-multArray(factorise(p)))
                ret.append(multArray(factorise(q)))
            }
            else if -abs(p)-abs(q) == s{
                ret.append(-multArray(factorise(p)))
                ret.append(-multArray(factorise(q)))
            }
            else {
            }
        }
        else {
            if abs(p)+abs(q) == s {
                ret.append(Int(s1.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!)
                ret.append(Int(s2.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!)
            }
            else if abs(p)-abs(q) == s {
                ret.append(Int(s1.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!)
                ret.append(-Int(s2.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!)
            }
            else if -abs(p)+abs(q) == s {
                ret.append(-Int(s1.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!)
                ret.append(Int(s2.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!)
            }
            else if -abs(p)-abs(q) == s{
                ret.append(-Int(s1.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!)
                ret.append(-Int(s2.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!)
            }
            else {
            }
        }
        return ret
    }
    func factorise(_ n: Int, f: Bool) -> String {
        var factors = String()
        if n == 0 {
            return "0"
        }
        else if abs(n)==1 {
            return "1"
        }
        if n != 0 && f {
            factors  = "1 xx "
        }
        var n2 = n
        for index in 2 ... abs(n) {
            while n2%index == 0 {
                n2/=index
                factors += "\(index) xx "
            }
        }
        return factors[0...(factors.count - 4)]
    }
    func HCF(_ m: Int, n: Int, o: Int) -> Int {
        let f1 = factorise(m)
        let f2 = factorise(n)
        let f3 = factorise(o)
        var comm = commonElements(f1, b: f2)
        comm = commonElements(comm, b: f3)
        var hcf = 1
        for n in comm {
            hcf = hcf * n
        }
        return hcf
    }
    func HCF(_ m: Int, n: Int) -> Int {
        let f1 = factorise(m)
        let f2 = factorise(n)
        let comm = commonElements(f1, b: f2)
        var hcf = 1
        for n in comm {
            hcf = hcf * n
        }
        return hcf
    }
    func commonElements(_ a: [Int], b: [Int]) -> [Int] {
        var common: [Int] = []
        var tempCommon: [Int] = []
        var temp = 0
        var b1 = b
        var index = 0
        var flag = false
        for p in a {
            while index < b1.count {
                let q = b1[index]
                if p == q && !tempCommon.contains(q) {
                    common.append(q)
                    tempCommon.append(q)
                    temp = index
                    flag = true
                }
                index = index + 1
            }
            if flag {
            b1.remove(at: temp)
            }
            tempCommon = []
            index = 0
            flag = false
        }
        return common
    }
    func factorise(_ n: Int) -> [Int] {
        var factors:[Int] = []
        if n == 0 {
            return [0]
        }
        else if abs(n) == 1 {
            return [1]
        }
        if (n != 0) {
            factors.append((1))
        }
        var n2 = n
        for index in 2 ... abs(n) {
            while n2%index == 0 {
                n2/=index
                factors.append(index)
            }
        }
        return factors
    }
    func getInputString() -> String {
        var inp = String()
        if a > 0 {
            if a == 1 {
                inp += "x^2 "
            }
            else {
                inp += "\(a)x^2 "
            }
        }
        else if a < 0 {
            if a == -1 {
                inp += "-x^2 "
            }
            else {
                inp += "-\(-a)x^2 "
            }
        }
        else {
            inp += ""
        }
        if b > 0 {
            if b == 1 {
                inp += "+ x "
            }
            else {
                inp += "+ \(b)x "
            }
        }
        else if b < 0 {
            if b == -1 {
                inp += "- x "
            }
            else {
                inp += "- \(-b)x "
            }
        }
        else {
            inp += ""
        }
        if c > 0 {
            inp += "+ \(c) = 0"
        }
        else if c < 0{
            inp += "- \(-c) = 0"
        }
        else {
            inp += "= 0"
        }
        return inp
    }
    func relevantFactors(_ factors: String, r1: Double, r2: Double) {
    }
    func multArray(_ arr: [Int]) -> Int {
        var ret = 1
        for n in arr {
            ret = ret * n
        }
        return ret
    }
    func getInputString(_ a: Int, b: Int, c: Int) -> String {
        var inp = String()
        if a > 0 {
            if a == 1 {
                inp += "x^2 "
            }
            else {
                inp += "\(a)x^2 "
            }
        }
        else if a < 0 {
            if a == -1 {
                inp += "-x^2 "
            }
            else {
                inp += "-\(-a)x^2 "
            }
        }
        else {
            inp += ""
        }
        if b > 0 {
            if b == 1 {
                inp += "+ x "
            }
            else {
                inp += "+ \(b)x "
            }
        }
        else if b < 0 {
            if b == -1 {
                inp += "- x "
            }
            else {
                inp += "- \(-b)x "
            }
        }
        else {
            inp += ""
        }
        if c > 0 {
            inp += "+ \(c)"
        }
        else if c < 0{
            inp += "- \(-c)"
        }
        else {
            inp += ""
        }
        return inp
    }
    func connectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
}
