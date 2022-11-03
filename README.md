![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white) ![PHP](https://img.shields.io/badge/php-%23777BB4.svg?style=for-the-badge&logo=php&logoColor=white)
# Lucid Host Update Script (Ptero v1.10.4)

Files included are used by Lucidhost.co to Update pterodactyl.

Was originally made for the script to be ran and download files from this github, maybe one day I'll update it so you can download the repo and not need to download it a second time 🤦‍♂️


## Features

- Custom Container Name (container@lucidhost)
- [Custom Footer by Esmile](https://pterodactylmarket.com/resource/431)
- [Server Router Icons by harrydev](https://pterodactylmarket.com/resource/382)


## Installation

**Install lucid-update along side a already running pterodactyl instance.**

****Warning* If you are running the script as root/superuser, you will get stopped to allow composer to run, just hit yes and continue.**


Open up a new file in your favorite text editor
```sh
  nano update-panel.sh
```
Copy raw text and paste it into nano from [update-panel.sh](https://raw.githubusercontent.com/lPrestonl/lucidhost/main/update-panel.sh)

```sh
chmod +x update-panel.sh
```
Then run it

```sh
./update-panel
```
## Roadmap

- Add more up-to-date Addons

- Make script pull from folder itself instead of redownloading the repo a second time.

- Add flags to script?

- No Other Known Issues



## Authors

- [@lPrestonl](https://www.github.com/lPrestonl)

