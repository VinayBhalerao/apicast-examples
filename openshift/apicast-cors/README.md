```
1. Get the cors.lua from (here) [https://gist.github.com/VinayBhalerao/9964676cbce76f5a433cbfedc7a7a1ea]
```

Use `configMaps` to mount the file

```
1. oc create configmap cors --from-file=./cors.lua
2. oc volume dc/apicast --add --name=apicast -m /opt/app-root/src/src -t configmap --configmap-name=cors

#2 results in error in deployment. Proceed to step 3

3. oc edit dc apicast
4. Add a subPath to the `volumeMounts`. This should look like below

volumeMounts:
        - mountPath: /opt/app-root/src/src/cors.lua
          name: apicast
          subPath: cors.lua

5. Save and exit
6. oc get pods
7. oc rsh <apicast-podname>
8. ls /opt/app-root/src/src/ #inside the pod. Verify if cors.lua is present

After pods are deployed successfully, intitalise the `APICAST_MODULE=/opt/app-root/src/src/cors.lua` in deployment environment. Save and it automatically redeploys with new containers.


