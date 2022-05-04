# @summary Manage the Python installation
# @api private
class thumbor::python {
  if $thumbor::manage_python {
    class { 'python' :
      * => $thumbor::python_config,
    }
  }
}
