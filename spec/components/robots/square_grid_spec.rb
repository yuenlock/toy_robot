# frozen_string_literal: true

require './components/robots/square_grid'

RSpec.describe Robots::SquareGrid do
  let(:coord_x) { 1 }
  let(:coord_y) { 2 }

  describe '#valid?' do
    subject { described_class.new }

    context 'Good coords' do
      let(:good_coords) { [{ x: 0, y: 0 }, { x: 5, y: 0 }, { x: 0, y: 5 }, { x: 5, y: 5 }] }

      it 'returns true' do
        good_coords.each do |coords|
          expect(subject.valid?(coords)).to eq true
        end
      end
    end

    context 'Bad coords' do
      let(:good_coords) { [{ x: -1, y: 0 }, { x: 8, y: 0 }, { x: 0, y: -1 }, { x: 5, y: 8 }] }

      it 'returns true' do
        good_coords.each do |coords|
          expect(subject.valid?(coords)).to eq false
        end
      end
    end
  end
end
