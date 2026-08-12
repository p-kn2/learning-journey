Day to day activity : 
I primarily worked in a support-oriented DevOps role where I monitored Jenkins pipelines, resolved build and deployment issues, supported Kubernetes application deployments, reviewed SonarQube and Trivy scan results, managed Git branches and pull requests, and assisted with AWS and Terraform-based infrastructure changes. My focus was on ensuring smooth CI/CD operations, troubleshooting production and non-production issues, and coordinating with development teams for application releases.


Trivy : 
I integrated Trivy into Jenkins CI/CD pipelines after the Docker image build stage. The pipeline scans the image for vulnerabilities and fails automatically if High or Critical vulnerabilities are found using --exit-code 1. Scan reports are generated and reviewed before pushing images to the container registry and deploying them to Kubernetes.

trivy image \

--severity HIGH,CRITICAL \

--exit-code 1 \

--no-progress \

myapp:${BUILD_NUMBER}


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


Terraform : 

I have worked with Terraform for infrastructure provisioning and management in AWS environments. My experience primarily involves supporting and maintaining existing Terraform code, updating resource configurations, managing variables, reviewing terraform plan outputs, and assisting with infrastructure deployments through CI/CD pipelines. I am familiar with the Terraform workflow including init, validate, plan, and apply, and have worked with resources such as EC2, S3, IAM, Security Groups, and VPC components. I also have an understanding of remote state management using S3 and state locking mechanisms for team collaboration.

Terraform Registry : 
Terraform Registry is a public repository for providers and reusable modules. During terraform init, Terraform downloads the required providers from the registry, and teams can also use pre-built modules from the registry to standardize and accelerate infrastructure deployment.

Yes, for custom Terraform modules, organizations typically maintain the module code in a separate Git repository. The module is referenced through the source parameter, and during terraform init, Terraform downloads the module from the repository. This allows teams to reuse standardized infrastructure components such as VPCs, EKS clusters, EC2 instances, and RDS databases across multiple projects.



spring boot interview : 
In one of my projects, we deployed a Java Spring Boot application using a Jenkins-based CI/CD pipeline. Developers pushed code to Git, which triggered Jenkins. Jenkins built the application using Maven, executed SonarQube code quality analysis, built a Docker image, and performed a Trivy vulnerability scan. If no High or Critical vulnerabilities were found, the image was pushed to the container registry. The application was then deployed to Kubernetes using Deployment and Service manifests. We used ConfigMaps for application configuration and Kubernetes commands for troubleshooting deployments. The underlying AWS infrastructure was provisioned and maintained using Terraform. My role was primarily around supporting the CI/CD process, monitoring deployments, reviewing scan results, troubleshooting Kubernetes issues, and coordinating release activities.

My primary experience is with Java/Spring Boot-based applications, but I have worked in DevOps environments where application technology was not a constraint. I am comfortable supporting CI/CD, Docker, Kubernetes, AWS, and deployment processes for both Java and .NET/C# applications, and I can quickly adapt to project-specific build tools and workflows.


