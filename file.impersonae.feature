---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: insecure-app
  namespace: insecure-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: insecure-app
  template:
    metadata:
      labels:
        app: insecure-app
    spec:
      containers:
      - image: confusedcrib/insecure-app:latest
        name: insecure-app
        env:
        - name: AWS_ACCESS_KEY_ID
          value: ****SDD8
        - name: AWS_SECRET_ACCESS_KEY
          value: wJalrXUtnFEMI/K7MDENG/bPxRfiCYeh2g7ykyu8
        securityContext:
          privileged: true
        volumeMounts:                   
        - name: docker-socket
          mountPath: /var/run/docker.sock
      volumes:                         
      - name: docker-socket
        hostPath:
          path: /var/run/docker.sock
      serviceAccountName: insecure-app-sa
---
kind: Service
apiVersion: v1
metadata:
  name: insecure-app
  namespace: insecure-app
spec:
  type: NodePort
  selector:
    app: insecure-app
  ports:
  - name: http
    port: 8080
    targetPort: 8080
  - name: ssh
    port: 22
    targetPort: 22
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: insecure-app-role
rules:
- apiGroups: [""]
  resources: ["pods", "serviceaccounts", "serviceaccounts/token"]
  verbs: ["*"]
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: insecure-app-role-binding
subjects:
- kind: ServiceAccount
  name: insecure-app-sa
  namespace: insecure-app
  apiGroup: ""
roleRef:
  kind: ClusterRole
  name: insecure-app-role
  apiGroup: ""
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: insecure-app-sa
  namespace: insecure-app
