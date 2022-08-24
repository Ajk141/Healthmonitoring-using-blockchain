# Healthmonitoring-using-blockchain
A decentralized health monitoring framework using blockchain
This project helps in demostrating the implementation of a decentralized remote health monitoring system in a local blockchain network using Ganache (Fake Ethereum).

# WorkingScenario
Doctor records patient details like name,age,sex,phone no.(Location purposes), then 5 ganache ether is been transferred from patient's account to doctor's account ( Monthly membership basis).
Based on patients current state, doctor prescribes some medications or medicines which will be recorded in the blockchain and shared with family member as well.
The IoT data is being recorded in the blockchain every 12 hours for one month ideally monitored and analyzed based on set of parameters.
If the patient is **critical** based on the IoT data analyzed, patient needs to attend emergency department as the ambulance will be provided with basic first aid support given depending on the parameters. The patient details like personal details and the medications prescribed are shared with emergency departement. A fixed amount of 3 ether is transferred from patient account to emergency account. Then the IoT data wont be recorded in the blockchain for the rest of the month as the patient is admitted in the hospital. An alert will be send to both doctor as well as family member.
If the IoT parameters are found **high** after analyzing the input, the doctor will prescribe some medicines for the patient. Then the IoT data wont be recorded and monitored for the next 3 days.

#  Project Overview 

The local blockchain network consists of 4 nodes(Patient,Doctor,Emergency Department and Family Member). Each nodes have been assigned a specific account address which they used to communicate in the blockchain. 
Accounts associated with each node is as shown below:- (Accounts[0]=Patient,Accounts[1]=Doctor,Accounts[2]=Emergency,Accounts[3]=Family Member).
There are 3 contracts coded in solidity(**Doctor.sol**,**Emergency.sol**&**Family.sol**) and 2 python scripts(**medicine.py**&**RHMdeploy.py**). The contract name dictates the communication between patient and respective node in the blockchain.
**medicine.py** has 4 functions:- 1 for inputing medicines needed and other 3 functions is been used as inputs for IoT data(For the time being entered manually due to time constraints). **RHMdeploy.py** is used to deploy the smart contracts and for fund transfer between patient and doctor as well as patient and emergency.

# Major functions in each contract

## Doctor.sol

1. loadmedicine() - For prescribing medicines and recording them in blockchain.
2. addmedical()- For recording IoT data in the blockchain.
3. givealerts()- Analyzing the recorded IoT data and declaring the state of the patient based on recorded parameters.
4. actionrequired()- Dictates the type of intervention needed for current state of patient.
5. retrievepersonalinfo()- Retrieveing personal details about patient.
6. retrieve()- Retrieve the IoT data recorded in the whole month.
7. getmedicine()- To get the medicines prescribed.

## Emergency.sol

1. actionrequired() - Dictates the action taken by the emergency department when the state of the patient is Critical.


## Family.sol
1. medicine() - To record the medicines prescribed by the doctor.
2. getalerts() - To get alert when the state of patient is critical
