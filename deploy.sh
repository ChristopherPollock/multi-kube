docker build -t manicman/multi-client:latest -t manicman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t manicman/multi-server:latest -t manicman/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t manicman/multi-worker:latest -t manicman/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push manicman/multi-client:latest 
docker push manicman/multi-server:latest
docker push manicman/multi-worker:latest 

docker push manicman/multi-client:$SHA
docker push manicman/multi-server:$SHA
docker push manicman/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=manicman/multi-client:$SHA
kubectl set image deployments/server-deployment server=manicman/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=manicman/multi-worker:$SHA