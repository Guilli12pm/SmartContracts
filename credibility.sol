
pragma solidity ^0.5.7;

import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Credibilite {
  
   using SafeMath for uint256;
  
   mapping (address => uint256) public cred;
   bytes32[] private devoirs;
   
   function produireHash(string memory url) public pure returns (bytes32){
       return bytes32(keccak256(bytes(url)));
   }
   
   function transfer(address destinataire, uint256 valeur) public{
       require(cred[msg.sender] >= valeur);
       cred[destinataire] = SafeMath.add(valeur,cred[destinataire]);
       cred[msg.sender] -= SafeMath.add(cred[msg.sender],valeur);
   }
   
   function remettre(bytes32 dev) public view returns (uint256){
       for (uint i = 1; i < devoirs.length; i++){
           if (devoirs[i-1] == dev){
                return i;
           }
       }
       return 0;
   }
   
    function remettre_point (bytes32 dev) public{
        devoirs.push(dev);
        uint256 pos = remettre(dev);
        if (pos == 1){
            cred[msg.sender] = SafeMath.add(cred[msg.sender],30);
        }
        else if (pos == 2){
            cred[msg.sender] = SafeMath.add(cred[msg.sender],20);
        }
        else if (pos == 3){
            cred[msg.sender] = SafeMath.add(cred[msg.sender],10);
        }
        else {
            cred[msg.sender] = 0;
        }
    }

}
