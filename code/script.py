import pyttsx3
import os
import speech_recognition as sr




name= input("Enter your name: ")


pyttsx3.speak("hello {} how can I help you".format(name))


r=sr.Recognizer()




while True:
    print("What would you like to do:" , end='')
    with sr.Microphone() as source:
    	print('Start saying....')
    	audio = r.listen(source) 
    	print('Done....')

    data=r.recognize_google(audio)
    choice=data
    print(choice)

    if ("run" in choice or "open" in choice) and ("Chrome" in choice):
         os.system("chrome")
    elif ("run" in choice or "open" in choice) and ("Notepad" in choice or "text editor" in choice):
         os.system("notepad")
    elif ("show" in choice or "tell" in choice) and ("date" in choice):
         os.system("date")
    elif ("exit" in choice) or ("terminate" in choice) or ("go back" in choice):
         print('exiting')
         break
    else:
        print("doesn't support")



print("Thank youu", end='...')
print('have a nice day!!')



