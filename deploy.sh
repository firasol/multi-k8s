docker build -t fabughazaleh/multi-client:latest -t fabughazaleh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fabughazaleh/multi-server:latest -t fabughazaleh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fabughazaleh/multi-worker:latest -t fabughazaleh/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push fabughazaleh/multi-client:latest
docker push fabughazaleh/multi-server:latest
docker push fabughazaleh/multi-worker:latest
docker push fabughazaleh/multi-client:$SHA
docker push fabughazaleh/multi-server:$SHA
docker push fabughazaleh/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=fabughazaleh/multi-server:$SHA
kubectl set image deployments/client-deployment client=fabughazaleh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fabughazaleh/multi-worker:$SHA