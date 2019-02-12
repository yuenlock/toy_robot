# frozen_string_literal: true

require './components/utils/file_reader'

RSpec.describe Utils::FileReader do
  context 'valid filename' do
    let(:filename) { 'valid_file_name' }
    let(:raw_lines) { ["PLACE 1,2,EAST\n", "\n", "\n", "MOVE\n", "LEFT\n", "REPORT\n", "Buy\n", "lower\n"] }
    let(:cleaned_lines) { ['PLACE 1,2,EAST', 'MOVE', 'LEFT', 'REPORT', 'Buy', 'lower'] }
    let(:result) { { commands: cleaned_lines } }

    subject { described_class.call(filename) }

    it 'returns array of lines' do
      expect(File).to receive(:file?).with(filename).and_return true
      expect(File).to receive(:readlines).with(filename).and_return raw_lines
      expect(subject).to eq result
    end
  end

  context 'invalid filename' do
    let(:bad_filename) { 'invalid_file_name' }
    let(:file_not_found_msg) { "Can't find File #{bad_filename}." }
    let(:result) { { error: file_not_found_msg } }

    subject { described_class.call(bad_filename) }

    it 'file not found msg' do
      expect(subject).to eq result
    end
  end
end
