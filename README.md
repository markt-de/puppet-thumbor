# puppet-thumbor

[![Build Status](https://travis-ci.org/markt-de/puppet-thumbor.png?branch=main)](https://travis-ci.org/markt-de/puppet-thumbor)
[![Puppet Forge](https://img.shields.io/puppetforge/v/fraenki/thumbor.svg)](https://forge.puppetlabs.com/fraenki/thumbor)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/fraenki/thumbor.svg)](https://forge.puppetlabs.com/fraenki/thumbor)

#### Table of Contents

1. [Overview](#overview)
1. [Usage](#usage)
    - [Basic usage](#basic-usage)
    - [Python venv](#python-venv)
    - [Plugins](#Plugins)
1. [Reference](#reference)
1. [Development](#development)

## Overview

Puppet module to deploy and manage [Thumbor](https://github.com/thumbor/thumbor/).

## Usage

### Basic usage

Install Thumbor in your environment:

```
class { 'thumbor':
  ports        => [ '8000' ],
  security_key => 'AAAAABBBBCCCCC111112222233333',
}
```

Next run a simple test on the same machine to verify that Thumbor is working as expected:

```
curl -v http://127.0.0.1:8000/unsafe/200x200/https://puppet.com/images/logos/puppet-logo-black.svg
```

It is also supported to run multiple instances and to customize various installation parameters:

```
class { 'thumbor':
  config       => {
    'AUTO_WEBP'               => 'True',
    'ENGINE_THREADPOOL_SIZE'  => 4,
    'HTTP_LOADER_MAX_CLIENTS' => 1024,
  },
  listen       => '127.0.0.1',
  ports        => [ '8000', '8001', '8002' ],
  security_key => 'AAAAABBBBCCCCC111112222233333',
  version      => '7.0.9',
}
```

#### Python venv

It is possible to run Thumbor in a Python venv and configure various aspects of the Python installation:

```
class { 'thumbor':
  manage_python  => true,
  ports          => [ '8000' ],
  python_config  => {
    version => 'python3',
    pip     => 'present',
    dev     => 'present',
    venv    => 'present',
  },
  security_key   => 'AAAAABBBBCCCCC111112222233333',
  update_enabled => true,
  venv_path      => '/opt/thumbor_venv',
}
```

This configuration will also automatically update the Python venv to the specified version (if necessary).

#### Plugins

Additional Thumbor [plugins](https://thumbor.readthedocs.io/en/latest/plugins.html) may also be installed via PIP:

```
class { 'thumbor':
  plugins => [ 'tc_aws', 'thumbor_spaces' ],
  ...
}
```

### Reference

Classes and parameters are documented in [REFERENCE.md](REFERENCE.md).

## Development

### Contributing

Please use the GitHub issues functionality to report any bugs or requests for new features. Feel free to fork and submit pull requests for potential contributions.
