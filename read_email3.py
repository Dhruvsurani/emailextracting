from nylas import APIClient
CLIENT_ID = 'as3q8u0qqcaqukse3y9eklk31'
CLIENT_SECRET = '8v6tzx3g61rcka0on5aoqhuve'
# ACCESS_TOKEN = 'oCr6vR2m42tFYVZeUd0l1iDMhLNuOX'
nylas = APIClient(
    CLIENT_ID,
    CLIENT_SECRET,
)




accounts = nylas.accounts.all()
for account in accounts:
    print("Email: {} | Billing State: {} | Sync State: {} | Account ID: {}".format(
        account.get('email'), account.get('billing_state'),
        account.get('sync_state'), account.get('account_id')
    ))  
 