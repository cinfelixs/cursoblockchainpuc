pragma solidity 0.5.12;

// Um modelo de termo de audiência de conciliação COM acordo entre as partes

contract Acordoconciliacao {
    
    //Descrever as variáveis utilizadas em todas as funções
    
    string public requerente;
    string public advRequerente;
    string public requerido;
    string public advRequerido;
    uint256 private valor;
    uint256 private numeroMaximoDeParcelasAcordo = 6;
    
    constructor(
        string memory parteRequerente,
        string memory parteRequerida,
        uint256 valorInicial)
    
    public 
    {
        requerente = parteRequerente;
        requerido = parteRequerida;
        valor = valorInicial;
    }

    function valorInicial() public view returns (uint256) 
    {
            return valor;
    }
    
    function simulaAcordo(uint256 valorParcelasAcordo, uint256 percentualDesconto) public view returns (uint256 valorDoAcordo) {
        percentualDesconto = 10;
        valorParcelasAcordo = ((valor*percentualDesconto)/100)/numeroMaximoDeParcelasAcordo;
        valorDoAcordo = percentualDesconto*valorParcelasAcordo;
        return valorDoAcordo;
    }
    
    function descontoMaior(uint256 percentualDescontoMaior) public {
        if (numeroMaximoDeParcelasAcordo < 3) {
            percentualDescontoMaior = 20;
        }
        
    //TERMINAR A PARTIR DESSE PONTO. O RESTO ESTÁ OK!!!!
    
        uint256 valordoAcrescimo = 0;
        valordoAcrescimo = ((valor*percentualDescontoMaior)/100);
        valor = valor + valordoAcrescimo;
    }
    
    function aditamentoValorAluguel(uint256 valorCerto) public {
        valor = valorCerto;
    }
    
    function aplicaMulta(uint256 mesesRestantes, uint256 percentual) public {
        
        require(mesesRestantes<30, "Período de contrato inválido");
        for (uint i=1; i<mesesRestantes; i++) {
            valor = valor+((valor*percentual)/100);
            }
    }
}
