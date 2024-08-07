require "rails_helper"

describe CurbService do
  subject { described_class.new(:local) }

  describe '#retrieve_local_throw' do
    it "returns a valid choice" do
      expect(subject.retrieve_local_throw).to be_in(RockPaperScissorsService::CHOICES.keys)
    end
  end

  describe '#retrieve_curb_throw' do
    subject { described_class.new(:mock) }

    before { allow(subject).to receive(:retrieve_curb_response).and_return(response) }

    let(:response) { double(Faraday::Response, status: status, body: body) }

    context 'when response is successful' do
      let(:status) { 200 }
      let(:body) { { "statusCode" => 200, "body" => "rock" }.to_json }

      it "returns server's choice" do
        expect(subject.retrieve_curb_throw).to eq("rock")
      end
    end

    context 'when server fails to return a choice' do
      let(:status) { 500 }
      let(:body) { { "statusCode" => 500, "body" => "Something went wrong. Please try again later." }.to_json }

      it 'returns nil' do
        expect(subject.retrieve_curb_throw).to eq(nil)
      end
    end

    context 'when server crashes' do
      let(:status) { 500 }
      let(:body) { { "message" => "Internal server error" }.to_json }

      it 'returns nil' do
        expect(subject.retrieve_curb_throw).to eq(nil)
      end
    end

    context 'when server times out' do
      let(:response) { nil }

      it 'returns nil' do
        expect(subject.retrieve_curb_throw).to eq(nil)
      end
    end
  end

  describe '#retrieve_throw' do
    subject { described_class.new(:mock) }

    before { allow(subject).to receive(:retrieve_curb_throw).and_return(curb_throw) }
    before { allow(subject).to receive(:retrieve_local_throw).and_return(local_throw) }

    let(:local_throw) { RockPaperScissorsService::SCISSORS }

    context 'when curb server returns a choice' do
      let(:curb_throw) { RockPaperScissorsService::PAPER }

      it 'returns that choice' do
        expect(subject.retrieve_throw).to eq(curb_throw)
      end
    end

    context 'when curb server does not return a choice' do
      let(:curb_throw) { nil }

      it 'uses local throw' do
        expect(subject).to receive(:retrieve_local_throw)
        expect(subject.retrieve_throw).to eq(local_throw)
      end
    end
  end
end
