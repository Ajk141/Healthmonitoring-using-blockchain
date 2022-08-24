// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "./Doctor.sol";

contract Emergency{

   Doctor public meddata;
   address payable public _emergency;
   constructor(address _doctor) public{
    _emergency =msg.sender;
    meddata= Doctor(_doctor);
   } 
   event Actionrequired(uint hrate, uint sat);
    
    string[] med;
    string info;
    
    struct faid
    {
        bool oxygen;
        bool ambulance;
        bool CPR;
    }
    faid first_aid= faid(false,false,false);


   
    function actionrequired(uint hrate,uint sat) public Onlyemergency 
    {
            uint l;
            l= meddata.gettotalmedicine();
            for(uint i=med.length;i<l;i++)
            {
                string memory meds=meddata.getmedicine(i);
                med.push(meds);
            }
           meddata.retrievepersonalinfo();
           // emit Alertemergency(Critical);
            first_aid.ambulance=true;
            if(hrate<30)
                first_aid.CPR=true;
            if(sat<60)
                first_aid.oxygen=true;
            emit Actionrequired(hrate, sat);
    }
    modifier Onlyemergency()
    {
        require(msg.sender==_emergency,"Only Emergency department can call this function");
        _;
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
    