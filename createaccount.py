from nylas import APIClient
CLIENT_ID = 'as3q8u0qqcaqukse3y9eklk31'
CLIENT_SECRET = '8v6tzx3g61rcka0on5aoqhuve'
ACCESS_TOKEN = 'oCr6vR2m42tFYVZeUd0l1iDMhLNuOX'
nylas = APIClient(
    CLIENT_ID,
    CLIENT_SECRET,
    ACCESS_TOKEN
)

account = nylas.account
print('Email: {} | Provider: {} | Organization: {}'.format(
    account.email_address, account.provider, account.organization_unit
))  
 