pragma solidity ^0.4.25;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol"
import "openzeppelin-solidity/contracts/ownership/Ownable.sol"
import "openzeppelin-solidity/contracts/math/SafeMath.sol"

contract RitualToken is ERC721Full,Ownable{
    
    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    event NewPrayer(uint prayerId, string message, uint32 strength, string schedule, string action, uint parentId);
    event AmplifyPrayer(uint parentId);

    struct Prayer {
      string message;
      uint32 strength;
      string schedule; //cron format
      string action; //placeholder
      uint parentId;
    }

    Prayer[] public prayers;
    mapping (uint => address) public prayerToOwner;
    mapping (message => uint) public prayerToId;
    mapping (address => uint) userPrayerCount;
    mapping (uint => uint) clonePrayerCount;
    mapping (uint => uint) cloneToParent;

    function _createPrayerFromParent(uint _parentId) internal {
        require(_parentId > 0 && prayers[_parentId], "Does Not Have a Parent.");
        Prayer storage prayer =  prayers[_parentId]
        _createPrayer(prayer.message, prayer.strength, prayer.schedule, prayer.action, prayer.parentId);
    }

    function _findPrayer(string _message) internal {
        return prayerToId[_message])
    }

    function _createPrayerFromParent(uint _parentId) internal {
        require(_parentId > 0 && prayers[_parentId], "Does Not Have a Parent.");
        Prayer storage prayer =  prayers[_parentId]
        _createPrayer(prayer.message, prayer.strength, prayer.schedule, prayer.action, prayer.parentId);
    }

    function _createPrayer(string _message, uint32 _strength, string _schedule, string _action,uint32 _parentId) internal {
        uint id = prayers.push(Prayer(_message, _strength, _schedule, _action, _parentId); 
        prayerToOwner[id] = msg.sender;
        userPrayerCount[msg.sender]++;
        if (_parentId > 0){
            clonePrayerCount[_parentId]++;
            cloneToParent[id] = _parentId;
            emit AmplifyPrayer(_parentId);
        }
        emit NewPrayer(_message,_strength,_schedule,_action,_parentId);
    }
    contract AugmentPrayer is PrayerToken{
            
    }
  }

}

