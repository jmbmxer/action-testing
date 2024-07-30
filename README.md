# RAD Runtime Action Setup Guide

## Repository Setup
1. Create a new repository on GitHub or use an existing one.
2. Clone the repository to your local machine.

## Add Necessary Files
1. Create a `.github/workflows` directory in your repository.
2. Add the `security-analysis.yml` file (the GitHub Action workflow) to this directory.
3. Add the `docker-compose.yml` file to the root of your repository.
4. Create and add the following Python scripts to your repository:
   - `retrieve_fingerprint.py`
   - `compare_fingerprints.py`
   - `analyze_changes.py`
   - `check_policies.py`
5. Create a `Dockerfile` that represents your application.
6. Create a `baseline_fingerprint.yaml` file with a known good state of your application.

## Configure Secrets
In your GitHub repository:
1. Go to "Settings" > "Secrets and variables" > "Actions"
2. Add the following secrets:
   - `KSOC_API_URL`
   - `KSOC_API_ACCESS_KEY_ID`
   - `KSOC_API_SECRET_KEY`

## Local Testing (Optional)
Before pushing to GitHub, you can test parts of the workflow locally:

1. Build and run your container:
   ```
   docker build -t app:test .
   docker run -d --name test_container app:test
   ```

2. Run the eBPF agent using docker-compose:
   ```
   docker-compose up -d
   ```

3. Test the `retrieve_fingerprint.py` script:
   ```
   python3 retrieve_fingerprint.py <API_URL> <API_KEY> <API_SECRET> <CONTAINER_ID> > new_fingerprint.yaml
   ```

4. Test the comparison and analysis scripts:
   ```
   python3 compare_fingerprints.py baseline_fingerprint.yaml new_fingerprint.yaml > comparison_result.json
   python3 analyze_changes.py comparison_result.json > analysis_report.json
   python3 check_policies.py analysis_report.json
   ```

## Push Changes to GitHub
Commit all your changes and push them to your GitHub repository:
```
git add .
git commit -m "Add security analysis workflow"
git push origin main
```

## Trigger the GitHub Action
1. Go to your GitHub repository page.
2. Click on the "Actions" tab.
3. You should see the "Security Analysis" workflow running.
4. Click on the running workflow to see its progress and logs.

## Create a Pull Request (Optional)
To test the workflow on a pull request:
1. Create a new branch: `git checkout -b test-branch`
2. Make some changes to your application code.
3. Commit and push the changes:
   ```
   git add .
   git commit -m "Test changes"
   git push origin test-branch
   ```

4. Go to GitHub and create a new pull request from `test-branch` to `main`.
5. The workflow should automatically run on this pull request.

## Review Results
1. After the workflow completes, go to the "Actions" tab and click on the completed run.
2. Check the logs for each step to ensure they completed successfully.
3. Look for the "Report Results" step, which should have uploaded artifacts.
4. Download and review the artifacts, which include:
   - `new_fingerprint.yaml`
   - `comparison_result.json`
   - `analysis_report.json`

## Iterative Testing
1. Make changes to your application or Dockerfile.
2. Push the changes or create new pull requests.
3. Observe how the workflow detects and reports on these changes.

## Troubleshooting
If you encounter issues:
1. Check the workflow logs for error messages.
2. Ensure all secrets are correctly set in your repository settings.
3. Verify that your API endpoints are correct.