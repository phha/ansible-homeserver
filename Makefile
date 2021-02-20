all: playbook
.PHONY: playbook all retry vars hosts Makefile galaxy %

Makefile:

%: galaxy inventory
	@ansible-playbook -K -i inventory --ask-vault-pass --tags $@ site.yaml

vars: inventory
	@ansible-vault edit inventory/group_vars/all.yml

hosts: inventory
	@ansible-vault edit inventory/inventory.yml

galaxy: 
	@ansible-galaxy install -r requirements.yml

inventory:
	@echo "Looks like this is the first time you are running this playbook."
	@echo
	@echo "We will now create a copy of the example inventory for you."
	@echo
	@echo "Next, we are going to set up your variables and inventory. As these"
	@echo "files may contain sensitive data you will have to provide a password"
	@echo "which will be used to encrypt the contents. Remember it well, as you"
	@echo "will need it whenever you run the playbook or change your variables."
	@echo
	@echo "After you have provided your password, we will open an editor where"
	@echo "you can adjust the variables. You will have to provide your password"
	@echo "Again to open the file for editing"
	@echo
	@echo "Next we will open an editor where you can configure the target"
	@echo "machine(s)"
	@echo
	@cp -ar inventory-example/ inventory/
	@ansible-vault encrypt inventory/group_vars/all.yml inventory/inventory.yml
	@ansible-vault edit inventory/group_vars/all.yml inventory/inventory.yml

playbook: galaxy inventory
	@ansible-playbook -K -i inventory --ask-vault-pass site.yaml

retry: galaxy inventory
	@ansible-playbook -K -i inventory --ask-vault-pass --limit @site.retry site.yaml
