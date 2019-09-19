docker build -t blazestudios23/multi-client:latest -t blazestudios23/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t blazestudios23/multi-server:latest -t blazestudios23/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t blazestudios23/multi-worker:latest -t blazestudios23/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push blazestudios23/multi-client:latest
docker push blazestudios23/multi-server:latest
docker push blazestudios23/multi-worker:latest

docker push blazestudios23/multi-client:$SHA
docker push blazestudios23/multi-server:$SHA
docker push blazestudios23/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=blazestudios23/multi-server:$SHA
kubectl set image deployments/client-deployment client=blazestudios23/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=blazestudios23/multi-worker:$SHA
