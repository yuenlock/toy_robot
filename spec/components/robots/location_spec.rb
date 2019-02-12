# frozen_string_literal: true

require './components/robots/location'

RSpec.describe Robots::Location do
  let(:coord_x) { 1 }
  let(:coord_y) { 2 }

  subject { described_class.new(x: coord_x, y: coord_y) }

  describe '#to_s' do
    it { expect(subject.to_s).to eq '1,2' }
  end

  describe '#to_h' do
    it { expect(subject.to_h).to eq(x: coord_x, y: coord_y) }
  end
end
