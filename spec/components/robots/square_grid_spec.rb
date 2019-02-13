# frozen_string_literal: true

require './components/robots/square_grid'

RSpec.describe Robots::SquareGrid do
  let(:coord_x) { 1 }
  let(:coord_y) { 2 }

  describe '#valid?' do
    subject { described_class.new }

    context 'Good coords' do
      let(:good_coords) {
        [
          instance_double('Robots::Location', x: 0, y: 0),
          instance_double('Robots::Location', x: 5, y: 0),
          instance_double('Robots::Location', x: 0, y: 5),
          instance_double('Robots::Location', x: 5, y: 5)
        ]
      }

      it 'returns true' do
        good_coords.each do |coords|
          expect(subject.valid?(coords)).to eq true
        end
      end
    end

    context 'Bad coords' do
      let(:bad_coords) {
        [
          instance_double('Robots::Location', x: -1, y: 0),
          instance_double('Robots::Location', x: 8, y: 0),
          instance_double('Robots::Location', x: 0, y: -1),
          instance_double('Robots::Location', x: 5, y: 8)
        ]
      }

      it 'returns true' do
        bad_coords.each do |coords|
          expect(subject.valid?(coords)).to eq false
        end
      end
    end
  end

  describe '#occupy' do
    let(:vacant_location) { instance_double('Robots::Location', x: 0, y: 1) }
    let(:occupied_locations) {
      [
        instance_double('Robots::Location', x: 1, y: 1),
        instance_double('Robots::Location', x: 2, y: 2),
        instance_double('Robots::Location', x: 3, y: 3)
      ]
    }

    let(:test_locations) {
      [
        instance_double('Robots::Location', x: 2, y: 2),
        instance_double('Robots::Location', x: 1, y: 1),
        instance_double('Robots::Location', x: 3, y: 3)
      ]
    }
    subject { described_class.new }

    it 'cell becomes invalid' do
      occupied_locations.each do |location|
        subject.occupy(location)
      end

      test_locations.each do |location|
        expect(subject.valid?(location)).to eq false
      end

      expect(subject.valid?(vacant_location)).to eq true
    end
  end

  describe '#vacate' do
    let(:swarm) {
      [
        instance_double('Robots::Location', x: 1, y: 1),
        instance_double('Robots::Location', x: 2, y: 2),
        instance_double('Robots::Location', x: 3, y: 3)
      ]
    }
    subject { described_class.new }

    it 'cell becomes valid' do
      swarm.each do |location|
        subject.occupy(location)
      end

      swarm.each do |location|
        subject.vacate(location)
        expect(subject.valid?(location)).to eq true
      end
    end
  end

  describe '#relocate' do
    let(:old_location) { instance_double('Robots::Location', x: 1, y: 1) }
    let(:new_location) { instance_double('Robots::Location', x: 2, y: 2) }

    subject { described_class.new }

    it 'cell becomes valid' do
      subject.occupy(old_location)

      subject.relocate(old_location, new_location)
      expect(subject.valid?(old_location)).to eq true
      expect(subject.valid?(new_location)).to eq false
    end

    it 'handles no old_location' do
      subject.relocate(nil, new_location)

      expect(subject.valid?(new_location)).to eq false
    end
  end
end
