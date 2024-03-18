# Deliverables

This project builds the following artifacts:
* A docker image that can be used to run this application stand-alone.
* A .jar file with only the Frank configuration of this project. The .jar file can be uploaded in het-integratie-platform, see https://github.com/wearefrank/het-integratie-platform. 

# CI/CD

We use conventional commits, see https://www.conventionalcommits.org/en/v1.0.0/. Releases are created automatically by GitHub Actions, see [.github/workflows/ci.yml](.github/workflows/ci.yml) and [.github/workflows/release.yml](.github/workflows/release.yml).

Please take care to write meaningful commit messages that result in meaningful entries in [CHANGELOG.md](CHANGELOG.md). Here is an example of the commit message for a breaking change:

    chore: example of a chore that breaks

    BREAKING: This is what breaks

This commit message appears as follows in the release notes:

![changeLogScreenshot.jpg](./changeLogScreenshot.jpg)

A breaking change means that this version is not backwards compatible with the previous release. A breaking change should result in a major release (first number of semantic version is incremented). Please note the following:

* The word BREAKING should appear on the last line of the commit message.
* The word BREAKING is followed by a `:` and a description. This description appears in the release notes in a bullet that explains what is breaking.
* The commit type (e.g. chore) is still relevant for breaking changes. This information appears in the release notes in the same way as a non-breaking change.
* For non-breaking changes, omit the line with BREAKING and make a commit message like the first line shown.

# Checklist for testing CI/CD

Here is a checklist for testing the CI/CD.

* Testing goes best when you make hot fixes on the main branch. Check with the team that you are allowed to do this.
* Do a commit on main that has a commit message starting with `fix:`. The following should happen:
  * The pipeline succeeds - this checks all authorizations are in place.
  * A commit with a message starting with `chore:` has been added automatically.
  * The extra commit updates files `src/main/resources/BuildInfo.properties`, `configurations/{{ cookiecutter.configuration_name }}/BuildInfo.properties`, `publiccode.yaml` and `CHANGELOG.md`.
  * These files should have trustworthy contents - speaks for itself.
  * On GitHub, there is a tag for the new version that starts with `v`. For example if the new release is `3.2.1` then the tag should be `v3.2.1`. You can get this tag using `git fetch origin` on the command line.
  * The docker image for the release has been created on http://www.dockerhub.com. The `latest` tag should have been updated - creation time should be the current time. Depending on the type of release, the `3.2.1`, the `3.2` or the `3` tags should be the current date.
  * Check on dockerhub that tags that should not have been updated do not have the current time as creation time.
  * Run the docker image using `docker run -p 8080:8080 wearefrank/{{ cookiecutter.configuration_name }}:3.2.1`. Check the name of the docker container you started using `docker ps -a`. Login to the docker container using `docker exec -it <container name> bash`. Check that `/opt/frank/resources/BuildInfo.properties` and `/opt/frank/configurations/{{ cookiecutter.configuration_name }}/BuildInfo.properties` contain the right version and the right date.
* Check a breaking change like above. This should update the major version.
* Do a commit with \[skip ci\] in the commit message. It should not make a release and it should not push a docker image.
* Make a pull request. Check that no release is made and that no docker image is pushed.
