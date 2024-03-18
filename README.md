# {{ cookiecutter.instance_name }}

Project for Frank applications deployed by JAR or Docker

<!-- TOC -->
* [Skeleton Project for Frank applications deployed by JAR or Docker](#skeleton-project-for-frank-applications-deployed-by-jar-or-docker)
  * [Introduction](#introduction)
  * [Included](#included)
  * [Usage](#usage)
    * [Steps](#steps)
    * [Template variables](#template-variables)
<!-- TOC -->

## Introduction

This project serves as a starting point for new projects or as example for existing ones.
This "empty" Frank! will have configuration files to build and deploy.
 
## Included

* Dockerfile
* Docker compose
* Publicode (WIP)
* GitHub Actions
  * Continuous Integration workflow
  * Release workflow

Please check if you deem all these functionalities necessary, if not remove them.

## Usage

### Steps

1. Create a new repository and choose this as template repository
2. Clone the newly created project
3. Fill in the skeletonrc.json to replace the template strings
4. Run the skeleton.js script with node e.g. `node ./skeleton.js`
5. Add your own configuration files
6. Make sure that the GitHub action credentials are added
7. Commit & Profit!

### Template variables

| Template variable             | Description                                                                                    | Example        |
|-------------------------------|------------------------------------------------------------------------------------------------|----------------|
| `{{ cookiecutter.instance_name }}`            | The name of the Frank! to be deployed. It's best to keep this inline with the name of the repo | Frank2Skeleton |
| `{{ cookiecutter.instance_name_lc }}`         | Lowercase version of the instance name.                                                        | frank2example  |
| `{{ cookiecutter.configuration_name }}`       | The name of the first configuration (others have to be added manually)                         | Sans           |
