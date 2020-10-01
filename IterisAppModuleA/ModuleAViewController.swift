import UIKit
import DynamicModule
import StaticModule

public class ModuleAViewController: UIViewController {
    private let contentView = ModuleView(frame: .zero)

    public override func loadView() {
        self.view = contentView
    }
}

class ModuleView: UIView {
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
        label.text = "MODULE A"

        return label
    }()

    private let messageFromStaticModule: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var buttonStaticModule: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("call static module", for: .normal)
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)

        return button
    }()

    private let messageFromDynamicModule: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var buttonDynamicModule: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("call dynamic module", for: .normal)
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)

        return button
    }()

    @objc
    func onTap(_ sender: UIButton) {
        switch sender {
        case buttonStaticModule:
            self.messageFromStaticModule.text = StaticLibrary().hello()
        case buttonDynamicModule:
            self.messageFromDynamicModule.text = DynamicLibrary().hello()
        default:
            break
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(stack)

        self.stack.addArrangedSubview(caption)
        self.stack.addArrangedSubview(messageFromStaticModule)
        self.stack.addArrangedSubview(buttonStaticModule)
        self.stack.addArrangedSubview(messageFromDynamicModule)
        self.stack.addArrangedSubview(buttonDynamicModule)

        self.buttonStaticModule.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        self.buttonStaticModule.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        self.buttonDynamicModule.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        self.buttonDynamicModule.heightAnchor.constraint(equalToConstant: 120.0).isActive = true

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