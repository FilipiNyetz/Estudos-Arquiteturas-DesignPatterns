import UIKit

class ViewController: UIViewController {

   //Esse é o código da view, no qual existe a referência para a imagem no storyboard
    @IBOutlet weak var imageView: UIImageView!
    
    //Url da imagem
    let imgUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-Ye4roQZisK-p7QljeeSJnA9G4_iJCXInUg&s"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // A ViewController apenas pede a imagem, sem se preocupar com detalhes
        //Fazendo instância com a estrutura do facade
        Facade().setImage(imageView: imageView, url: imgUrl)
    }
}


//Essa é a estrutura da fachada, ela tem o objetivo de esconder a lógica do download, expondo apenas o método setImage e ocultando o método "complexo" de downloadImage
struct Facade {
    func setImage(imageView: UIImageView, url: String) {
        Task {
            guard let image = await downloadImage(url: url) else { return }
            imageView.image = image
        }
    }

    private func downloadImage(url: String) async -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print("Erro ao baixar imagem:", error.localizedDescription)
            return nil
        }
    }
}
