pragma solidity 0.5.12;

// Este SC simula um acordo de conciliação de processo de execução de título judicial

contract AcordoConciliacao {
    
    address payable public autor;
    address payable public advogadoAutor;
    address public juizConciliador;
    uint public valorAcordo;
    uint public dataVencimentoParcela;
    uint public percentualPgtoAVista;
    uint public percentualAdvogadoAutor;
    uint public valorDevidoAutor;
    bool public pago;
    bool public retirado;
    
    event pagamentoRealizado (uint valor);
    
    modifier autorizadosRecebimento () {
        require (msg.sender == autor || msg.sender == advogadoAutor, "Operaçao exclusiva do advogado da parte autora");
        _;    
    }
    
    modifier homologacaoJuiz () {
        require (msg.sender == juizConciliador, "Homologação do Juiz Presidente do Gabinete de Conciliação");
        _;
    }
    
    constructor(
        address payable _autor,
        address _juizConciliador,
        uint _valorDoAcordo,
        uint _dataVencimentoParcela,
        uint _percentualAdvogadoAutor
    ) public {
        autor = _autor;
        advogadoAutor = msg.sender;
        juizConciliador = _juizConciliador;
        valorAcordo = _valorDoAcordo;
        dataVencimentoParcela = now+_dataVencimentoParcela;
        percentualAdvogadoAutor = _percentualAdvogadoAutor;
        percentualPgtoAVista = 10;
    }
    
    function saldoAcordo() public view returns (uint) {
        return address(this).balance;
    }
    
    function simulacaoDesconto (uint256 valorAcordo, uint256 percentualDescontoAVista) public view returns (uint valorSimuladoDesconto) {
        valorSimuladoDesconto = (valorAcordo - ((valorAcordo*10)/100),
        return valorSimuladoDesconto;
    }
    
    function pagamentoParcelado () public payable homologacaoJuiz {
        require (now <= dataVencimentoParcela, "Aguardando pagamento da parcela");
        require (msg.value == valorAcordo, "Valor diverso do indicado no acordo");
        pago = true;
        emit pagamentoRealizado(msg.value);
    }
    
     function distribuicaoDeValores() public autorizadosRecebimento {
        require(pago, "Pagamento não realizado");
        require(retirado == false, "Distribuição já realizada.");
        
        valorDevidoAutor = (percentualAdvogadoAutor - address(this).balance);
        
        autor.transfer(valorDevidoAutor);
        advogadoAutor.transfer(address(this).balance);
        retirado = true;
    }
}
