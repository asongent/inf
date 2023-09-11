# Test deployment and scaleability of simple nginx app

## 

## 1. Apply deployment file
```
kubectl apply -f nginx.yaml
```

## 2. Testing cluster scaling
Edit the deployment in the cluster to replica size **16**
```
kubectl scale deployment/web-stateless --replicas=16
```
Verify that the cluster nodes scale up with increased replicase.

## 3. Clean-up
Clean-up test pods and deployment.
```
kubectl delete -f nginx.yaml
```