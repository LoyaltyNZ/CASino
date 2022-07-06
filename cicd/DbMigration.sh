#!/bin/bash
set -ex

APPNAME=$1
TAG=$2
ENVIRONMENT=$3
COMMAND=$4

# Create Job manifest file for db migration
cat <<EOF > db-migration.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: $APPNAME-db-migration
  namespace: $ENVIRONMENT
spec:
  backoffLimit: 1
  template:
    metadata:
      name: $APPNAME-db-migration
    spec:
      restartPolicy: Never
      containers:
      - name: db-migration
        image: docker.loyaltydevops.co.nz/$APPNAME:$TAG
        imagePullPolicy: Always
        command: ["/bin/sh"]
        args: ["-c", "${COMMAND}"]
        envFrom:
        - configMapRef:
            name: $APPNAME-configuration
        - secretRef:
            name: $APPNAME-secrets
EOF
cat db-migration.yaml

# Switch Kubernetes context
kubectl config use-context $ENVIRONMENT

# Create Job for database migration
kubectl create -f db-migration.yaml

set +e

# Wait for completion as background process then capture PID
# Subprocess will exit 0 if condition is met
kubectl wait --for=condition=complete job/$APPNAME-db-migration --timeout=150m &
completion_pid=$!

# Wait for failure as background process then capture PID
# Subprocess will exit 2 if condition is met
kubectl wait --for=condition=failed job/$APPNAME-db-migration --timeout=150m && exit 2 &
failure_pid=$!

# Capture exit code of the first subprocess to exit and store in variable
wait -n $completion_pid $failure_pid
exit_code=$?

# Get Job and launched pod status and show logs
kubectl get job $APPNAME-db-migration
kubectl get pod | grep $APPNAME-db-migration
kubectl logs job/$APPNAME-db-migration

# Either subprocess will have exit code 1 if they timed out
if (( $exit_code == 1 )); then
  echo "Kubectl wait command timed out. Job pod might still be running DB migration."
else
  kubectl delete job $APPNAME-db-migration
fi

exit $exit_code
