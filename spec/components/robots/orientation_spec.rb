# frozen_string_literal: true

require './components/robots/orientation'

RSpec.describe Robots::Orientation do
  let(:facing) { 1 }
  let(:min_facing) { 0 }
  let(:max_facing) { described_class::ORIENTATION_SIZE - 1 }

  subject { described_class.new(facing) }

  describe 'Actions' do
    describe '#left' do
      it { expect(described_class.new(facing).left.to_i).to eq(facing + described_class::LEFT) }
      it { expect(described_class.new(min_facing).left.to_i).to eq(max_facing) }
    end

    describe '#right' do
      it { expect(described_class.new(facing).right.to_i).to eq(facing + described_class::RIGHT) }
      it { expect(described_class.new(max_facing).right.to_i).to eq(min_facing) }
    end
  end

  describe 'Conversions' do
    describe '#move_modifier' do
      it { expect(subject.move_modifier).to eq described_class::MOVEMENT_MODIFIER[facing] }
    end

    describe '#to_s' do
      it { expect(subject.to_s).to eq 'EAST' }
    end

    describe '#to_h' do
      it { expect(subject.to_h).to eq(orientation: facing) }
    end

    describe '#to_i' do
      it { expect(subject.to_i).to eq facing }
    end

    describe '.new_from_name' do
      it { expect(described_class.new_from_name('EAST').to_i).to eq 1 }
      it { expect(described_class.new_from_name('WEST').to_s).to eq 'WEST' }
    end
  end
end
