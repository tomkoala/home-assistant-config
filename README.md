# My Home Assistant Configuration Files

## Introduction

This is my configuration of [Home Assistant](https://home-assistant.io/) home automation solution.
To ease the deployment a *Makefile* is included and allows to send the configuration files to the remote host

This also makes use of the packaging capabilities of HA https://www.home-assistant.io/docs/configuration/packages/

**Features**
------------

* Some [Security notifications]() 🚨  when motion is detected or the front door has been open during absence
* An optional Home Alarm state machine build on native HA [Manual Alarm](https://www.home-assistant.io/integrations/manual) control panel triggering a plugable siren and playing alarm sound on a Echo Dot device 
* Media player (Amazon Echo Dot) with Text to Speech 🔈
* Cover management with Somfy RTS devices controlled by [Airsend Duo](https://devmel.com/fr/airsend-duo.html) - requires specific container
* System Monitoring and backup 🖥
* Arriving and leaving notifications 🔔
* Device tracker using ARP scan

## Usage

In order to deploy configurations on remote host

```
make deploy-config
make deploy-secrets
```

By default the remote host is defined as `pi@domopi`

The configuration setup shall be reloaded from HA portal or by restarting HA from the shell

## Secrets

A sample `secrets` file is provided as example but shall be populated and renamed as `secrets.yaml`

## Credits

- Packages structure : https://github.com/Apocrathia/home-assistant-config
- Makefile : https://github.com/frenck/home-assistant-config/

Some sample configurations are provided here : https://www.home-assistant.io/examples/#example-configurationyaml

## FAQ

Feel free to ask any questions using GitHub [Issues](http://github.com/tomkoala/home-assistant-config/issues).