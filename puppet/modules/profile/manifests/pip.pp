#install pip and ensure correct symlink
class profile::pip{
  $get_pip_py = '/usr/local/bin/get-pip.py'
  $get_pip_url = "https://bootstrap.pypa.io/get-pip.py"
  $get_pip_install = "/usr/bin/wget --output-document=- --quiet ${get_pip_url} > ${get_pip_py}"

  $pip = '/usr/bin/pip'
  $pip_install = "/usr/bin/python ${get_pip_py}"
  $pip_provider = '/usr/bin/pip-python'

  exec{ $get_pip_install : creates => $get_pip_py }

  exec{ $pip_install : creates => $pip, require => Exec[$get_pip_install] }

  file{ $pip_provider:
    ensure  => 'link',
    target  => $pip,
    require => Exec[$pip_install]
  }
}