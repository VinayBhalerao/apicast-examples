```sh
1. Get the cors.lua from directory
```

Use `configMaps` to mount the file

```
oc create configmap cors --from-file=./cors.lua

oc volume dc/apicast --add --name=apicast -m /opt/app-root/src/src -t configmap --configmap-name=cors

### results in error in deployment due to bug in Kubernetes. Proceed to next step

oc edit dc apicast

Add a subPath to the `volumeMounts`. This should look like below

volumeMounts:
        - mountPath: /opt/app-root/src/src/cors.lua
          name: apicast
          subPath: cors.lua

Save and exit

oc get pods

oc rsh <apicast-podname>
ls /opt/app-root/src/src/ #inside the pod.Verify if cors.lua is present

oc env dc/apicast APICAST_MODULE=/opt/app-root/src/src/verbose.lua #set env variable
```
