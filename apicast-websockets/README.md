```sh
Place the modified `apicast.conf` in directory

Start docker
docker run --name apicast --rm -p 8080:8080 -v (pwd)/apicast.conf:/opt/app-root/src/conf.d/apicast.conf -e THREESCALE_PORTAL_ENDPOINT=https://<access_token>@portal-admin.3scale.net -e APICAST_LOG_LEVEL=debug registry.access.redhat.com/3scale-amp20/apicast-gateway

Use the html file as client to send ws:// request
```
