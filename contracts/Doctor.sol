// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

contract Doctor{
    string name;
    uint age;
    uint number;
    string sex;
    address payable public doctor;
    address  public patient;
    event medicineadded(string med);
    enum state{Normal,High,Critical}
    event declarestate(state st);
    state State;
    string[] meds;
    bool medicines = false;
    struct  med_data
    {
        uint heartrate;
        uint bloodsugar;
        uint saturation; 
    }
    constructor (string memory _name,uint _age,string memory _sex,uint _no,address adr) public 
    {
       name=_name;
       age=_age;
       sex=_sex;
       number=_no;
      doctor=msg.sender;
      patient=adr;
    }
    med_data[] public meddata;
    function addmedical(uint _hrate,uint _bsugar,uint _sat) public
    {
        require(msg.sender==patient,"Only Patient's IoT data can be entered");
        meddata.push(med_data(_hrate,_bsugar,_sat));
        givealerts(_hrate,_bsugar,_sat);
    }
   modifier Onlydoctor()
   {
    require(msg.sender==doctor,"Only Doctor can call this function");
    _;
   }
    function loadmedicine(string memory med)public Onlydoctor{
        
        meds.push(med);
        emit medicineadded(med);
    }
   function gettotalmedicine() public view returns(uint)
    {
        return meds.length;
    }
    function getmedicine(uint index) public view returns(string memory)
    {   
        return meds[index];
    }
    
    function retrievepersonalinfo() public view returns(string memory,uint,uint,string memory)
    {
        return(name,age,number,sex);
    }

   function retrieve(uint index) public view Onlydoctor returns(uint,uint,uint)
   {
    return(meddata[index].heartrate,meddata[index].bloodsugar,meddata[index].saturation);
   }

   function givealerts(uint _hrate,uint _bsugar, uint sat) public
    {
        
        if(_hrate>60 && _hrate<100)
        {    if(_bsugar>72 && _bsugar<99)
                if(sat>95)
                    State= state.Normal;
                    medicines=false;
        }
        else if(_hrate>140 || _bsugar>300 || _bsugar<54 || _hrate<30 || sat<60)
        {   
            State= state.Critical;
        }
        else
        {
            State= state.High; 
            medicines=true;
        emit declarestate(State);    
        }
               
    }
    function actionrequired() public view returns(uint)
    {
        uint flag;
        if(State==state.Normal)
        {
            flag=0;
        }
        else if(State==state.High)
        {
            flag=1;
        }
        else
        {
            flag=2;
        }
        return flag;
    }
}