## Usecase

Your client app sends Basic Authorization header `Authorization: Basic 123456` request to gateway. The APIcast needs to validate the auth header and if true, then provide access to resource.

## Worflow
```sh
1. Request `curl "http://localhost:8080/pricing?user_key=4e8237d98cdd7072e4fb5f771db35d01" -H "Authorization: Basic dmluYXk6dmluYXkxMjM=` is send to APIcast 

2. APIcast extracts the `Authorization` header and verify with Identity's provider authorization endpoint

3. If 200OK, then the `user_key` validation happens with 3scale SAAS backend

4. If 200OK, then the request is proxied to API backend
```

## Steps
```sh

git clone git@github.com:3scale/apicast.git

Goto directory `apicast/conf.d` and override `apicast.conf` with the one from repo

Copy `validate_auth_header.lua` in directory `apicast/src` #It has the logic to verify auth header with IDP

Start the gateway using openresty

THREESCALE_PORTAL_ENDPOINT=https://<access_token>@portal-admin.3scale.net \
APICAST_MODULE=(pwd)/apicast/src/validate_auth_header.lua \
APICAST_LOG_LEVEL=debug \
bin/apicast -v -v
```
