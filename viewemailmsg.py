import os
from pathlib import Path

from nylas import APIClient
import pandas as pd
import csv 
import pathlib

# CLIENT_ID = 'as3q8u0qqcaqukse3y9eklk31'
# CLIENT_SECRET = '8v6tzx3g61rcka0on5aoqhuve'
# ACCESS_TOKEN = 'isMm80S234tMwBCgzUde69sQ302kvt'

CLIENT_ID = '7g5iy280uugmjm20ribmzazsi'
CLIENT_SECRET = '7po3zsxop1atyk5sa70xjz1j6'
ACCESS_TOKEN = 'ssgfkM4zSDQCMojO3QPKwLX5csSvwX'
nylas = APIClient(
    CLIENT_ID,
    CLIENT_SECRET,
    ACCESS_TOKEN,
)


message = nylas.messages.all()

for msg in message:
    data = {'subject:': msg.subject,1:msg.from_,'to:':msg.to,'account_id':msg.account_id ,'snippet':msg.snippet,'files:':msg.files}
    print(data)
    if data['files:'] is None:
        pass
    else:
        dict = []
        for i in msg.from_:
            dict = i['email']
            print(dict)


        path_dir = 'attachment_dir/'
        path = os.path.join(path_dir,dict)
        checkpath = (path)
            # Check whether the specified path exists or not
        isExist = os.path.exists(checkpath)
        if not isExist:
                # Create a new directory because it does not exist
            os.mkdir(path)

        filename = dict
        fullpath = os.path.join(path,filename)
        content = msg.snippet
        isExist = os.path.exists(fullpath)
        if not isExist:
            with open(fullpath, "w+") as f:
                f.write(content)
        else:
            with open(fullpath, "a+") as f:
                f.write('\n')
                f.write(content)

            attc_id = []
            attc_name = []
            for i in msg.files:
                attc_id = i['id']
                attc_name = i['filename']
                ns = nylas.files.get(attc_id)
                fl_code = ns.download()

                fullpath = os.path.join(path, str(attc_name))
                isExist = os.path.exists(fullpath)
                if not isExist:
                    with open(fullpath, "wb") as f:
                        f.write(fl_code)




# ns = nylas.files.get("91ocd28j4967012t8zs5p3xf3")
# ns.download()
# fl_code = ns.download()
# with open("cursed-child-US.jpg", "wb") as f:
#     f.write(fl_code)