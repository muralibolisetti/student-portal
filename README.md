# Student Portal

The sample application deployed by [DeployFlow](https://github.com/muralibolisetti/deployflow) to demonstrate GitOps.

This repository is the desired state of the application. DeployFlow and Argo CD read it and apply it to Kubernetes.

The `k8s/` folder holds plain Kubernetes manifests:

- `configmap.yaml`: the web page, which can be changed through Git.
- `deployment.yaml`: two nginx replicas that serve the page.
- `service.yaml`: an internal Service in front of the pods.

To publish a new release, run this in WSL:

```bash
./release.sh v4 "Results are now published."
```

It updates the page, changes the `release` annotation on the Deployment and pushes to GitHub. The annotation change makes Kubernetes restart the pods, so the new page appears straight after a sync. Without it, a ConfigMap change took 37 to 85 seconds to reach running pods.
