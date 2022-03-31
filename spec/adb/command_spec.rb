require 'spec_helper'

describe Adb::Peco::Command do
  let(:argv) { [] }
  let(:command) { Adb::Peco::Command.new(argv) }

  describe '#adb_action' do
    subject { command.adb_action }

    it { is_expected.to eq(nil) }

    context "when args are 'shell'" do
      let(:argv) { ["shell"] }

      it { is_expected.to eq("shell") }
    end
  end
end