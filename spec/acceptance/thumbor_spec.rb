require 'spec_helper_acceptance'

describe 'thumbor' do
  before(:all) do
    apply_manifest(%(
      # Tests will fail if `ss` is not installed.
      if ($facts['os']['family'] == 'RedHat') and (versioncmp($facts['os']['release']['major'], '8') >= 0) {
        ensure_packages('iproute')
      }
    ), catch_failures: true)
  end
  context 'with default parameters' do
    it 'works idempotently with no errors' do
      pp = <<-EOS
      include thumbor
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe service('thumbor@8000') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(8000) do
      it { is_expected.to be_listening }
    end
  end
end
