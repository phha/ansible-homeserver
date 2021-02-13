Ansible Home Server
===================

An ansible playbook for setting up various self-hosted services on Debian or
Raspbian, using Docker and Ansible.

Prerequisites
-------------

* Install Debian or Raspbian on the machine(s) that are going to run your
  services.

* Install ansible: `pipx install ansible`

* Go to [DuckDNS](https://www.duckdns.org), register and create an API key.
  Make a note of the API key as you will need it later.

Initialization and configuration
--------------------------------

Before starting, you need to initialize your configuration. Run `make inventory`
to do this. This script will create an example configuration and inventory for
you and encrypt it with your chosen password. After that it will open your
configuration file and inventory with your editor of choice, where you can
make adjustments.

To make adjustments to your configuration after first initialization, run
`make vars`. To edit your inventory, run `make inventory`.

Applying your configuration
---------------------------

Simply run `make` to set up all services according to your configuration.

Available services
------------------

* TBD

Advanced topics
---------------

### Updating a single service only

If you only want to change selected services you can pass the service name
as a parameter. Multiple parameters can be separated:
`make portainer,organizr`

### Upgrading

Run `make upgrade,all` to upgrade all services, `make upgrade,portainer,organizr`
to upgrade selected services.

### Advanced options

The example configuration file only contains the most common and mandatory
options. There are many more advanced options available. You can look up
these options in their respective role files:
`roles/servicename/defaults/main.yml`.

You should not edit any of these files directly. Instead copy the option to
your configuration file and override the setting there.

### Skipping dependencies

Most of the services depend on Docker and/or Traefik. This means that every
time you update a service, these dependend roles will be executed as well.

If you are absolutely sure that you won't need to run the dependencies you
can save some time by adding the `nodeps` tag to your call. E.g.:
`make nodeps,portainer`
