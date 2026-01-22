

## Install Knative

```bash
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.16.0/serving-crds.yaml
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.16.0/serving-core.yaml

kubectl apply -f https://github.com/knative/net-kourier/releases/download/knative-v1.16.0/kourier.yaml

kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"ingress-class":"kourier.ingress.networking.knative.dev"}}'

kubectl --namespace kourier-system get service kourier
# 10.99.7.207

kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.16.0/serving-default-domain.yaml

kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.16.0/serving-hpa.yaml

wget https://github.com/knative/client/releases/download/knative-v1.16.0/kn-linux-arm64
mv kn-linux-arm64 kn
chmod +x kn
sudo mv kn /usr/local/bin
kn version

wget https://github.com/knative-extensions/kn-plugin-quickstart/releases/download/knative-v1.16.0/kn-quickstart-linux-arm64
mv kn-quickstart-linux-arm64 kn-quickstart
chmod +x kn-quickstart
sudo mv kn-quickstart /usr/local/bin
```

## Deploy an application

```bash
kn service create hello \
--image ghcr.io/knative/helloworld-go:latest \
--port 8080 \
--env TARGET=World
```

http://hello.default.svc.0.0.0.0.sslip.io
http://hello.default.svc.cluster.local
