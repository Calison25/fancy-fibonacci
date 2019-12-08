docker build -t calison/fibonacci-client:latest -t calison/fibonacci-client:$SHA -f ./client/Dockerfile ./client
docker build -t calison/fibonacci-server:latest -t calison/fibonacci-server:$SHA -f ./server/Dockerfile ./server
docker build -t calison/fibonacci-worker:latest -t calison/fibonacci-worker:$SHA -f ./worker/Dockerfile ./worker

docker push calison/fibonacci-client:latest
docker push calison/fibonacci-server:latest
docker push calison/fibonacci-worker:latest

docker push calison/fibonacci-client:$SHA
docker push calison/fibonacci-server:$SHA
docker push calison/fibonacci-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=calison/fibonacci-server:$SHA
kubectl set image deployments/client-deployment client=calison/fibonacci-client:$SHA
kubectl set image deployments/worker-deployment worker=calison/fibonacci-worker:$SHA