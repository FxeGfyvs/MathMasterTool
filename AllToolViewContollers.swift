class imagezoomcontroller: UIViewController,UIScrollViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Formula"
        scroll.delegate = self;
        self.scroll.maximumZoomScale = 3.0
        self.scroll.minimumZoomScale = 1.0
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scroll.addGestureRecognizer(doubleTapGest)
        if let load = UserDefaults.standard.string(forKey: "formula_select"){
            print(load)
            if let filePath = Bundle.main.path(forResource: load, ofType: "png"), let image2 = UIImage(contentsOfFile: filePath) {
                image.contentMode = .scaleAspectFit
                image.image = image2
                UserDefaults.standard.removeObject(forKey: "formula_select")
                self.title = load
            }else{alert(message: "Error,could not find image,please report it as an bug")}
        }else{alert(message: "Error")}
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.image
    }
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scroll.zoomScale == 1 {
            scroll.zoom(to: zoomRectForScale(scale: scroll.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        }
        else {
            scroll.setZoomScale(1, animated: true)
        }
    }
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = image.frame.size.height / scale
        zoomRect.size.width  = image.frame.size.width  / scale
        let newCenter = image.convert(center, from: scroll)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    @IBOutlet var scroll: UIScrollView!
    @IBOutlet var image: UIImageView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
class primefactorise: UIViewController{
    @IBOutlet var num_in: UITextField!
    @IBOutlet var result: UITextView!
    var memo = [Int:[Int]]()
    @IBAction func factorise(_ sender: Any) {
        if(num_in.text?.isInt == true && num_in.text?.isEmpty == false){
            let str = primeFactors(n: Int(num_in.text!)!).map { String($0) }.joined(separator: " X ")
            if(str==num_in.text!){
                if(Int(str)!<0){
                   result.text = result.text + "\n" + num_in.text! + " has no prime factors as it is not an positive integer"
                }else{
                    result.text = result.text + "\n" + num_in.text! + " is a prime number"
                }
            }else{
             result.text = result.text + "\n" + num_in.text! + " = " + str
            }
        }else{
            alert(message: "Not valid input please enter an positive integer")
        }
    }
    func primeFactors(n: Int) -> [Int] {
        if n < 4 {
            return [n]
        }
        if(memo.keys.contains(n)){
            return memo[n]!
        }
        let lim = Int(sqrt(Double(n)))
        for x in 2...lim {
            if n % x == 0 {
                var result = [x]
                result.append(contentsOf:primeFactors(n: n / x))
                memo[n] = result
                return result
            }
        }
        memo[n] = [n]
        return [n]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Prime factorisation"
        self.hideKeyboardWhenTappedAround()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
import UIKit
import WebKit
import AVKit
class geogebra: UIViewController,WKUIDelegate,WKNavigationDelegate {
    var webview:WKWebView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Grapher"
        webview = WKWebView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let url = URL(string: "https://www.desmos.com/api/v1.1/docs/examples/fullscreen.html")
        let request = URLRequest(url: url!)
        webview.load(request)
        webview.uiDelegate = self
        webview.navigationDelegate = self
        self.view.addSubview(webview)
        self.view.addSubview(activity)
        self.hideKeyboardWhenTappedAround()
    }
    @IBOutlet var activity: UIActivityIndicatorView!
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        alert(message: String(describing: error))
        activity.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
        print("loaded")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
import Darwin
class expand: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Binomial expansion"
        self.hideKeyboardWhenTappedAround()
    }
    @IBOutlet var txt_a: UITextField!
    @IBOutlet var txt_b: UITextField!
    @IBOutlet var txt_n: UITextField!
    @IBOutlet var result: UITextView!
    @IBAction func expand_action(_ sender: Any) {
        if(txt_a.text!.isInt && txt_b.text!.isInt && txt_n.text!.isInt){
            if(Int(txt_n.text!)! < 21){
                let arr = binominalw(a: Int(txt_a.text!)!, b: Int(txt_b.text!)!, n: Int(txt_n.text!)!)
                let joinedStrings = arr.joined(separator: " + ")
                var expression = "(" + txt_a.text! + "x+"
                expression=expression + txt_b.text! + ")^" + txt_n.text!
                result.text = (result.text + "\n" + expression + " = " + joinedStrings).replacingOccurrences(of: "1x", with: "x")
            }else{
              alert(message: "Please input integer n which is lesser than 21")
            }
        }else{
            alert(message: "Please only input integers")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func binominalw(a:Int,b:Int,n:Int) -> [String] {
        if(n < 1){
            return ["The power should be an integer greater than 1 and less than or equal to 20"]
        }
        if(n == 0){
            return ["1"]
        }
        if(n == 1){
            let mid = String(a) + "x+" + String(b)
            return [mid]
        }
        var arra = [String]()
        for i in 0...n{
            let coef = binomial(n: n,i) * (Int(pow(Double(a),Double(n-i))) * Int(pow(Double(b),Double(i))))
            if(n-i == 1){
                let txt = String(coef)+"x"
                arra.append(txt)
            }else if (n-i == 0){
                let txt = String(coef)
                arra.append(txt)
            }else{
                let txt = String(coef) + "x^" + String(n-i)
                arra.append(txt)
            }
        }
        return arra
    }
    func binomial(n: Int, _ k: Int) -> Int {
        precondition(k >= 0 && n >= 0)
        if (k > n) { return 0 }
        var result = 1
        for i in 0 ..< min(k, n-k) {
            result = (result * (n - i))/(i + 1)
        }
        return result
    }
}
extension Character {
    var unicode: String {
        let unicodeChars = [Character("0"):"\u{2070}",
                            Character("1"):"\u{00B9}",
                            Character("2"):"\u{00B2}",
                            Character("3"):"\u{00B3}",
                            Character("4"):"\u{2074}",
                            Character("5"):"\u{2075}",
                            Character("6"):"\u{2076}",
                            Character("7"):"\u{2077}",
                            Character("8"):"\u{2078}",
                            Character("9"):"\u{2079}",
                            Character("i"):"\u{2071}",
                            Character("+"):"\u{207A}",
                            Character("-"):"\u{207B}",
                            Character("="):"\u{207C}",
                            Character("("):"\u{207D}",
                            Character(")"):"\u{207E}",
                            Character("n"):"\u{207F}"]
        if let unicode = unicodeChars[self] {
            return unicode
        }
        return String(self)
    }
}
extension String {
    var unicodeSuperscript: String {
        let char = Character(self)
        return char.unicode
    }
    func superscripted() -> String {
        let regex = try! NSRegularExpression(pattern: "\\^\\{([^\\}]*)\\}")
        var unprocessedString = self
        var resultString = String()
        while let match = regex.firstMatch(in: unprocessedString, options: .reportCompletion, range: NSRange(location: 0, length: unprocessedString.count)) {
            let substringRange = unprocessedString.index(unprocessedString.startIndex, offsetBy: match.range.location)
            let subString = unprocessedString.prefix(upTo: substringRange)
            resultString.append(String(subString))
            let capturedSubstring = NSAttributedString(string: unprocessedString).attributedSubstring(from: match.range(at: 1)).mutableCopy() as! NSMutableAttributedString
            capturedSubstring.string.forEach { (char) in
                let superScript = char.unicode
                let string = NSAttributedString(string: superScript)
                resultString.append(string.string)
            }
            unprocessedString.deleteCharactersInRange(range: NSRange(location: 0, length: match.range.location + match.range.length))
        }
        resultString.append(unprocessedString)
        return resultString
    }
    mutating func deleteCharactersInRange(range: NSRange) {
        let mutableSelf = NSMutableString(string: self)
        mutableSelf.deleteCharacters(in: range)
        self = mutableSelf as String
    }
}
import UIKit
import WebKit
import AVKit
class verticiecalc: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var array = [String]()
    var num_array = [[Int]]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    @IBOutlet var area_num: UILabel!
    @IBAction func add_verticie(_ sender: Any) {
        print("yes")
        var y_coordinate: UITextField?
        var x_coordinate: UITextField?
        let alertController = UIAlertController(
            title: "Add vertex",
            message: "Please enter the x-coordinate and y-coordinate of vertex",
            preferredStyle: .alert)
        let loginAction = UIAlertAction(
        title: "Add", style: .default) {
            (action) -> Void in
            if let y = y_coordinate?.text, let x = x_coordinate?.text{
                if(y.isInt == true && x.isInt == true){
                    if(Int(y)! > 9999 || Int(x)! > 9999 || Int(x)! < -9999 || Int(y)! < -9999){self.alert(message: "Coordinate too large,please input coordinates between -9999 and 9999")}
                    else{
                    self.array.append(x+","+y)
                    self.num_array.append([Int(x)!,Int(y)!])
                    print(self.array)
                    self.tableview.reloadData()
                    print(self.num_array)
                    self.area_num.text=String(self.calculate(str1: self.num_array))
                    }
                }else{self.alert(message: "Error,input is not an integer")}
            }else{self.alert(message: "No input,please type something in the textfields")}
        }
        let cancelaction = UIAlertAction(title: "Cancel", style: .cancel) { (dontknowwhy) in}
        alertController.addTextField {
            (x) -> Void in
            x_coordinate = x
            x_coordinate!.placeholder = "x_coordinate"
            x_coordinate!.keyboardType = .numberPad
        }
        alertController.addTextField {
            (y) -> Void in
            y_coordinate = y
            y_coordinate!.placeholder = "y_coordinate"
            y_coordinate!.keyboardType = .numberPad
        }
        alertController.addAction(loginAction)
        alertController.addAction(cancelaction)
        present(alertController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Vertices"
    }
    func calculate(str1:[[Int]]) -> Int{
        var total = 0
        var total2 = 0
        if(str1.count > 1){
        for i in py_range(x: str1.count-1){
            total = total + str1[i][0]*str1[i+1][1]
            }
        for i in py_range(x: str1.count-1){
            total2 = total2 + str1[i][1]*str1[i+1][0]
        }
        }
        return Int(0.5*Double(abs(total-total2)))
    }
    func py_range(x:Int) -> [Int] {
        var arr = [Int]()
        var count = 0
        while arr.count < x {
         arr.append(count)
         count = count + 1
        }
        return arr
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "hi")
        cell.textLabel?.text = String(indexPath.row+1) + ") "+"("+array[indexPath.row]+")"
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            array.remove(at: indexPath.row)
            num_array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            area_num.text = String(calculate(str1: num_array))
            tableView.reloadData()
        } else if editingStyle == .insert {
        }
    }
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vertex calculator"
        tableview.dataSource = self
        tableview.delegate = self
        self.hideKeyboardWhenTappedAround()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(addTapped2))
    }
    @objc func addTapped2(){
        area_num.text = "0"
        array.removeAll()
        num_array.removeAll()
        tableview.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
class radomise: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
    var array = [Int:Int]()
    var total = 0.0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "hi")
        print(array)
        if(segmented.selectedSegmentIndex == 0){
            cell.textLabel?.text = String(indexPath.row+1) + ")" + String(data[indexPath.row])
        }else{
            if(array[indexPath.row + 1] != nil){
                let percentage = String(((Double(array[indexPath.row + 1]!) / total) * 100).rounded(toPlaces: 3)) + "%"
                cell.textLabel?.adjustsFontSizeToFitWidth = true
                cell.textLabel?.text = String(indexPath.row + 1) + "'s Occurrences - " + String(array[indexPath.row + 1]!) + " Percentage- " + percentage
                print(array)
            }else{
                cell.textLabel?.adjustsFontSizeToFitWidth = true
                cell.textLabel?.text = String(indexPath.row + 1) + "'s Occurrences - 0 Percentage- 0%"
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var name = "Datapoints"
        if(segmented.selectedSegmentIndex == 0){
            name = "Datapoints"
        }else{
            name = "Summary"
        }
        return name
    }
    var data : [Int] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(segmented.selectedSegmentIndex == 0){
            return data.count
        }else{
            return Int(maxnumber.text!) ?? 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    @IBAction func changed(_ sender: Any) {
        if(maxnumber.text!.isInt){
            if(Int(maxnumber.text!)!>999999){
                alert(message: "Please enter an positive integer for the max number that is not more than 999999")
            }else{
             tableview.reloadData()
            }
        }else{alert(message: "Please enter an positive integer for the max number that is not more than 999999")}
    }
    @IBAction func havechanged(_ sender: Any) {
        total = 0.0
        data.removeAll()
        array.removeAll()
        tableview.reloadData()
    }
    func showinputdialog(){
        let alertController = UIAlertController(title: "Generate", message: "How many datapoints would you like to generate?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            let num = alertController.textFields?[0].text
            if(num!.isInt){
                if(Int(num!)! > 0){
                    if(Int(num!)! > 99999){
                        self.alert(message: "Number of data points too huge,please input an integer between 1 and 99999")
                        return
                    }
                    if(self.maxnumber.text!.isEmpty){self.alert(message: "Max number not specified")}else{
                        if(self.maxnumber.text!.isInt){
                            if(Int(self.maxnumber.text!)! > 0){
                                for _ in 1...Int(num!)! {
                                    let randomInt = Int(arc4random_uniform(UInt32(self.maxnumber.text!)!) + 1)
                                    self.data.append(randomInt)
                                    if self.array[randomInt] != nil {
                                        self.array[randomInt] = self.array[randomInt]! + 1
                                    }else{
                                        self.array[randomInt] = 1
                                    }
                                    self.total = self.total + 1
                                }
                                self.tableview.reloadData()
                            }else{self.alert(message: "Max number is not a positive integer")}
                        }else{self.alert(message: "Max number is not a positive integer")}
                    }
                }else{self.alert(message: "")}
            }else{self.alert(message: "")}
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Number"
            textField.keyboardType = .numberPad
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBOutlet var number: UILabel!
    @IBOutlet var segmented: UISegmentedControl!
    @IBOutlet var maxnumber: UITextField!
    @IBOutlet var tableview: UITableView!
    @IBAction func quickgenerate(_ sender: Any) {
        showinputdialog()
    }
    @IBAction func touched(_ sender: Any) {
        if(UInt32(maxnumber.text!) != nil && Int(maxnumber.text!)! > 0){
            let randomInt = Int(arc4random_uniform(UInt32(maxnumber.text!)!) + 1)
            data.append(randomInt)
            number.text = String(randomInt)
            if array[randomInt] != nil {
                array[randomInt] = array[randomInt]! + 1
                tableview.reloadData()
            }else{
                array[randomInt] = 1
                tableview.reloadData()
            }
            total = total + 1
        }else{
            alert(message: "The max is either not specified or not an integer")
        }
    }
    override func viewDidLoad() {
        self.title = "Probability"
        maxnumber.delegate = self
        tableview.dataSource = self
        tableview.delegate = self
        maxnumber.delegate = self
        maxnumber.addDoneButtonToKeyboard(myAction:  #selector(self.maxnumber.resignFirstResponder))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(addTapped2))
    }
    @objc func addTapped2(){
        maxnumber.text = "2"
        number.text = "0"
        array.removeAll()
        total = 0.0
        data.removeAll()
        tableview.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension UITextField{
    func addDoneButtonToKeyboard(myAction:Selector?){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
}
extension UITextField {
    func setBottomBorder(i:UIColor) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = i.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
class trigo: UIViewController{
    @IBOutlet var a: UITextField!
    @IBOutlet var b: UITextField!
    @IBOutlet var c: UITextField!
    var count = 0
    var x = RightTriangle(length: 0, width: 0)
    var missingvalue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.title = "Trigo calculator"
    }
    @IBAction func update(_ sender: Any) {
        if(Int(a.text!) != nil){
            count = count + 1
            x = RightTriangle(length: Double(a.text!)!, width: x.width)
        }else{
            missingvalue = "a"
        }
        print(x)
        if(Int(b.text!) != nil){
            count = count + 1
            x = RightTriangle(length: x.length, width: Double(b.text!)!)
        }else{
            missingvalue = "b"
        }
        print(x)
        if(Int(c.text!) != nil){
            count = count + 1
            x.hypotenuse = Double(c.text!)!
        }else{
            missingvalue = "c"
        }
        if(count == 2){
            print(x)
            if(missingvalue == "a"){
                a.text = String(x.length)
            }else if(missingvalue == "b"){
                b.text = String(x.width)
            }else if(missingvalue == "c"){
                c.text = String(x.hypotenuse)
            }
        }else if(count == 3){
            alert(message: "No unknown")
        }else{
            alert(message: "More than one unknown")
        }
        count = 0
    }
    struct RightTriangle: CustomStringConvertible {
        private var _length: Double
        private var _width: Double
        var length: Double {
            get {
                return _length
            }
            set {
                let h = self.hypotenuse
                _length = newValue
                _width = sqrt(h * h - _length * _length)
            }
        }
        var width: Double  {
            get {
                return _width
            }
            set {
                let h = self.hypotenuse
                _width = newValue
                _length = sqrt(h * h - _width * _width)
            }
        }
        var hypotenuse: Double {
            get {
                return sqrt(length * length + width * width)
            }
            set {
                _width = sqrt((newValue * newValue) - (length * length))
            }
        }
        init(length: Double, width: Double) {
            _length = length
            _width = width
        }
        var description: String {
            return "length = \(length), width = \(width), hypotenuse = \(hypotenuse)"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
import Accelerate
import simd
typealias LAInt = __CLPK_integer
class simuleqn: UIViewController {
    @IBOutlet var first_equation_x: UITextField!
    @IBOutlet var first_equation_result: UITextField!
    @IBOutlet var first_equation_y: UITextField!
    @IBOutlet var second_equation_x: UITextField!
    @IBOutlet var second_equation_y: UITextField!
    @IBOutlet var second_equation_result: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    @IBAction func submit(_ sender: Any) {
        if(Int(first_equation_x.text!) != nil && Int(first_equation_y.text!) != nil && Int(first_equation_result.text!) != nil && Int(second_equation_x.text!) != nil && Int(second_equation_y.text!) != nil && Int(second_equation_result.text!) != nil && Int(first_equation_x.text!) != nil){
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
class potractor: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {
    let captureSession = AVCaptureSession()
    var previewLayer:CALayer!
    var captureDevice:AVCaptureDevice!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareCamera()
    }
    func prepareCamera() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
        captureDevice = availableDevices.first
        beginSession()
    }
    @IBOutlet var image: UIImageView!
    @IBOutlet var label: UILabel!
    func beginSession () {
        if(captureDevice != nil){
            do {
                let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
                captureSession.addInput(captureDeviceInput)
            }catch {
                print(error.localizedDescription)
            }
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            self.previewLayer = previewLayer
            self.view.layer.addSublayer(self.previewLayer)
            view.bringSubviewToFront(image)
            view.bringSubviewToFront(label)
            self.previewLayer.frame = self.view.layer.frame
            captureSession.startRunning()
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString):NSNumber(value:kCVPixelFormatType_32BGRA)] as [String : Any]
            dataOutput.alwaysDiscardsLateVideoFrames = true
            if captureSession.canAddOutput(dataOutput) {
                captureSession.addOutput(dataOutput)
            }
            captureSession.commitConfiguration()
            let queue = DispatchQueue(label: "com.brianadvent.captureQueue")
            dataOutput.setSampleBufferDelegate(self, queue: queue)
        }else{
            alert(message: "Error")
        }
    }
    func stopCaptureSession () {
        self.captureSession.stopRunning()
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                self.captureSession.removeInput(input)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let screenSize = previewLayer.bounds.size
        if let touchPoint = touches.first {
            let x = touchPoint.location(in: self.view).y / screenSize.height
            let y = 1.0 - touchPoint.location(in: self.view).x / screenSize.width
            let focusPoint = CGPoint(x: x, y: y)
            if let device = captureDevice {
                do {
                    try device.lockForConfiguration()
                    device.focusPointOfInterest = focusPoint
                    device.focusMode = .autoFocus
                    device.exposurePointOfInterest = focusPoint
                    device.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
                    device.unlockForConfiguration()
                }
                catch {
                }
            }
        }
    }
}
class sets: UIViewController {
    @IBOutlet var select: UISegmentedControl!
    @IBOutlet var set_a: UITextField!
    @IBOutlet var set_b: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    @IBOutlet var result: UITextView!
    @IBAction func submit(_ sender: Any) {
        let setatext : Set = Set(set_a.text!.components(separatedBy: ","))
        let setbtext : Set = Set(set_b.text!.components(separatedBy: ","))
        if(setatext != nil && setbtext != nil){
            if(select.selectedSegmentIndex == 0){
                result.text = [String](setatext.union(setbtext)).description
            }else if(select.selectedSegmentIndex == 1){
                result.text = [String](setatext.intersection(setbtext)).description
            }else if(select.selectedSegmentIndex == 2){
                result.text = String(setatext.isSubset(of: setbtext))
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
class lcmandhcf: UIViewController {
    @IBOutlet var number1: UITextField!
    @IBOutlet var number: UITextField!
    @IBOutlet var select: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    @IBAction func Calcualte(_ sender: Any) {
        if(Int(number1.text!) != nil && Int(number.text!) != nil && Int(number.text!) != 0 && Int(number.text!) != 0){
            if(select.selectedSegmentIndex == 0){
                alert(message: String(lcm(num1: Int(number1.text!)!, num2: Int(number.text!)!)))
            }else if(select.selectedSegmentIndex == 1){
                alert(message: String(hcf(num1: Int(number1.text!)!, num2: Int(number.text!)!)))
            }
            else if(select.selectedSegmentIndex == 2){
                alert(message: String(gcd(num1: Int(number1.text!)!, num2: Int(number.text!)!)))
            }
        }
    }
    func hcf(num1: Int, num2: Int) -> Int {
        var numA = num1
        var numB = num2
        while numA != 0 && numB != 0 {
            if numA >= numB {
                numA %= numB
            } else {
                numB %= numA
            }
        }
        return max(numA, numB)
    }
    func gcd(num1: Int, num2: Int) -> Int {
        if num2 == 0 {
            return num1
        }else {
            return gcd(num1: num2, num2: num1 % num2)
        }
    }
    func lcm(num1: Int, num2: Int) -> Int {
        return num1 * num2 / gcd(num1: num1, num2: num2)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
class Matrix: UIViewController {
    @IBOutlet var matrixa: UITextField!
    @IBOutlet var rowmatrixa: UITextField!
    @IBOutlet var matrixb: UITextField!
    @IBOutlet var rwomatrixb: UITextField!
    @IBOutlet var answere: UITextView!
    var matrixA = [[Int]]()
    var matrixB = [[Int]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    @IBAction func submit(_ sender: Any) {
        print("New:")
        matrixA = []
        matrixB = []
        if(matrixa.text != "" && matrixb.text != "" && Int(rowmatrixa.text!) != nil && Int(rwomatrixb.text!) != nil){
            var mata = matrixa.text?.components(separatedBy: ",").map { Int($0)!}
            print((mata?.count)! % Int(rowmatrixa.text!)!)
            if((mata?.count)! % Int(rowmatrixa.text!)! == 0){
                var initial = 0
                var deivide = (mata?.count)! / Int(rowmatrixa.text!)!
                print(deivide)
                for _ in 1 ... deivide{
                    var lol:[Int] = []
                    for _ in 0 ... Int(rowmatrixa.text!)! - 1{
                        lol.append(mata![initial])
                        initial =  initial + 1
                    }
                    matrixA.append(lol)
                }
                mata = matrixb.text?.components(separatedBy: ",").map { Int($0)!}
                initial = 0
                deivide = (mata?.count)! / Int(rwomatrixb.text!)!
                print(deivide)
                for _ in 1 ... deivide{
                    var lol:[Int] = []
                    for _ in 0 ... Int(rwomatrixb.text!)! - 1{
                        lol.append(mata![initial])
                        initial =  initial + 1
                    }
                    print(lol)
                    matrixB.append(lol)
                }
                prettyPrintMatrix( matrixA)
                let result = multiply( matrixA, matrixB )
                print( "Result:")
                prettyPrintMatrix(result)
                print(prettyMatrixdisplay(result))
                if(result.isEmpty){
                    answere.text = "Illegal matrix dimensions!"
                }else{
                    answere.text = prettyMatrixdisplay(result).replacingOccurrences(of: ",]", with: "]")
                }
            }else{
                alert(message: "Error")
                print("error1")
            }
        }else{
            alert(message: "Error")
            print("error2")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func prettyPrintMatrix( _ matrix:[[Int]] ) {
        print("Matrix:")
        for array in matrix {
            print( array )
        }
    }
    func prettyMatrixdisplay( _ matrix:[[Int]])-> String {
        var final = ""
        for array in matrix {
            final.append("[")
            for i  in array{
                final.append(String(i) + ",")
            }
            final.append("]")
            final.append("\n")
        }
        return final
    }
    func multiply( _ matrixA:[[Int]], _ matrixB:[[Int]]) -> [[Int]] {
        if matrixA[ 0 ].count != matrixB.count {
            print( "Illegal matrix dimensions!" )
            alert(message: "Illegal matrix dimensions!")
            return [[]] 
        }
        let size = matrixA.count
        var result:[[Int]] = [[Int]]( repeating: [Int]( repeating: 0, count: size ), count: size )
        for i in 0..<result.count {
            for j in 0..<matrixB.count {
                for k in 0..<matrixB[0].count {
                    result[i][k] += matrixA[i][j] * matrixB[j][k]
                }
            }
        }
        return result
    }
}
class twodarea: UIViewController {
    let shape = CAShapeLayer()
    let path = UIBezierPath()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(shape)
        shape.opacity = 0.5
        shape.lineWidth = 2
        shape.lineJoin = CAShapeLayerLineJoin.miter
        shape.strokeColor = UIColor(hue: 0.786, saturation: 0.79, brightness: 0.53, alpha: 1.0).cgColor
        shape.fillColor = UIColor(hue: 0.786, saturation: 0.15, brightness: 0.89, alpha: 1.0).cgColor
        path.move(to: CGPoint(x: 0, y: 0))
    }
    var corordinates :[CGPoint]=[]
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        path.removeAllPoints()
        if(corordinates.count == 0){
            path.move(to: location)
            drawdot(location: location)
        }else{
            path.move(to: corordinates[0])
            drawdot(location: location)
        }
        corordinates.append(location)
        for i in corordinates{
            print(i)
            path.addLine(to: i)
            drawdot(location: location)
        }
        path.close()
        shape.path = path.cgPath
    }
    func drawdot (location:CGPoint){
        let circlePath = UIBezierPath(arcCenter: location, radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.gray.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3.0
        view.layer.addSublayer(shapeLayer)
    }
}
extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
