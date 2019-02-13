# frozen_string_literal: true

require './components/robots/position'

RSpec.describe Robots::Position do
  let(:x_coord) { 1 }
  let(:y_coord) { 2 }
  let(:facing)  { 2 }
  let(:facing_name) { 'EAST' }
  let(:locationer) { class_double 'Robots::Location' }
  let(:location) {
    instance_double('Robots::Location', x: x_coord, y: y_coord, to_s: "#{x_coord},#{y_coord}")
  }

  let(:orientation) {
    instance_double('Robots::Orientation', to_s: facing_name, facing: facing)
  }

  describe 'Conversions' do
    subject { described_class.new(location: location, orientation: orientation, locationer: locationer) }

    describe '#report' do
      it { expect(subject.report).to eq "#{x_coord},#{y_coord},#{facing_name}" }
    end
  end

  describe 'Actions' do
    let(:initial_orientation) { instance_double('Robots::Orientation') }
    let(:initial_location) { instance_double('Robots::Location', x: x_coord, y: y_coord) }

    subject { described_class.new(location: initial_location, orientation: initial_orientation, locationer: locationer) }

    describe 'rotate' do
      let(:changed_orientation) { instance_double('Robots::Orientation') }

      describe '#left' do
        it 'turns left' do
          expect(initial_orientation).to receive(:left).and_return changed_orientation
          expect(subject.left).to eq changed_orientation
        end
      end

      describe '#right' do
        it 'turns left' do
          expect(initial_orientation).to receive(:right).and_return changed_orientation
          expect(subject.right).to eq changed_orientation
        end
      end
    end

    describe '#move' do
      let(:changed_location) { instance_double('Robots::Location') }

      it 'moves' do
        expect(initial_orientation).to receive(:move_modifier).and_return(x: 1, y: 0)
        expect(locationer).to receive(:new).with(x: x_coord + 1, y: y_coord).and_return changed_location
        expect(subject.move).to eq changed_location
      end
    end
  end
end
