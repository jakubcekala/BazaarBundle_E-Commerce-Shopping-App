//
//  CartViewController.swift
//  Shopping-App-eCommerce
//
//  Created by Osman Emre Ömürlü on 3.02.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SDWebImage
import Alamofire


class CartViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    let currentUserUid = Auth.auth().currentUser?.uid
    
    var totalCartCost: Double = 0
    var cart: [String: Int]? = [:]
    
    static var cartItems: [ProductModel] = []
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        listener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        totalCartCost = 0
    }
    
    
    //MARK: - bsi bsi handlers DUZELTILECEK BURASI
    @IBAction func checkoutButtonPressed(_ sender: UIButton) {
        //to-do
    }
    
    //MARK: - Functions
    func tableViewSetup() {
        tableView.register(UINib(nibName: K.TableView.cartTableViewCell, bundle: nil), forCellReuseIdentifier: K.TableView.cartTableViewCell)
        tableView.rowHeight = CGFloat(160)
    }
    
    func fetchItemsFromAPI(productId: String, quantity: Int)  {
        print("api func working")
        AF.request("\(K.Network.baseURL)/\(productId)").response { response in
            switch response.result {
            case .success(_):
                do {
                    let productData = try JSONDecoder().decode(ProductData.self, from: response.data!)
                    CartViewController.cartItems.append(ProductModel(id: productData.id, title: productData.title, price:Float(productData.price), image: productData.image, rate: Float(productData.rating.rate), category: productData.category, description: productData.description, count: productData.rating.count, quantityCount: quantity))
                    
                    //Urunleri fiyatina gore siralar.
                    CartViewController.cartItems.sort(by: { $0.price! < $1.price! })
                    
                    DispatchQueue.main.async {
                        self.totalCartCost += productData.price * Double(quantity)
                        self.totalPriceLabel.text = "$\(self.totalCartCost)"
                        self.tableView.reloadData()
                    }
                } catch let error {
                    print("Decoding error: \(error)")
                }
            case .failure(let error):
                DuplicateFuncs.alertMessage(title: "Network error", message: error.localizedDescription, vc: self)
            }
        }
    }
    
    func listener() {
        database.collection("users").document(currentUserUid!).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching documents: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            
            for productId in data.keys {
                let productQuantity = data[productId]
                print("id: \(productId) ve adet: \(productQuantity!)")
                self.fetchItemsFromAPI(productId: productId, quantity: productQuantity as! Int)
            }
            
            CartViewController.cartItems = []
            self.totalCartCost = 0
        }
    }
    
    @objc func minusButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let id = CartViewController.cartItems[index].id
        print("Button at index: \(index) was tapped. ID: \(id!)")
        updateProductQuantityOnFirestore(productId: id!, increment: false)
    }
    
    @objc func plusButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let id = CartViewController.cartItems[index].id
        print("Button at index: \(index) was tapped. ID: \(id!)")
        updateProductQuantityOnFirestore(productId: id!, increment: true)
    }
    
    func updateProductQuantityOnFirestore(productId: Int, increment: Bool) {
        let userRef = database.collection("users").document(currentUserUid!)
        
        userRef.getDocument { document, error in
            guard let document = document else { return }
            let currentQuantity = document.data()!["\(productId)"] as! Int
            let updatedQuantity = currentQuantity
            
            if increment {
                if updatedQuantity < 10 {
                    userRef.updateData(["\(productId)": FieldValue.increment(Int64(1))]) { error in
                        if let _ = error {
                            DuplicateFuncs.alertMessage(title: "ERROR", message: "Product quantity could not be changed", vc: self)
                        }
                    }
                }
            } else {
                if updatedQuantity > 1 {
                    userRef.updateData(["\(productId)": FieldValue.increment(Int64(-1))]) { error in
                        if let _ = error {
                            DuplicateFuncs.alertMessage(title: "ERROR", message: "Product quantity could not be changed", vc: self)
                        }
                    }
                }
            }
        }
    }
}

//MARK: - Extensions
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartViewController.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableView.cartTableViewCell, for: indexPath) as! CartTableViewCell
        let u = CartViewController.cartItems[indexPath.row]
        cell.productImageView.sd_setImage(with: URL(string: u.image!), placeholderImage: UIImage(named: "placeholderImage.jpg"))
        cell.productPriceLabel.text = "$\(u.price ?? -1)"
        cell.productTitleLabel.text = u.title
        cell.productQuantity.text = "\(String(describing: u.quantityCount!))"
        
        cell.plusButton.tag = indexPath.row
        cell.plusButton.addTarget(self, action: #selector(plusButtonTapped(_:)), for: .touchUpInside)
        
        cell.minusButton.tag = indexPath.row
        cell.minusButton.addTarget(self, action: #selector(minusButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    //Disable cell click behavior
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
