class SRCopyableLabel: UILabel {
    override public var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    func sharedInit() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(
            target: self,
            action: #selector(showMenu(sender:))
        ))
    }
    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
        UIMenuController.shared.setMenuVisible(false, animated: true)
    }
    @objc func showMenu(sender: Any?) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            menu.setTargetRect(bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return (action == #selector(copy(_:)))
    }
}
import UIKit
class forumulasearchTableViewController: UITableViewController,UISearchBarDelegate{
    @IBOutlet var searchbar: UISearchBar!
    let data = ["O level A math Exam formula sheet","Geometry formula sheet","Trigonometry formula sheet"]
    var filteredData: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = data
        searchbar.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(filteredData[indexPath.row],forKey: "formula_select")
        performSegue(withIdentifier: "formulas", sender: nil)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "hi")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = filteredData[indexPath.row].capitalizingFirstLetter()
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        tableView.reloadData()
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchbar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
class searchTableViewController: UITableViewController,UISearchBarDelegate{
    @IBOutlet var searchbar: UISearchBar!
    let data = ["Calculator","Hcf and Lcm Calculator","Prime factorisation","Matrix","Set Language","Quadratic Equations","Grapher","Protractor","Trigo Calculator","Formula sheets","Radomise","Vertex","Binomial expansion"]
    var filteredData: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = data
        searchbar.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: filteredData[indexPath.row].lowercased())
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = UITableViewCell(style: .default, reuseIdentifier: "hi")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = filteredData[indexPath.row].capitalizingFirstLetter()
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        tableView.reloadData()
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchbar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
class searchTableViewController2: UITableViewController,UISearchBarDelegate{
    @IBOutlet var searchbar: UISearchBar!
    let data = ["Prime Numbers, Highest Common Factor, Lowest Common Multiple","Algebraic Manipulation","Data Handling","Estimation and Approximation","Geometrical Constructions","Integers, Rational and Real Numbers","Linear Equations and Formula","Linear Functions and Graphs","Perimeter and Area of plane figures","Simple Inequalities","Direct and Inverse Proportions","Estimation and Approximation","Probability","Pythagoras Theorem and Trigonometry","Matrices","Set Language and Notation","Simultaneous Equations","Algebraic Expressions and Formulae","Graphs of Quadratic Functions","Equations and Inequalities","Congruency and Similarity","All Theorems, Formulae and Identities","Polynomials and Partial Fractions","Surds and Conjugation of Surds","Binomial Theorem","Graphs of Power Functions and Parabolas","Equations and Inequalities(A math)","Exponential and Logarithmic Functions","Linear Law","Modulus Functions","Trigonometric Ratios, Equations and Identities"]
    var filteredData: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = data
        searchbar.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(filteredData[indexPath.row], forKey: "Name")
        self.performSegue(withIdentifier: "show", sender: nil)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "hi")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchbar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
