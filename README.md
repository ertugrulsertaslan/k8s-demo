# Kubernetes Demo 🐳☸⚓

This guide will walk you through the steps to run a Node.js application in a Kubernetes environment using Minikube.

## Prerequisites 📋

- **Minikube** (Local Kubernetes development environment) 🖥️
- **Kubectl** (Kubernetes command-line tool) ☸
- **Docker** (For building container images) 🐳
- **Node.js** (For the application) 🟩

---

## Installation 💻

#### [Minikube Installation](tutorials/InstallMinikube.md) 📥
#### [Docker Installation](tutorials/InstallDocker.md) 📥
#### [Node Installation](tutorials/InstallNode.md) 📥

## 1.Creating Docker Image and Uploading to Docker Hub 🌐


### 1.1 Docker Login 🔑

To push images to Docker Hub, you first need to log in to Docker Hub. Use the following command to log in:

```bash
docker login
```
When you run this command, you will be prompted to enter your username and password. If you don't have a Docker Hub account, you can create a new one [here](https://hub.docker.com).🌐

### 1.2 Creating the Docker Image 🐳
Now we will use the following command to create the Docker image:

```bash
docker build -t <dockerhub-username>/nodejs-k8s-demo:latest .
In this command,  <dockerhub-username> with your own Docker Hub username.
```
### 1.3 Docker Hub A Push ⬆️

To upload the Docker image to Docker Hub, use this command:

```bash
docker push <dockerhub-username>/nodejs-k8s-demo:latest
```
## 2. Kubernetes Deployment and Service Configuration 🛠️

We will create the necessary Deployment and Service YAML files to deploy your application to Kubernetes.

### 2.1 Deployment YAML File 📄

Create a file named `deployment.yaml` and add the following content:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodejs-deployment
spec:
  replicas: 2 # create 2 replica
  selector:
    matchLabels:
      app: nodejs
  template:
    metadata:
      labels:
        app: nodejs
    spec:
      containers:
        - name: nodejs
          image: <dockerhub-username>/nodejs-k8s-demo:latest # Your Docker Hub image
          ports:
            - containerPort: 8080
```

### 2.2 Service YAML File ⚙️
Create a file named `service.yaml` and add the following content:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nodejs-service
spec:
  selector:
    app: nodejs # This specifies which pods the service will route traffic to
  ports:
    - protocol: TCP
      port: 80 # The external port exposed to the outside
      targetPort: 8080 # The application port inside the pod
  type: NodePort # We are using NodePort for Minikube
```

## 3. Deploying the Application to Kubernetes 🚀

Follow the steps below to deploy your application to the Kubernetes environment:

### 3.1 Apply Deployment and Service 🖧

Run the following commands to apply the Deployment and Service in your Kubernetes environment:

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```
### 3.2 Check Pods and Service Status 🔍

To check the status of your Kubernetes pods, run the following command:

```bash
kubectl get pods
```
To check your service, run this command:
```bash
kubectl get services
```
If you're using Minikube, you can get the service URL by running the following command:
```bash
minikube service nodejs-service --url
```

