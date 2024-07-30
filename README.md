# eBPF Security Scanning for Docker Images

This repository contains a GitHub Action workflow that performs eBPF-based security scanning on Docker images. It uses a custom eBPF agent to monitor container activities and analyze potential security issues.

## Setup Instructions

1. **Fork this repository** to your GitHub account or organization.

2. **Add your Dockerfile** to the root of the repository. This Dockerfile should define the image you want to scan.

3. **Set up GitHub Secrets** in your forked repository:
   - Go to your repository's Settings > Secrets and variables > Actions
   - Add the following secrets:
     - `ANTHROPIC_API_KEY`: Your Anthropic API key for Claude
     - `EXPORTER_PROVIDER_KSOC_API_URL`: The URL for the KSOC API
     - `EXPORTER_PROVIDER_KSOC_API_ACCESS_KEY_ID`: Your KSOC API access key ID
     - `EXPORTER_PROVIDER_KSOC_API_SECRET_KEY`: Your KSOC API secret key

4. **Customize the `docker-compose.yml` file** if necessary:
   - If your application uses different ports, update the port mappings in the `customer-app` service.

5. **Trigger the workflow**:
   - The workflow runs automatically on pushes to the `main` branch and on pull requests to the `main` branch.
   - You can also manually trigger the workflow from the Actions tab in your GitHub repository.

## How It Works

1. The workflow builds your Docker image from the Dockerfile in the repository.
2. It uses Claude AI to generate a Docker run command that exercises your container effectively.
3. The eBPF agent monitors the container's activities during execution.
4. The workflow collects and analyzes the eBPF data for potential security issues.

## Workflow Steps

1. **Build customer image**: Builds the Docker image from your Dockerfile.
2. **Generate Docker run command**: Uses Claude AI to create a command to run and test your container.
3. **Run Docker Compose**: Starts the eBPF agent, exporter, and your application container.
4. **Exercise customer container**: Runs your container and performs basic HTTP requests to test it.
5. **Collect eBPF agent logs**: Gathers logs from the eBPF agent for analysis.
6. **Analyze eBPF data**: Processes the collected data to identify potential security issues.

## Customization

- **Dockerfile**: Modify the Dockerfile in the root of the repository to define your application's container.
- **docker-compose.yml**: Adjust service configurations if needed, especially for the `customer-app` service.
- **.github/workflows/ebpf-security-testing.yml**: Customize the workflow steps if you need to add specific tests or analysis for your application.

## Troubleshooting

- If the workflow fails, check the GitHub Actions logs for error messages.
- Ensure all required secrets are correctly set in your repository settings.
- Verify that your Dockerfile is valid and builds successfully.

## Support

If you encounter any issues or have questions, please open an issue in this repository.