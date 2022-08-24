// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "./Doctor.sol";

contract Family
{
    
    Doctor public meddata;

    constructor(address _doctor) public
    {
        meddata=Doctor(_doctor);
    }
    string[] med;
    bool attention;

    function medicine() public
    {
        uint l = meddata.gettotalmedicine();
        for(uint i=med.length;i<l;i++)
        {
            string memory meds = meddata.getmedicine(i);
            med.push(meds);
        }
    } 
    function getalerts(bool flag) public
    {
        require(flag!=false,"Urgent care Required");
        attention=false;
    }
    function gettotalmedicine() public view returns(uint)
    {
        return med.length;
    }
    function getmedicine(uint index) public view returns(string memory)
    {   
        return med[index];
    }
}