import UIKit

class GradeCell : UICollectionViewCell{
    
    @IBOutlet weak var gradeNameLabel: UILabel!
    
    var gradeName: String{
        didSet{
            gradeNameLabel.text = gradeName;
        }
    }
    
    override var isSelected: Bool{
        didSet{
            gradeNameLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 23) : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)

        }
    }
    
    
    required init?(coder aDecoder: NSCoder){
        self.gradeName = "";
        super.init(coder: aDecoder);
    }
}
