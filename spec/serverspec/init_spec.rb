#  frozen_string_literal: true
require_relative 'spec_helper'

context 'Service listen and respond on port 80' do
  describe port(80) do
    it { is_expected.to be_listening.with('tcp6') }
  end

  describe command('curl -s localhost/web2day.html') do
    its(:stdout) { is_expected.to match %r{OCTO recrute !} }
    its(:exit_status) { is_expected.to eq 0 }
  end
end
