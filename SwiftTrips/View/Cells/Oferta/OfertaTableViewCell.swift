//
//  OfertaTableViewCell.swift
//  SwiftTrips
//
//  Created by Gustavo Assis on 16/01/24.
//

import UIKit

protocol OfertaTableViewCellDelegate: AnyObject {
    func didSelectView(_ viagem: Viagem?)
}

class OfertaTableViewCell: UITableViewCell {
    

    //MARK: - IBOutlets
    @IBOutlet var viagemImages: [UIImageView]!
    @IBOutlet var tituloViagemLabels: [UILabel]!
    @IBOutlet var subtituloViagemLabels: [UILabel]!
    @IBOutlet var precoSemDescontoLabels: [UILabel]!
    @IBOutlet var precoLabels: [UILabel]!
    @IBOutlet var fundoViews: [UIView]!
    
    private var viagens: [Viagem]?
    weak var delegate: OfertaTableViewCellDelegate?
    
    func configuraCelula(_ viagens: [Viagem]?){
        self.viagens = viagens
        guard let listaDeViagem = viagens else { return }
        
        for i in 0..<listaDeViagem.count {
            setOutlets(i, viagem: listaDeViagem[i])
        }
        
        fundoViews.forEach { viewAtual in
            viewAtual.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectView(_ :))))
            viewAtual.addSombra()
        }
    }
    
    func setOutlets(_ index: Int, viagem: Viagem) {
        let imagemOutlet = viagemImages[index]
        imagemOutlet.image = UIImage(named: viagem.asset)
        
        let tituloOutlets = tituloViagemLabels[index]
        tituloOutlets.text = viagem.titulo
        
        let subtituloOutlets = subtituloViagemLabels[index]
        subtituloOutlets.text = viagem.subtitulo
        
        let precoSemDescontoOutlets = precoSemDescontoLabels[index]
        precoSemDescontoOutlets.text = "A partir de R$: \(viagem.precoSemDesconto)"
        
        let precoOutlets = precoLabels[index]
        precoOutlets.text = "R$: \(viagem.preco)"
    }
    
    @objc func didSelectView(_ gesture: UIGestureRecognizer) {
        if let selectedView = gesture.view {
            let viagemSelecionada = viagens?[selectedView.tag]
            delegate?.didSelectView(viagemSelecionada)
        }
    }
}

