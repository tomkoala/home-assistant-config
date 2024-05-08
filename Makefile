# Home Assistant Config
# Makefile for deploying config on a remote host

BASE_DIR:=$(shell pwd)
DEPLOY_DIR=$(BASE_DIR)/deploy

DEST_VOL:=/mnt/usbdrive/docker
INSTALL_HOST=pi@domopi
INSTALL_DIR=$(DEST_VOL)/volumes/homeassistant

TMPID:=$(shell bash -c "echo $$$$")

PRIVATE_FILES=secrets.yaml

# Default target
.PHONY: default
default:
	$(info Please specify a make target. )

# Clean build
.PHONY: clean
clean:
	$(info Cleaning build. )
	rm -rf $(DEPLOY_DIR)

.PHONY: install-homeassistant
install-homeassistant: install-docker

	#sudo apt-get --yes --force-yes install nmap fortunes libttspico-utils fswebcam
	#docker-compose

	#cd $(INSTALL_DIR) && . $(VIRTUALENV_ACTIVATE) && cd home-assistant && sudo python3 setup.py clean
	#cd $(INSTALL_DIR) && . $(VIRTUALENV_ACTIVATE) && cd home-assistant && sudo python3 setup.py install
	#chown -R homeassistant. $(INSTALL_DIR)

.PHONY: install-docker
install-docker:
	
	#apt-get update --yes --force-yes
	#sudo apt-get --yes --force-yes install python3 python3-venv python3-pip  
	
	#mkdir -p $(INSTALL_DIR)
	#[ ! -d $(INSTALL_DIR)/env ] && cd $(INSTALL_DIR) && sudo python3 -m venv env || true
	#cd $(INSTALL_DIR) && . $(VIRTUALENV_ACTIVATE) && cd home-assistant && sudo pip3 install -r requirements.txt --upgrade
	#sudo chown -R homeassistant $(INSTALL_DIR)/env

.PHONY: install
install: install-docker install-homeassistant

# Default target
.PHONY: test-config
test-config:

	$(info Launching docker command...)
	
	@ssh $(INSTALL_HOST) "\
		docker exec homeassistant python -m homeassistant --script check_config --config /config"

.PHONY: archive-config
archive-config:

	$(info Creating archive for HASS config...)

	@mkdir -p $(DEPLOY_DIR)/hass-config
	@rsync -a \
		  --exclude='*.db' --exclude='*.log' \
		  --exclude='*.sample' --exclude='*.DS_Store'  \
		  --exclude='secrets.yaml' \
		  --exclude='.google.token' --exclude='.uuid' \
		  --exclude='config/tts/' --exclude='config/deps' \
		  config \
		  $(DEPLOY_DIR)/hass-config/

	@cd $(DEPLOY_DIR) && tar cvzf hass-config.tar.gz hass-config
	@rm -Rf $(DEPLOY_DIR)/hass-config/

.PHONY: archive
archive: archive-config

.PHONY: test
test: 

.PHONY: deploy-config
deploy-config: archive-config 

	$(info Deploying HASS config to $(INSTALL_HOST) host:)

	@scp $(DEPLOY_DIR)/hass-config.tar.gz $(INSTALL_HOST):/tmp
	@ssh $(INSTALL_HOST) "\
		mkdir -p /tmp/hass-$(TMPID) && \
		cd /tmp/hass-$(TMPID) && \
		tar xf ../hass-config.tar.gz"

	$(info Backing mandatory configs up before updating.)

	@ssh $(INSTALL_HOST) "\
	[ -f $(INSTALL_DIR)/config/configuration.yaml ] && \
		sudo mv $(INSTALL_DIR)/config/configuration.yaml $(INSTALL_DIR)/config/configuration.yaml.bak || \
		echo 'No main configuration file to backup'"
	@ssh $(INSTALL_HOST) "\
		sudo cp -r /tmp/hass-$(TMPID)/hass-config/* $(INSTALL_DIR)"

	#ssh $(INSTALL_HOST) '\
	#	sudo sed -i "s/  \#base_url: !secret base_url/  base_url: !secret base_url/" $(INSTALL_DIR)/config/configuration.yaml'
		
.PHONY: deploy-secrets
deploy-secrets:

	$(info Deploying HA var config to $(INSTALL_HOST).)

	@ssh $(INSTALL_HOST) "\
	[ -f $(INSTALL_DIR)/config/secrets.yaml ] && \
		sudo mv $(INSTALL_DIR)/config/secrets.yaml $(INSTALL_DIR)/config/secrets.yaml.bak || \
		echo 'No secrets file to backup'"
	
	cd $(BASE_DIR)/config && scp $(PRIVATE_FILES) $(INSTALL_HOST):/tmp/
	ssh $(INSTALL_HOST) "\
		cd /tmp && sudo cp $(PRIVATE_FILES) $(INSTALL_DIR)/config && \
		#cd $(INSTALL_DIR)/config && sudo chown homeassistant. $(PRIVATE_FILES) && \
		cd /tmp && rm $(PRIVATE_FILES)" 

.PHONY: deploy
deploy: deploy-config 
