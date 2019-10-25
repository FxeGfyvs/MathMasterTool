import UIKit
class secondary: UITableViewController {
    var secondarynotes : [Int:[notes]] = [
        1:
            [notes(title: "Prime Numbers, Highest Common Factor, Lowest Common Multiple", icon: "chapter1logo.png"),notes(title: "Algebraic Manipulation", icon: "chapter1logo.png"),notes(title: "Data Handling", icon: "chapter2logo.png"),notes(title: "Estimation and Approximation", icon: "chapter3logo.png"),notes(title: "Geometrical Constructions", icon: "chapter4logo.png"),notes(title: "Integers, Rational and Real Numbers", icon: "chapter4logo.png"),notes(title: "Linear Equations and Formula", icon: "chapter4logo.png"),notes(title: "Linear Functions and Graphs", icon: "chapter4logo.png"),notes(title: "Perimeter and Area of plane figures", icon: "chapter4logo.png"),notes(title: "Simple Inequalities", icon: "chapter4logo.png")],
        2:
            [notes(title: "Algebraic Expressions and Formulae", icon: "chapter1logo.png"),notes(title: "Graphs of Quadratic Functions", icon: "chapter2logo.png"),notes(title: "Simultaneous Equations", icon: "chapter3logo.png"),notes(title: "Equations and Inequalities", icon: "chapter3logo.png"),notes(title: "Matrices", icon: "chapter4logo.png"),notes(title: "Congruency and Similarity", icon: "chapter4logo.png"),notes(title: "Ratio and proportion", icon: "chapter4logo.png"),notes(title: "Direct and Inverse Proportions", icon: "chapter4logo.png"),notes(title: "Pythagoras Theorem and Trigonometry", icon: "chapter4logo.png"),notes(title: "Set Language and Notation", icon: "chapter4logo.png"),notes(title: "Probability", icon: "chapter4logo.png")],
        3:
            [notes(title: "All Theorems, Formulae and Identities", icon: "chapter1logo.png"),notes(title: "Polynomials and Partial Fractions", icon: "chapter2logo.png"),notes(title: "Surds and Conjugation of Surds", icon: "chapter3logo.png"),notes(title: "Binomial Theorem", icon: "chapter4logo.png"),notes(title: "Graphs of Power Functions and Parabolas", icon: "chapter4logo.png"),notes(title: "Equations and Inequalities(A math)", icon: "chapter4logo.png"),notes(title: "Exponential and Logarithmic Functions", icon: "chapter4logo.png"),notes(title: "Linear Law", icon: "chapter4logo.png"),notes(title: "Modulus Functions", icon: "chapter4logo.png"),notes(title: "Trigonometric Ratios, Equations and Identities", icon: "chapter4logo.png")],
        4:
            [notes(title: "Formulas", icon: "chapter1logo.png"),notes(title: "Yes", icon: "chapter2logo.png"),notes(title: "Chapter 3", icon: "chapter3logo.png"),notes(title: "Chapter 4", icon: "chapter4logo.png")],
    ]
    var index = UserDefaults.standard.integer(forKey: "index")
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        } else {
        }
        self.tableView.rowHeight = 89
        var string : [String] = ["Secondary 1", "Secondary 2","Secondary 3","Secondary 4"]
        self.title = string[index-1]
    }
    struct notes {
        var title:String
        var icon:String
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.rowHeight = 89
        return (secondarynotes[index]?.count)!
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        self.tableView.rowHeight = 89
        let titlelbl = cell.viewWithTag(1) as! UILabel
        titlelbl.adjustsFontSizeToFitWidth = false
        titlelbl.text = secondarynotes[index]![indexPath.row].title
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(secondarynotes[index]![indexPath.row].title, forKey: "Name")
    }
}
