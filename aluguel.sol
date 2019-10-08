pragma solidity 0.5.12;

//Um contrato de aluguel

contract Aluguel {
    string public locatario;
    string public locador;
    uint256 private valor;
    uint256 constant numeroMaximoLegalDeAlugueisParaMulta = 3;
    
    constructor(
        string memory nomeLocador,
        string memory nomeLocatario,
        uint256 valorDoAluguel)
    
    public {
        locador = nomeLocador;
        locatario = nomeLocatario;
        valor = valorDoAluguel;
    }

    function valorAtualDoAluguel() public view returns (uint256) {
            return valor;
    }
    
    function simulaMulta(uint256 mesesRestantes, uint256 totalMesesContrato) public view returns (uint256 valorMulta) {
        valorMulta = valor*numeroMaximoLegalDeAlugueisParaMulta;
        valorMulta = valorMulta/totalMesesContrato;
        valorMulta = valorMulta*mesesRestantes;
        
        return valorMulta;
    }
    
    function reajustaAluguel(uint256 percentualReajuste) public {
    uint256 valordoAcrescimo =0;
    valordoAcrescimo = ((valor*percentualReajuste)/100);
    valor = valor + valordoAcrescimo;
    }
}
