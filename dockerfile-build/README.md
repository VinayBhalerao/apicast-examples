```sh
oc new-project apicast-gateway

oc new-build https://github.com/VinayBhalerao/custom-gateway.git --strategy=docker

oc secret new-basicauth apicast-configuration-url-secret --password=https://<access_token>@3scaleportal-admin.3scale.net

oc get is/custom-gateway #Get image name

oc new-app -f https://raw.githubusercontent.com/3scale/apicast/v3.0.0/openshift/apicast-template.yml -p IMAGE_NAME=172.30.26.75:5000/apicast-gateway/custom-gateway

oc get pods

oc rsh apicast-<name>
	- You should see the file verbose.lua in directory `/opt/app-root/src/src`

oc env dc/apicast APICAST_MODULE=/opt/app-root/src/src/verbose.lua #set env variable

Send request
curl "http://localhost:80/endpoint?user_key=4e8237d98cdd7072e4fb5f771db35d01"

In Pods logs below response is logged fromi `verbose.lua` 

`2017/05/16 21:43:45 [warn] 28#28: *4 [lua] verbose.lua:11: log(): upstream response time: 0.031 upstream connect time: 0.009 while logging request`
```

