from nylas import APIClient
import pandas as pd
import csv 

CLIENT_ID = 'as3q8u0qqcaqukse3y9eklk31'
CLIENT_SECRET = '8v6tzx3g61rcka0on5aoqhuve'
ACCESS_TOKEN = 'qjPstbnDVblJw2FrwmNQ8w4ywBD2O8'
nylas = APIClient(
    CLIENT_ID,
    CLIENT_SECRET,
    ACCESS_TOKEN,
)


message = nylas.messages.first()


print("Subject: {} | Unread: {} | from: {} | ID: {}".format(
    message.subject, message.unread, message.from_, message.id
))

threads = nylas.threads.all(limit=100)
for thread in threads:

    data = {'Subject':thread.subject,'Participants':thread.participants}

    print("Subject: {} | Participants: {}".format(thread.subject, thread.participants))
