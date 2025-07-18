require 'spec_helper_acceptance'

describe 'thumbor' do
  before(:all) do
    apply_manifest(%(
      if ($facts['os']['family'] == 'RedHat') and (versioncmp($facts['os']['release']['major'], '8') == 0) {
        stdlib::ensure_packages('python38')
      }
      if ($facts['os']['family'] == 'RedHat') and (versioncmp($facts['os']['release']['major'], '8') >= 0) {
        stdlib::ensure_packages('iproute')
      }
      # cURL is needed to send requests to Thumbor
      stdlib::ensure_packages('curl')
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
      # be_listening() tests will fail if `ss` is not installed.
      it { is_expected.to be_listening }
    end

    it 'responds to requests' do
      # Thumbor may take a while to start up
      sleep(15)
      # Use the test image from Thumbor's documentation
      run_shell('curl -v http://localhost:8000/unsafe/300x200/https%3A%2F%2Fgithub.com%2Fthumbor%2Fthumbor%2Fraw%2Fmaster%2Fexample.jpg --output /dev/null') do |r|
        expect(r.stderr).to match(%r{200 OK})
        expect(r.exit_code).to be_zero
      end
    end
  end
end
