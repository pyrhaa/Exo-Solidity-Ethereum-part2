// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Birthday {

	address owner;

	uint256 public birthday;

	event UserStatus(string _msg, address user, uint amount, uint256 time);
	
	function FriendSavings(uint256 _birthday) payable {
		owner = msg.sender;
		birthday = _birthday;
		UserStatus('Friend savings account created', msg.sender, msg.value, block.timestamp);
	}

	modifier onlyOwner() {
		if(owner == msg.sender && block.timestamp > (birthday + 180)) {
			_;
		} else {
			revert();
		}
	}

	function depositFunds() payable {
		UserStatus('User has deposited some money', msg.sender, msg.value, block.timestamp);
	}

	function withdrawFunds(uint amount) onlyOwner {
		if (owner.send(amount)) {
			UserStatus('User has withdrawn some money', msg.sender, amount, block.timestamp);
		} 
	}
 	
	function getAllFunds() onlyOwner {
		UserStatus('User Removed all Funds', msg.sender, this.balance, block.timestamp);
		owner.transfer(this.balance);
	}
	function Kill() onlyOwner {
		UserStatus('Contract Disabled, Transfering Balance to Owner', msg.sender, this.balance, block.timestamp);
	    suicide(owner);
	}
}