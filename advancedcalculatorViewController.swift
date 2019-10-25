import Expression
import UIKit
class advancedcalculatorViewController: UIViewController, UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    var array : [String] = ["Sqrt(x)","Floor(x)","Ceil(x)","Round(x)","Cos(x)","Acos(x)","Sin(x)","Asin(x)","Tan(x)","Atan(x)","Abs(x)","Pow(x,y)","Atan2(x,y)","Mod(x,y)"]
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Suported functions"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        inputField.text = inputField.text! + array[indexPath.row].replacingOccurrences(of: "x)", with: "").replacingOccurrences(of: "x,y)", with: "")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let label = cell.viewWithTag(1) as? UILabel
        label?.text = array[indexPath.row]
        return cell
    }
    @IBOutlet var outputview: UITextView!
    @IBOutlet var inputField: UITextField!
    private var output = NSMutableAttributedString()
    var answerevalue = -1.0
    private func addOutput(_ string: String, color: UIColor) {
        let text = NSAttributedString(string: string + "\n\n", attributes: [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: outputview.font!,
            ])
        output.replaceCharacters(in: NSMakeRange(0, 0), with: text)
        outputview.attributedText = output
    }
    @objc func addTapped() {
        outputview.text = "Regular operators like \" + , - , / , * \" are supported."
        inputField.resignFirstResponder()
        inputField.text = ""
        answerevalue = -1.0
    }
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        output.append(outputview.attributedText)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 70
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(addTapped))
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if var text = textField.text, text != "" {
            text = text.lowercased()
            if(text == "kangjingisbetterthanonnkitinmath"){
                addOutput("Its always True", color: .black)
                return false
            }
            if(text == "onnkitisbetterthankangjinginmath"){
                addOutput("Its always False", color: .black)
                return false
            }
            if(text == "mryeo"){
                addOutput("The all mighty Mr Yeo", color: .black)
                return false
            }
            if(text.replacingOccurrences(of: " ", with: "") == "0/0"){
                addOutput("Imagine that you have zero cookies and you split them evenly among zero friends. How many cookies does each person get? See? It doesn't make sense. And Cookie Monster is sad that there are no cookies, and you are sad that you have no friends.", color: .black)
                return false
            }
            if(text.replacingOccurrences(of: " ", with: "") == "meaningoflife"){
                addOutput("42", color: .black)
                return false
            }
            text = text.replacingOccurrences(of: ")(", with: ")*(")
            text = text.replacingOccurrences(of: "--", with: "+")
            var st1ring = "+"
            let initial = text.count
            for y in 1 ... text.count{
                print(y)
                st1ring = "+"
                for _ in 1 ... (initial-y+1){
                    st1ring = st1ring + "+"
                }
                print(st1ring)
                text = text.replacingOccurrences(of: st1ring, with: "+")
            }
            text = text.replacingOccurrences(of: "+-", with: "-")
            text = text.replacingOccurrences(of: "-+", with: "-")
            let before = text
            if(answerevalue != -1.0){
            text = text.lowercased()
            text = text.replacingOccurrences(of: "ans", with: String(answerevalue))
            }
            do {
                let result = try Expression(text).evaluate()
                answerevalue = result
                addOutput( before + String(format: " = %g", result) , color: .black)
            } catch {
                addOutput("\(error)", color: .red)
            }
        }
        return false
    }
    @IBAction func valuechanged(_ sender: Any) {
        if(inputField.text != "") && (inputField.text?.count)! > 1{
           var text = inputField.text
            print(text ?? "error")
            let index = text?.index((text?.startIndex)!, offsetBy: (text?.count)! - 2)
            print(text?.count ?? "error")
            print(String(text![index!]))
            print(text?.last ?? "error")
            if(String((text?.last!)!) == "(" && (Int(String(text![index!])) != nil)){
                text = String((text?.dropLast())!)
                text = text! + "*("
                inputField.text = text
            }
        }
    }
}
