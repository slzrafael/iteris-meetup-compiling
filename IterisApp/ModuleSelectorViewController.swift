import UIKit
import ModuleA
import ModuleB

protocol ModuleSelectorDelegate: AnyObject {
    func goTo(vc: UIViewController)
}

public class ModuleSelectorViewController: UIViewController {
    private lazy var contentView: UIView = {
        let view = ModuleSelectorView(frame: .zero)
        view.delegate = self
        
        return view
    }()

    public override func loadView() {
        self.view = contentView
    }
}

extension ModuleSelectorViewController: ModuleSelectorDelegate {
    func goTo(vc: UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
}

class ModuleSelectorView: UIView {
    weak var delegate: ModuleSelectorDelegate?

    private let stack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .center
        
        return stack
    }()

    private let caption: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SELECIONE O MODULO"

        return label
    }()

    private lazy var buttonModuleA: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("ABRIR MODULO A", for: .normal)
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)

        return button
    }()

    private lazy var buttonModuleB: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("ABRIR MODULO B", for: .normal)
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)

        return button
    }()

    @objc
    func onTap(_ sender: UIButton) {
        switch sender {
        case buttonModuleA:
            self.delegate?.goTo(vc: ModuleAViewController())
        case buttonModuleB:
            self.delegate?.goTo(vc: ModuleBViewController())
        default:
            break
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(stack)

        self.stack.addArrangedSubview(caption)
        self.stack.addArrangedSubview(buttonModuleA)
        self.stack.addArrangedSubview(buttonModuleB)

        self.buttonModuleA.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        self.buttonModuleA.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        self.buttonModuleB.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        self.buttonModuleB.heightAnchor.constraint(equalToConstant: 120.0).isActive = true

        self.stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
