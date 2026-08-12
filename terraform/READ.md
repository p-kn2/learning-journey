I integrated Trivy into Jenkins CI/CD pipelines after the Docker image build stage. The pipeline scans the image for vulnerabilities and fails automatically if High or Critical vulnerabilities are found using --exit-code 1. Scan reports are generated and reviewed before pushing images to the container registry and deploying them to Kubernetes.




GitHub : 
We follow a feature-branch based Git workflow. Developers create separate feature branches from the main development branch. Once development is completed, a Pull Request is raised and code review is performed. After approval, the changes are merged into the develop branch. Jenkins automatically triggers CI pipelines for build, testing, SonarQube analysis, and security scans. For releases, code is merged into the main/master branch and deployed to higher environments. Hotfix branches are created from production when critical issues need immediate fixes.


We followed a fork-based Git workflow. I would first fork the upstream repository, keep my origin main branch synchronized with the upstream main branch, and then create feature branches from my origin main branch. After completing development and testing, I would push the changes to my fork and raise a Pull Request to the upstream repository for review and merge

We used a forking workflow along with feature branches. Each developer worked on their own forked repository. We synchronized our fork's main branch with the upstream main branch and created feature branches for development. Changes were submitted through Pull Requests and reviewed before merging into the upstream repository..


Kubernetes : 


My experience is primarily operational and support-focused rather than cluster administration. I have worked with Kubernetes deployments, pods, services, ingress configurations, and troubleshooting application issues. I have used kubectl extensively to check pod status, logs, deployments, and rollout activities while supporting CI/CD deployments from Jenkins.
