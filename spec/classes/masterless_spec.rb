require 'spec_helper'

describe 'masterless' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "masterless class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('masterless::params') }
          it { is_expected.to contain_class('masterless::install').that_comes_before('masterless::config') }
          it { is_expected.to contain_class('masterless::config') }
          it { is_expected.to contain_class('masterless::service').that_subscribes_to('masterless::config') }

          it { is_expected.to contain_service('masterless') }
          it { is_expected.to contain_package('masterless').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'masterless class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('masterless') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
