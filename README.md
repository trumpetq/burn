# Burning Man Camp Registration

### Overview

This Rails app is used to power our camps registration system at [burn.8bitbunny.com](https://burn.8bitbunny.com/). Our goal is to test it in 2022 and then roll it out as a SasS product for 2023.

### Develop on macOS
1. Use [Homebrew](https://brew.sh) to install rbenv, PosgreSQL, and other native dependencies:

    ```
    $ brew install rbenv vips postgresql
    ```
2. Run the `./bin/setup` script to install gems and NPM dependencies, and create the database.

### Develop on Windows
1. [Install Docker Desktop using WSL 2 backend](https://docs.docker.com/desktop/windows/wsl/)
2. [Install Visual Studio Code](https://code.visualstudio.com/)
3. Make sure to disable the Git `autocrlf` option before cloning the repo, otherwise all the files will be full of CRLFs and won't work.
    ```
    PS C:\> git config --global core.autocrlf false
    ```
   If you've already cloned the repo with CRLFs, it's probably best to delete it and start over.

4. In Visual Studio Code:
   1. [Install Remote - Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
   2. Press `Ctrl`+`Shift`+`P` to open the VS Code command line
   3. Type `Remote-Containers: Open Folder in Container...`
   4. Open the repository folder. The `bin/setup` script will run automatically in the container, installing all gems and creating the database.

### Start
Run the following command and open http://localhost:5050/.
```
$ ./bin/dev
```

### Deploy

```
$ git push heroku
```
