require 'spec_helper'

describe Adb::Peco::Command do
  let(:argv) { [] }
  let(:command) { Adb::Peco::Command.new(argv) }

  describe '#serial_option' do
    subject { command.serial_option }

    context 'when missing args' do
      let(:argv) { [] }

      it { is_expected.to be_nil }
    end

    context "when args are 'shell'" do
      let(:argv) { [ "shell" ] }
      let(:device1) do
        double(:device).tap do |d|
          allow(d).to receive(:model).and_return("Pixel 5")
          allow(d).to receive(:qualifier).and_return("XXXXXXX")
        end
      end
      let(:device2) do
        double(:device).tap do |d|
          allow(d).to receive(:model).and_return("Pixel 5")
          allow(d).to receive(:qualifier).and_return("XXXXXXX")
        end
      end

      it { is_expected.to be_nil }

      context "when 'DeviceAPI::Android.devices' returns 1 device" do
        before do
          allow(DeviceAPI::Android).to receive(:devices).and_return([device1])
        end

        it { is_expected.to be_nil }
      end

      context "when 'DeviceAPI::Android.devices' returns 2 devices" do
        before do
          allow(DeviceAPI::Android).to receive(:devices).and_return([device1, device2])
          allow(PecoSelector).to receive(:select_from) { |array| Array(array[0][1]) }
        end

        it { is_expected.to eq("-s #{device1.qualifier}") }
      end
    end
  end

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