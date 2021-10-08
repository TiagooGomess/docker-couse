docker build -t tiagoogomess/multi-client:latest -t tiagoogomess/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tiagoogomess/multi-server:latest -t tiagoogomess/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tiagoogomess/multi-worker:latest -t tiagoogomess/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tiagoogomess/multi-client:latest
docker push tiagoogomess/multi-server:latest
docker push tiagoogomess/multi-worker:latest

docker push tiagoogomess/multi-client:$SHA
docker push tiagoogomess/multi-server:$SHA
docker push tiagoogomess/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tiagoogomess/multi-server:$SHA
kubectl set image deployments/client-deployment client=tiagoogomess/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tiagoogomess/multi-worker:$SHA
