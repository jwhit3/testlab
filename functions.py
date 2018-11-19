

def getName():
    print("Enter in your name") 
    name = input() 
    return name

def nameVerify(name):
    min_name_length = 5
    if len(name) < min_name_length:
        print ("Your name is too short, Needs to be greater then 5")
        #getName()
        return False
    else:
         print ("Yay your name meets min length")
         return True


def Main(): 
    print("Started") 
# calling the getInteger function and  
# storing its returned value in the output variable 
    for step in range(5):
        name = getName()
        if nameVerify(name):
            break
        else:
            ##print("You have used %s in 5 chances") % step
            print("You have used " +str(step)+ " in 5 chances" ) 
        
  
# now we are required to tell Python  
# for 'Main' function existence 
if __name__=="__main__": 
    Main() 