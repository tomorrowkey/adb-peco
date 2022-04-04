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

  describe '#need_serial_option?' do
    subject { command.need_serial_option? }

    context "when missing args" do
      let(:argv) { [] }

      it { is_expected.to be_falsy }
    end

    context "when args are 'shell'" do
      let(:argv) { ["shell"] }

      it { is_expected.to be_truthy }
    end

    context "when args are 'help'" do
      let(:argv) { ["help"] }

      it { is_expected.to be_falsy }
    end

    context "when args are 'devices'" do
      let(:argv) { ["devices"] }

      it { is_expected.to be_falsy }
    end

    context "when args are 'version'" do
      let(:argv) { ["version"] }

      it { is_expected.to be_falsy }
    end

    context "when args are 'start-server'" do
      let(:argv) { ["start-server"] }

      it { is_expected.to be_falsy }
    end

    context "when args are 'stop-server'" do
      let(:argv) { ["stop-server"] }

      it { is_expected.to be_falsy }
    end
  end
end