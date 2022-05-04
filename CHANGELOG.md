# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

### Removed
* remove parameter `$default_options` (use `$config` instead)

## v1.0.0
Initial release before forking the module

[Unreleased]: https://github.com/markt-de/puppet-thumbor/compare/v1.0.0...HEAD
