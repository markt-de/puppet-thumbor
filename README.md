# puppet-thumbor

[![Build Status](https://travis-ci.org/markt-de/puppet-thumbor.png?branch=main)](https://travis-ci.org/markt-de/puppet-thumbor)
[![Puppet Forge](https://img.shields.io/puppetforge/v/fraenki/thumbor.svg)](https://forge.puppetlabs.com/fraenki/thumbor)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/fraenki/thumbor.svg)](https://forge.puppetlabs.com/fraenki/thumbor)

#### Table of Contents

1. [Overview](#overview)
1. [Usage](#usage)
1. [Reference](#reference)
1. [Development](#development)

## Overview

Puppet module to deploy and manage [Thumbor](https://github.com/thumbor/thumbor/).

## Usage

### Basic usage

Install Thumbor in your environment:

```
class { 'thumbor':
  ports => [ '8000' ],
}
```

Next go on your favorite shell browser (like curl or wget) and open http://127.0.0.1:8000/unsafe/200x200/https://puppet.com/themes/hoverboard/images/puppet-logo/puppet-logo-amber-white-lg.png (as an example) from the same machine as to where you applied the puppet code.

### Classes and Defined Types

#### Class: Thumbor

Installs and manages Thumbor

** Parameters within `thumbor`

#### `ensure`

Enum['present', 'absent']
*Default: present*

Controls if everything will be installed or forcefully will be removed

#### `security_key`

Optional[String]
*Default: undef*

The security key to hash the requested url with in Thumbor.
Please see the documentation of Thumbor for more information about this topic.

#### `listen`

String
*Default: 127.0.0.1*

The ip address to listen on.

#### `ports`

Variant[Array[String],String]
*Default: [ '8000' ]*

The port(s) Thumbor listens on.
This settings also controls how many instances are spinned up.

#### `virtualenv_path`

Optional[String]
*Default: undef*

If this setting is undef we will not use virtualenv.
If set, we will use the path as base for a virtual environment.

#### `package_name`

String
*Default: thumbor*

Name of the pip package to install.

#### `package_ensure`

Enum['present', 'absent', 'latest']
*Default: [$ensure](#ensure)*

Controls what is ensured on the pip installation.
Can be set to latest, to force pip to always installs the latest available version.
But can also be set to a specifc version to force that version to be installed.

#### `pip_proxyserver`

Variant[Boolean, String]
*Default: false*

The full URL to the proxy server to use with the pip installation of packages.
Note that if you dont want to use a proxy, this should be set to false.

#### `ensure_user`

Boolean
*Default: true*

If we should manage the user from the thumbor code.

#### `user`

String
*Default: thumbor*

The user to run the thumbor process with.

#### `ensure_group`

Boolean
*Default: true*

If we should manage the user from the thumbor code.

#### `group`

String
*Default: thumbor*

The group to run the thumbor process with.

#### `config`

Hash
*Default: {'allowed_sources' => ['.']}*

The configuration for thumbor.
Note the hash keys will be converted to upper case.

You can refer to Thumbor wiki for configuration options https://github.com/globocom/thumbor/wiki/Configuration 

#### `additional_packages`

[Array]
*Default: A OS-specific list of packages*

Specifies a list of additional packages that are required for thumbor or any of it's dependencies.

## Reference

### Classes

#### Public Classes

* `thumbor`: Installs and manages Thumbor

#### Private Classes

* [`thumbor::config`]  Manages the configuration of the thumbor application
* [`thumbor::install`] Manages the installation of the thumbor packages
* [`thumbor::service`] Manages the installation of the thumbor services

## Development

### Contributing

Please use the GitHub issues functionality to report any bugs or requests for new features. Feel free to fork and submit pull requests for potential contributions.
