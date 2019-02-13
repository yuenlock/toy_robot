# frozen_string_literal: true

require './components/robots/orientation'

RSpec.describe Robots::Orientation do
  let(:facing) { 1 }
  let(:min_facing) { 0 }
  let(:max_facing) { described_class::ORIENTATION_SIZE - 1 }

  subject { described_class.new(facing) }

  describe 'Actions' do
    describe '#left' do
      it { expect(described_class.new(facing).left.facing).to eq(facing + described_class::LEFT) }
      it { expect(described_class.new(min_facing).left.facing).to eq(max_facing) }
    end

    describe '#right' do
      it { expect(described_class.new(facing).right.facing).to eq(facing + described_class::RIGHT) }
      it { expect(described_class.new(max_facing).right.facing).to eq(min_facing) }
    end
  end

  describe 'Conversions' do
    describe '#move_modifier' do
      it { expect(subject.move_modifier).to eq described_class::MOVEMENT_MODIFIER[facing] }
      it { expect(subject.move_modifier.respond_to?(:x)).to eq true }
      it { expect(subject.move_modifier.respond_to?(:y)).to eq true }
    end

    describe '#to_s' do
      it { expect(subject.to_s).to eq 'EAST' }
    end

    describe '.build_from_name' do
      it { expect(described_class.build_from_name('EAST').facing).to eq 1 }
      it { expect(described_class.build_from_name('WEST').to_s).to eq 'WEST' }
    end
  end
end
