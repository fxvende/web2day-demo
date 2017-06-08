# frozen_string_literal: true
require 'spec_helper'

describe 'demo' do
  context 'Test with Ubuntu' do
    ubuntu_facts = {
      'os' => {
        'family'  => 'Debian'
      }
    }

    let(:facts) { RSpec.configuration.default_facts.merge(ubuntu_facts) }
    let(:params) { {} }

    context 'compilation worked' do
      it { is_expected.to compile.with_all_deps }
    end

    context 'verify if the correct package is installed and the correct service is started' do
      it { is_expected.to contain_package('apache2').with_ensure('present') }
      it { is_expected.to contain_service('apache2').with_ensure('running') }
    end
  end

  context 'Test with Redhat' do
    redhat_facts = {
      'os' => {
        'family'  => 'RedHat'
      }
    }

    let(:facts) { RSpec.configuration.default_facts.merge(redhat_facts) }
    let(:params) { {} }

    context 'compilation worked' do
      it { is_expected.to compile.with_all_deps }
    end

    context 'verify if the correct package is installed and the correct service is started' do
      it { is_expected.to contain_package('httpd').with_ensure('present') }
      it { is_expected.to contain_service('httpd').with_ensure('running') }
    end
  end

  context 'Test with bad operating system' do
    redhat_facts = {
      'os' => {
        'family'  => 'Trololo'
      }
    }

    let(:facts) { RSpec.configuration.default_facts.merge(redhat_facts) }
    let(:params) { {} }

    context 'compilation does not worked' do
      it { is_expected.to compile.and_raise_error(%r{Unsupported operatingsystem: Trololo}) }
    end
  end
end
