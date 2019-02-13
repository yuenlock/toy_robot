# frozen_string_literal: true

require './components/utils/file_reader'

RSpec.describe Utils::FileReader do
  context 'valid filename' do
    let(:filename) { 'valid_file_name' }
    let(:raw_lines) { ["PLACE 1,2,EAST\n", "\n", "\n", "MOVE\n", "LEFT\n", "REPORT\n", "Buy\n", "lower\n"] }
    let(:cleaned_lines) { ['PLACE 1,2,EAST', 'MOVE', 'LEFT', 'REPORT', 'Buy', 'lower'] }
    let(:result) { [cleaned_lines, nil] }

    subject { described_class.call(filename) }

    it 'returns array of lines' do
      expect(File).to receive(:file?).with(filename).twice.and_return true
      expect(File).to receive(:readlines).with(filename).and_return raw_lines
      expect(subject).to eq result
    end
  end

  context 'invalid filename' do
    let(:bad_filename) { 'invalid_file_name' }
    let(:file_not_found_msg) { "Can't find File #{bad_filename}." }
    let(:result) { [nil, file_not_found_msg] }

    subject { described_class.call(bad_filename) }

    it 'file not found msg' do
      expect(File).to receive(:file?).with(bad_filename).twice.and_return false

      expect(subject).to eq result
    end
  end

  context 'missing filename' do
    let(:missing_filename) { nil }
    let(:missing_filename_msg) { 'Please provide a valid file.' }
    let(:result) { [nil, missing_filename_msg] }

    subject { described_class.call(missing_filename) }

    it 'missing filename msg' do
      expect(subject).to eq result
    end
  end
end
