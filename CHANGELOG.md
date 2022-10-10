# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [v2.2.0] - 2022-10-10

### Added
* add new parameter `$service_timeout`

### Changed
* change default service stop timeout to 10s

## [v2.1.1] - 2022-08-30

### Fixed
* fix missing puppet/epel dependency

## [v2.1.0] - 2022-08-30
This is a maintenance release. However, some default values were changed on
RHEL-based distributions. These changes should be tested to avoid breakage of
existing installations.

### Added
* add new parameter `$pip_provider`
* add new parameter `$manage_epel`
* add unit tests to cover the basic functionality
* add basic acceptance tests

### Fixed
* fix wrong path to Thumbor binary when not using Python venv
* fix installation issues on CentOS/Rocky
* fix puppet-lint offenses

### Changed
* enable EPEL on RHEL-based distributions by default
* set default Python version to 3.8 on RHEL8-based distributions
* update documentation (requirements, examples)
* update OS support
* update to PDK 2.5.0

### Removed
* drop support for RHEL7 and Debian 10 (due to incompatible Python3)
* drop obsolete examples

## [v2.0.0] - 2022-05-09
This is a new major release of this module. It adds new functionality,
but also introduces some breaking changes.

### Added
* add support for updating Thumbor and the Python venv
* add new parameter `$version` to control the version of Thumbor
* add new parameter `$python_config` to control Python installation options
* add new parameter `$config_dir` to control where config files are stored
* add new parameter `$update_enabled` to control automatic updates of the Python venv

### Fixed
* fix compatibility issues with voxpupuli/python >=6.0.0
* fix compatibility issues with voxpupuli/systemd >=3.0.0

### Changed
* ensure that the service is always 'running'
* migrate `params.pp` to module data
* rename parameter `$ensure_user` to `$manage_user`
* rename parameter `$ensure_group` to `$manage_group`
* rename parameter `$extentions` to `$plugins`
* rename parameter `$virtualenv_path` to `$venv_path`
* use the `$ensure` parameter for files, user, group, etc.
* add 'opencv-python' to `$plugins` (was previously hardcoded)
* change default python version from 'system' to 'python3'
* change default config directory from '/usr/local' to '/etc'
* enable automatic updates of Thumbor's Python venv
* refactor code into smaller Puppet classes

### Removed
* drop support for Thumbor 6 (upgrades should still be possible)
* remove parameter `$default_options` (use `$config` instead)

## v1.0.0 - 2019-10-23
Initial release before forking the module

[Unreleased]: https://github.com/markt-de/puppet-thumbor/compare/v2.2.0...HEAD
[v2.2.0]: https://github.com/markt-de/puppet-thumbor/compare/v2.1.1...v2.2.0
[v2.1.1]: https://github.com/markt-de/puppet-thumbor/compare/v2.1.0...v2.1.1
[v2.1.0]: https://github.com/markt-de/puppet-thumbor/compare/v2.0.0...v2.1.0
[v2.0.0]: https://github.com/markt-de/puppet-thumbor/compare/v1.0.0...v2.0.0
