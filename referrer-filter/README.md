##### Make sure you have enabled `Referrer filters` in 3scale admin portal and added the IP/hostname to the applications

```sh
Place the apicast.conf in directory

docker run --name apicast --rm -p 8080:8080 \
-v $(pwd)/apicast.conf:/opt/app-root/src/conf.d/apicast.conf \
-e THREESCALE_PORTAL_ENDPOINT=https://<access_token>@portal-admin.3scale.net \
-e APICAST_LOG_LEVEL=debug \
registry.access.redhat.com/3scale-amp20/apicast-gateway

Send request
curl -v "http://localhost:8080/endpoint_name?user_key=123456" -H "Referrer: 10.2.2.2"
```


