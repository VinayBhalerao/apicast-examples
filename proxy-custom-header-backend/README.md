## Usecase

```sh
Your backend expects a header `X-Request-ID` from gateway with every API request invoking the backend service. The header can have information eg: `timestamp + remote_address + request_length` and as provider, you would like to monitor this for internal purpose. Additional variables can be found from nginx [docs](http://nginx.org/en/docs/http/ngx_http_core_module.html#variables)

Below are the steps to follow to override existing `apicast.conf` with this additional feature. Line 64 of `apicast.conf` is the additional line.
```

## Worflow

```sh
1. Request `curl "http://localhost:8080/pricing?user_key=4e8237d98cdd7072e4fb5f771db35d01"` is sent to APIcast 
2. Apicast internally adds `X-Request-Id` while proxy_pass to API backend
3. Your API backend receives header in following format `X-Request-Id: 20746-1495732170.598-127.0.0.1-127`
```
## Steps

```sh
Get the `apicast.conf` from the directory.

oc create configmap apicast-custom --from-file=./apicast.conf

oc volume dc/apicast --add --name=apicast -m /opt/app-root/src/conf.d -t configmap --configmap-name=apicast-custom

### results in error in deployment due to bug in Kubernetes. Proceed to next step###

oc edit dc apicast

Add a subPath to the `volumeMounts`. This should look like below

volumeMounts:
        - mountPath: /opt/app-root/src/conf.d/apicast.conf
          name: apicast-custom
          subPath: apicast.conf

Save and exit

oc get pods

oc rsh <apicast-podname>

vi /opt/app-root/src/conf.d/apicast.conf ##verify if `X-Request-Id` change is present in apicast.conf.

```

## Approach 2

```sh
If you are familiar with `Dockerfile` it will be very easy to create a dockerfile and copy the customized `apicast.conf` inside a container. Sample example [here](https://github.com/VinayBhalerao/apicast-examples/tree/master/dockerfile-build) 
```
