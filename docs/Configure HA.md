# Integrations

## Device tracker

https://forum.hacf.fr/t/device-tracker-monitorer-ou-suivre-vos-materiels-dans-home-assistant/219

https://www.home-assistant.io/integrations/nmap_tracker/

![nmap tracker](https://www.home-assistant.io/images/integrations/nmap/nmap_customization_example.png)

https://forum.hacf.fr/uploads/default/optimized/2X/d/d9d2cd462a63daf71526fea303889c7063b79f06_2_690x299.jpeg

## Groups

UI Configuration :
https://www.home-assistant.io/integrations/group/

![Group settings](https://www.home-assistant.io/images/integrations/group/Group_settings.png)

## Alarm

Manual Alarm Control Panel integration :
https://www.home-assistant.io/integrations/manual/

- Alarmo :
https://github.com/nielsfaber/alarmo#sensor-groups

https://community.home-assistant.io/t/smarter-alarm-using-templates-to-only-alert-if-several-sensors-triggered-in-60-seconds/409043
https://forum.hacf.fr/t/personnaliser-noms-carte-alarm-control-panel/2271

## System Monitor

**Docker** 
https://github.com/ualex73/monitor_docker

## Alexa Media Player

This is a custom component to allow control of Amazon Alexa devices in Home Assistant using the unofficial Alexa API. Please note this mimics the Alexa app but Amazon may cut off access at anytime.

https://github.com/custom-components/alexa_media_player
https://github.com/custom-components/alexa_media_player/wiki/Configuration

Instead of using a separate 2FA code, you can also register a 2FA app with Alexa Media Player.
https://www.amazon.fr/a/settings/approval

1. Go to Amazon.com's 2FA page and Add new App. You should save this key so you can reuse it if you reinstall.
2. Instead of scanning the QR code, select Can't scan the barcode.
3. Select the bolded value under Enter your Key (e.g., 35T5 LQSY I5IO 3EFQ LGAJ I6YB JWBY JJPR PYT7 XPPW IDAK SQBJ CVXA)
4. Enter the value from Step 3 in the Built-in 2FA App Key when adding the integration. 2FA should be automatically generated from now on and can be left blank.

### Auto Backup (HACS) -tbd

https://jcwillox.github.io/hass-auto-backup/services/

## SmartThinQ LGE Sensors

https://github.com/ollo69/ha-smartthinq-sensors


# Dashboard (Lovelace)

## Button card

 https://github.com/custom-cards/button-card

## Mushroom cards 

https://github.com/piitaya/lovelace-mushroom

- Open HACS in Home Assistant
- Go to "Frontend" section and Click button with "+" icon
- Search for "Mushroom"

![mushroom cards](https://user-images.githubusercontent.com/5878303/152332130-760cf616-5c40-4825-a482-bb8f1f0f5251.png)

Example of integration : https://smarthomescene.com/guides/mushroom-cards-complete-guide-to-a-clean-minimalistic-home-assistant-ui/

## Decluttering card 

Reuse multiple times the same card configuration with variables to declutter your config.

https://github.com/custom-cards/decluttering-card


