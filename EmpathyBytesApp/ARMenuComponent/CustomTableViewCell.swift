import UIKit
import simd

class CustomTableViewCell: UITableViewCell {
    //String used to register to a tableView
    static let identifier = "CustomTableViewCell"
    static let imageViewLeadingAnchorConstant: CGFloat = 12
    
    private let cellImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named:"ToyAirplane")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private let cellLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17,weight: .bold)
        return label
    }()

    //Tableview calls this method interally when initiializing and dequeuing the cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.backgroundColor = .orange
        contentView.addSubview(cellLabel)
        contentView.addSubview(cellImageView)
        setTitleLabelConstraints()
        setImageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* Parent Tableview class calls this method and sets the image and label */
    public func configure(text: String, imageName: String) {
        cellLabel.text = text
        cellImageView.image = UIImage(named:imageName)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellLabel.text = nil
        cellImageView.image = nil
    }
    
    /* Constrains for the Image */
    func setImageConstraints() {
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true;
        cellImageView.leadingAnchor.constraint(equalTo: cellLabel.trailingAnchor).isActive = true
        cellImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor,multiplier: 16/9).isActive = true
        cellImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12).isActive = true
    }
    
    /* Constrains for the Label */
    func setTitleLabelConstraints() {
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        cellLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
}
