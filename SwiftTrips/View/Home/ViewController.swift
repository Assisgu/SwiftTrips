//
//  ViewController.swift
//  SwiftTravels
//
//  Created by Gustavo Assis on 11/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viagensTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraTableView()
        view.backgroundColor = UIColor.systemBrown
        if #available(iOS 15.0, *) {
            viagensTableView.sectionHeaderTopPadding = 0.0
        }
    }
        
    func configuraTableView(){
        viagensTableView.dataSource = self
        viagensTableView.delegate = self
        viagensTableView.register(UINib(nibName: "ViagemTableViewCell", bundle: nil), forCellReuseIdentifier: "ViagemTableViewCell")
        viagensTableView.register(UINib(nibName: "OfertaTableViewCell", bundle: nil), forCellReuseIdentifier: "OfertaTableViewCell")
    }
        
    func irParaDetalhes(_ viagem: Viagem?){
        if let viagemSelectionada = viagem {
            let detalheController = DetalheViewController.instanciar(viagemSelectionada)
            navigationController?.pushViewController(detalheController, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sessaoDeViagens?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessaoDeViagens?[section].numeroDeLinhas ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let viewModel = sessaoDeViagens?[indexPath.section]
        
        switch viewModel?.tipo {
            case .destaques:
            
                guard let celulaViagem = tableView.dequeueReusableCell(withIdentifier: "ViagemTableViewCell") as? ViagemTableViewCell else {
                    fatalError("error to create ViagemTableViewCell")
                }
                celulaViagem.configuraCelula(viewModel?.viagens[indexPath.row])
                return celulaViagem
            
            case .ofertas:
            
                guard let celulaOferta = tableView.dequeueReusableCell(withIdentifier: "OfertaTableViewCell") as? OfertaTableViewCell else {
                    fatalError("error to create OfertaTableViewCell")
                }
            celulaOferta.delegate = self
            celulaOferta.configuraCelula(viewModel?.viagens)
            
            return celulaOferta
            
            default:
                return UITableViewCell()
        }
        
    }
}

extension ViewController: UITableViewDelegate {
    
    //MARK: - Adicionando header na primeira section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = Bundle.main.loadNibNamed("HomeTableViewHeader", owner: self, options: nil)?.first as? HomeTableViewHeader
            headerView?.configuraView()
            return headerView
        }
        return nil
    }
    
    //MARK: - Deifinindo altura do header da primeira section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 300
        }
        return 0
    }
    
    //MARK: - Deifinindo altura das linhas
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 400 : 430
    }
    
    //MARK: - Função para realizar ação com clique na celula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        let viewModel = sessaoDeViagens?[indexPath.section]
        
        switch viewModel? .tipo {
        case .destaques, .internacionais:
            let viagemSelecionada = viewModel?.viagens[indexPath.row]
            irParaDetalhes(viagemSelecionada)
            
        default: break
        }

    }
    
}

extension ViewController: OfertaTableViewCellDelegate {
    func didSelectView(_ viagem: Viagem?) {
        irParaDetalhes(viagem)
    }
}
