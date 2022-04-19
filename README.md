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

### Reference

Classes and parameters are documented in [REFERENCE.md](REFERENCE.md).

## Development

### Contributing

Please use the GitHub issues functionality to report any bugs or requests for new features. Feel free to fork and submit pull requests for potential contributions.
