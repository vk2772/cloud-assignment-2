# Cloud Computing Assignment 2 — Kubernetes Deployment

**Course:** Cloud Computing and Big Data Systems — Spring 2026  
**Student:** Varsha Kumbenahally Roopeshkumar

## Overview
Deployment of a Flask + MongoDB To-Do web application on Kubernetes using Docker containers, Minikube, ReplicaSets, rolling updates, health monitoring, and Prometheus alerting.

## Files
| File | Description |
|------|-------------|
| `Dockerfile` | Builds the Flask app Docker image |
| `docker-compose.yml` | Runs Flask + MongoDB locally for testing |
| `requirements.txt` | Python dependencies |
| `app.py` | Main Flask application |
| `mongo-deployment.yaml` | MongoDB Kubernetes Deployment + Service |
| `flask-deployment.yaml` | Flask app Deployment + NodePort Service |
| `alertmanager-config.yaml` | Prometheus Alertmanager Slack config |
| `alert-rules.yaml` | PrometheusRule for pod-down alerts |

## Steps Completed

### Part 2 — Docker
- Built Flask Docker image using Dockerfile
- Tested locally with docker-compose (Flask + MongoDB)
- Pushed image to Docker Hub: `varsharoopesh/todo-app`

### Part 3 — Minikube
- Started Minikube with Docker driver
- Deployed Flask app (2 replicas) and MongoDB on Kubernetes
- Accessed app via NodePort service

### Part 5 — ReplicaSets
- Verified ReplicaSet maintaining 2 replicas
- Tested self-healing by deleting a pod (auto-replaced)
- Scaled up to 3 replicas, then back to 2

### Part 6 — Rolling Updates
- Configured RollingUpdate strategy (maxUnavailable: 1, maxSurge: 1)
- Built and pushed v2 image with app title change
- Zero-downtime rolling update completed successfully

### Part 7 — Health Monitoring
- Added liveness probe: HTTP GET / every 10s (restarts pod after 3 failures)
- Added readiness probe: HTTP GET / every 5s (stops traffic if unhealthy)
- Verified with kubectl describe pod

### Part 8 — Alerting (Extra Credit)
- Installed Prometheus + Alertmanager + Grafana via Helm
- Configured Slack incoming webhook for #general channel
- Created PrometheusRule for PodDown alerts
- Tested: deleting a pod triggered Slack alert within 30 seconds

## How to Run

### Local (Docker)
```bash
docker-compose up --build
# Open http://localhost:5001
```

### Kubernetes (Minikube)
```bash
minikube start --driver=docker
kubectl apply -f mongo-deployment.yaml
kubectl apply -f flask-deployment.yaml
minikube service flask-service
```

### Alerting Setup
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace
# Add your Slack webhook URL to alertmanager-config.yaml
kubectl apply -f alertmanager-config.yaml
kubectl apply -f alert-rules.yaml
```
