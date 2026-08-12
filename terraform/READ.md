I integrated Trivy into Jenkins CI/CD pipelines after the Docker image build stage. The pipeline scans the image for vulnerabilities and fails automatically if High or Critical vulnerabilities are found using --exit-code 1. Scan reports are generated and reviewed before pushing images to the container registry and deploying them to Kubernetes.




GitHub : 

We used a forking workflow along with feature branches. Each developer worked on their own forked repository. We synchronized our fork's main branch with the upstream main branch and created feature branches for development. Changes were submitted through Pull Requests and reviewed before merging into the upstream repository..


Kubernetes : 


My experience is primarily operational and support-focused rather than cluster administration. I have worked with Kubernetes deployments, pods, services, ingress configurations, and troubleshooting application issues. I have used kubectl extensively to check pod status, logs, deployments, and rollout activities while supporting CI/CD deployments from Jenkins.


ConfigMap:
We used ConfigMaps to externalize application configuration such as environment variables, database hostnames, ports, API URLs, and logging levels. This allowed us to update configuration without rebuilding Docker images and kept the deployment manifests reusable across environments. Also, remember ConfigMap is for non-sensitive data, while Secrets are used for passwords, tokens, and API keys.

Q: Difference between ConfigMap and Secret?

A:

ConfigMap → Non-sensitive data (URLs, ports, environment names).
Secret → Sensitive data (passwords, tokens, certificates). Often stored as base64-encoded values in Kubernetes.