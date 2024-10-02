# Sefaria Container Unofficial

![Running Sefaria inside codespaces](https://github.com/orxaicom/Sefaria-Container-Unofficial/blob/09cc909500e0b5ddab30415fae38a68ae4883b95/video.gif)

This repository builds and publishes a docker container.
The container is an installation of requirements of running
[Sefaria-Project](https://github.com/Sefaria/Sefaria-Project) as
[described on their website](https://developers.sefaria.org/docs/local-installation-instructions).

## Use cases:
* You can go to [our fork of Sefaria-Project](https://github.com/orxaicom/Sefaria-Project)
  which contains a .devcontainer folder that tells GitHub codespaces how to run it
  inside this container, as you can see in the video above. This way you can experiment
  and develope Sefaria on your browser without going through the lengthy installation
  process and cluttering your system.

* Alternatively you can install Docker on your computer and
  [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
  extension on vscode. After opening
  [our fork of Sefaria-Project](https://github.com/orxaicom/Sefaria-Project)
  in the vscode, a pop up gives you an option to pull this container and
  run the repo inside it locally in isolation which again, keeps your system clean.

* We also use this container as a base to build a
  [desktop app](https://github.com/orxaicom/Sefaria-Desktop-Unofficial)
  for Sefaria.

## NOTICE:
* The image is big (~3.5 Gigs) because it contains the database
  and the installation takes 5 or 10 minutes on codespaces.
* This repo publishes the image to ghcr (GitHub Container Registry),
  [link](https://github.com/orxaicom/Sefaria-Container-Unofficial/pkgs/container/sefaria-container-unofficial)
  on the right hand side of this page.
* The main script that builds the images is
  [install_dependencies.sh](https://github.com/orxaicom/Sefaria-Container-Unofficial/blob/main/deps/install_dependencies.sh)
* This is still an ongoing experimental and unofficial project.

## TODO
* [ ] See whether we can delete these: /data/db/journal /data/db/diagnostic.data
* [ ] Use `npm run watch-client` and `npm run watch` in
      [.devcontainer](https://github.com/orxaicom/Sefaria-Project/blob/master/.devcontainer/postCreate.sh)
      and test whether changing code results in change in the preview, realtime.
