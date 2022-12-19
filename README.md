# Nodejs extension for Chassis

Install Nodejs within your [Chassis](http://chassis.io/) box! The PHPUnit extension automatically sets up your Chassis instance with the `phpunit` executable, for use running PHP unit tests.

## Activation

### Automated Installation

To add the phpunit extension to a Chassis box, include `chassis/nodejs` in the `extensions` list within your `config.local.yaml` file:

```yml
extensions:
    - chassis/nodejs
```

Then run `vagrant provision` to instruct Chassis to download and install the new extension.

### Manual Installation

Ensure you have a Chassis instance set up locally already.

```
# In your Chassis dir:
cd extensions

# Grab the extension
git clone --recursive https://github.com/Chassis/nodejs.git nodejs

# Reprovision
cd ..
vagrant provision
```

## Specifying a major version

To specify a version of Nodejs to install, add the major version to a Chassis config file:

```
nodejs:
  version: 16
```