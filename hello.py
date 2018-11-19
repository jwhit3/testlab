min_name_length = 5
fname = input("Enter in your name") 

if len(fname) < min_name_length:
    print ("Your name is too short, Needs to be greater then %s") % min_name_length
    
else:
    print ("Yay your name meets min legth")

# Example of List
words = []
words.append("one")
words.append("two")
print(words)