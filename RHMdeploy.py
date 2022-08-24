import time
from turtle import delay
from brownie import Emergency,Doctor,Family,accounts
from scripts.medicine import addmeds,heartrate,bloodsugar,saturation
from decouple import config
from numpy import  empty

def addaccount():
 if accounts[0] is empty:
    accounts[0]=accounts.add(config["wallets"]["from_key1"])
    accounts[1]=accounts.add(config["wallets"]["from_key2"])
    accounts[2]=accounts.add(config["wallets"]["from_key3"])
    accounts[3]=accounts.add(config["wallets"]["from_key4"])


lcare=Doctor.deploy("Nity",20,"Male",876523452,accounts[0],{"from": accounts[1]})
accounts[0].transfer(accounts[1],"5 ether")
add=lcare.address
critic=Emergency.deploy(add,{"from":accounts[2]})
member=Family.deploy(add,{"from":accounts[3]})
lcare.loadmedicine(addmeds(),{"from":accounts[1]})
choice=input("Do you want to add more medicine?(yes/no)")
while(choice=="yes"):
    lcare.loadmedicine(addmeds(),{"from":accounts[1]})
    choice=input("Do you want to add more medicine?(yes/no)")
member.medicine({"from": accounts[3]})
index=0
count=0
while(count<60):
    heartr = heartrate()
    bloodsug = bloodsugar()
    satur=saturation()
    tx=lcare.addmedical(heartr,bloodsug,satur,{"from":accounts[0]})
    flag=lcare.actionrequired()
    if flag ==1:
        lcare.loadmedicine(addmeds(),{"from":accounts[1]})
        member.medicine({"from" : accounts[3]})
        time.sleep(300)
        count=count+3
    if flag==2:
        accounts[0].transfer(accounts[2],"3 ether")
        critic.actionrequired(heartr,satur,{"from":accounts[2]})
        member.getalerts(True,{"from":accounts[3]})
        count=60
    else:
        count=count+1
    index=index+1
    time.sleep(43)

print("PatientRecords")
name=lcare.retrievepersonalinfo()
print(name)
option=input("Do you want to print medicine data(Y/N)")
if(option=="Y"):
    length=lcare.gettotalmedicine()
    print(length)  
    while length!=0:  
        med=lcare.getmedicine(length-1)
        print(med)
        length=length-1
option=input("Do you want to print IoT data of the month(Y/N)?")
if(option=="Y"):
    while index>0:    
        value=lcare.retrieve(index-1)
        print(value)
        index=index-1




def main():
    addaccount
