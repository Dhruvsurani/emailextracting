from nylas import APIClient
import pandas as pd
import csv 

CLIENT_ID = 'as3q8u0qqcaqukse3y9eklk31'
CLIENT_SECRET = '8v6tzx3g61rcka0on5aoqhuve'
ACCESS_TOKEN = 'oCr6vR2m42tFYVZeUd0l1iDMhLNuOX'
nylas = APIClient(
    CLIENT_ID,
    CLIENT_SECRET,
    ACCESS_TOKEN,
)


message = nylas.messages.all()
for msg in message:
    Subject = msg.subject
    Unread = msg.unread
    From = msg.from_
    ID = msg.id
    data = [Subject,Unread,From,ID]
    df = pd.DataFrame(data)
  
    filename = 'email_detail.csv'
    with open(filename, 'w') as csvfile: 
    # creating a csv writer object 
        csvwriter = csv.writer(csvfile) 
 
        
    # writing the data rows 
        csvwriter.writerows(data)
# print("Subject: {} | Unread: {} | from: {} | ID: {}".format(
#     message.subject, message.unread, message.from_, message.id
# ))

threads = nylas.threads.all(limit=10) 
for thread in threads:
    Subject=thread.subject
    Participants=thread.participants
    # data = {'Subject':thread.subject,'Participants':thread.participants}
    data = [Subject,Participants]
    df = pd.DataFrame(data)
    
    df.to_csv('file1.csv')
    # print("Subject: {} | Participants: {}".format(thread.subject, thread.participants))
