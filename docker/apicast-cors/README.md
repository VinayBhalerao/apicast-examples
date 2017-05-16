```
1. Get the cors.lua from (here)[https://gist.github.com/VinayBhalerao/9964676cbce76f5a433cbfedc7a7a1ea]
2. Start the docker container using below command
```
docker run --name apicast --rm -p 8080:8080 -v /opt/app/apicast_cors.lua:/opt/app-root/src/src/apicast_cors.lua:ro  -e APICAST_MODULE=/opt/app-root/src/src/apicast_cors.lua -e THREESCALE_PORTAL_ENDPOINT=https://<access_token>@portal-admin.3scale.net -e APICAST_LOG_LEVEL=debug registry.access.redhat.com/3scale-amp20/apicast-gateway
```
