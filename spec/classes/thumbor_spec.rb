require 'spec_helper'
describe 'thumbor' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with default parameters' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('thumbor') }
        it { is_expected.to contain_class('thumbor::install') }
        it { is_expected.to contain_class('thumbor::config') }
        it { is_expected.to contain_class('thumbor::python') }
        it { is_expected.to contain_class('thumbor::service') }
        it { is_expected.to contain_class('python') }
        it { is_expected.not_to contain_python_pyvenv('python') }

        if facts[:kernel] == 'Linux'
          it do
            is_expected.to contain_service('thumbor@8000').with(
              ensure: 'running',
              enable: true,
            )
          end
        end
      end

      context 'when setting security_key' do
        let :params do
          {
            security_key: 'AAAAABBBBCCCCC111112222233333'
          }
        end

        it { is_expected.to contain_file('/etc/thumbor.key').with(mode: '0600') }
        it { is_expected.to contain_file('/etc/thumbor.key').with_content(%r{AAAAABBBBCCCCC111112222233333}) }
      end

      context 'when setting config' do
        let :params do
          {
            config: {
              AUTO_WEBP: true,
              ENGINE_THREADPOOL_SIZE: 4,
              HTTP_LOADER_MAX_CLIENTS: 1024,
            },
          }
        end

        it { is_expected.to contain_file('/etc/thumbor.conf').with_content(%r{AUTO_WEBP = True}) }
        it { is_expected.to contain_file('/etc/thumbor.conf').with_content(%r{ENGINE_THREADPOOL_SIZE = 4}) }
        it { is_expected.to contain_file('/etc/thumbor.conf').with_content(%r{HTTP_LOADER_MAX_CLIENTS = 1024}) }
      end

      context 'when setting ports' do
        let :params do
          {
            ports: ['8000', '8001', '8002']
          }
        end

        if facts[:kernel] == 'Linux'
          it { is_expected.to contain_service('thumbor@8000') }
          it { is_expected.to contain_service('thumbor@8001') }
          it { is_expected.to contain_service('thumbor@8002') }
        end
      end

      context 'when declaring manage_python is false' do
        let :params do
          {
            manage_python: false
          }
        end

        it { is_expected.to contain_class('thumbor::python') }
        it { is_expected.not_to contain_class('python') }
      end

      context 'when setting venv_path' do
        let :params do
          {
            venv_path: '/opt/thumbor_venv',
            manage_python: true,
            python_config: {
              version: 'python3',
              pip: 'present',
              dev: 'present',
              venv: 'present',
            },
          }
        end

        it { is_expected.to contain_python__pyvenv('/opt/thumbor_venv') }
      end
    end
  end
end
