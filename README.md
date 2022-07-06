# CASino [![Build Status](https://secure.travis-ci.org/rbCAS/CASino.png?branch=master)](https://travis-ci.org/rbCAS/CASino) [![Coverage Status](https://coveralls.io/repos/rbCAS/CASino/badge.png?branch=master)](https://coveralls.io/r/rbCAS/CASino?branch=master)

CASino Rails Engine (used in CASinoApp).

It currently supports [CAS 1.0 and CAS 2.0](http://apereo.github.io/cas) as well as [CAS 3.1 Single Sign Out](https://wiki.jasig.org/display/CASUM/Single+Sign+Out).

## Setup

Please check our [documentation](http://casino.rbcas.com/) for setup and configuration instructions.

## Test Suite

To run the test suite:

`bundle exec rspec spec`

## License

CASino is released under the [MIT License](http://www.opensource.org/licenses/MIT). See LICENSE.txt for further details.


## Deployment
This application uses a CICD process, the project Jenkins folder can be found in the following link:
https://jenkins.loyaltydevops.co.nz/job/SharedTools/job/casino/


### Jenkins Job List
|Job|URL|Status|
| :---| :--- | :--- |
| **ReleasePipeline** | [Kubernetes/casino/ReleasePipeline](https://jenkins.loyaltydevops.co.nz/job/SharedTools/job/casino/job/ReleasePipeline/) | [![Build Status](https://jenkins.loyaltydevops.co.nz/buildStatus/icon?job=Kubernetes%2Fcasino%2FReleasePipeline)](https://jenkins.loyaltydevops.co.nz/job/SharedTools/job/casino/job/ReleasePipeline/) |
| **DeployApp** | [SharedTools/casino/DeployApp](https://jenkins.loyaltydevops.co.nz/job/SharedTools/job/casino/job/DeployApp/) | [![Build Status](https://jenkins.loyaltydevops.co.nz/buildStatus/icon?job=Kubernetes%2Fcasino%2FDeployApp)](https://jenkins.loyaltydevops.co.nz/job/SharedTools/job/casino/job/DeployApp/) |
| **PRCheck** | [SharedTools/casino/PRCheck](https://jenkins.loyaltydevops.co.nz/job/SharedTools/job/casino/job/PRCheck/) | [![Build Status](https://jenkins.loyaltydevops.co.nz/buildStatus/icon?job=Kubernetes%2Fcasino%2FPRCheck)](https://jenkins.loyaltydevops.co.nz/job/SharedTools/job/casino/job/PRCheck/) |
| **BranchBuildDeploy** | [SharedTools/casino/BranchBuildDeploy](https://jenkins.loyaltydevops.co.nz/job/SharedTools/job/casino/job/BranchBuildDeploy/) | [![Build Status](https://jenkins.loyaltydevops.co.nz/buildStatus/icon?job=Kubernetes%2Fcasino%2FBranchBuildDeploy)](https://jenkins.loyaltydevops.co.nz/job/SharedTools/job/casino/job/BranchBuildDeploy/) |



### CICD Usage
1. Create a **new branch** ideally containing the Jira ticket for better traceability (e.g. `DEVOPS-333-my-branch`).
2. Make your code changes then **push your branch** to Github.
   - Use the Jira id in your commit message
3. **Open a Pull Request** to master/main branch, prefixing the title the Jira ticket (e.g. `[DEVOPS-333] My pull request`).
4. Wait for the PR automated checks to finish in [Jenkins](https://jenkins.loyaltydevops.co.nz/job/SharedTools/job/casino/job/PRCheck/).
5. **Ask for review** in Github.
6. **Merge your code** to master/main once approved and PRCheck passed.
7. **Follow** the ReleasePipeline [Jenkins Build and Push job](https://jenkins.loyaltydevops.co.nz/job/SharedTools/job/casino/job/ReleasePipeline/).
8. **Monitor** your Release and Application for unexpected behavior.

#### Getting help
Join the **#cicd** Slack channel for questions about the CICD process.