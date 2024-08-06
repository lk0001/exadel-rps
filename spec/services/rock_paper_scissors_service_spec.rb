require "rails_helper"

describe RockPaperScissorsService do
  describe ".get_winner" do
    subject { described_class.get_winner(user_choice, curb_choice) }

    context 'when player chooses rock' do
      let(:user_choice) { RockPaperScissorsService::ROCK }

      context 'when curb chooses rock' do
        let(:curb_choice) { RockPaperScissorsService::ROCK }

        it 'returns TIE' do
          expect(subject).to eq(described_class::TIE)
        end
      end

      context 'when curb chooses paper' do
        let(:curb_choice) { RockPaperScissorsService::PAPER }

        it 'returns CURB_WON' do
          expect(subject).to eq(described_class::CURB_WON)
        end
      end

      context 'when curb chooses scissors' do
        let(:curb_choice) { RockPaperScissorsService::SCISSORS }

        it 'returns USER_WON' do
          expect(subject).to eq(described_class::USER_WON)
        end
      end
    end

    context 'when player chooses paper' do
      let(:user_choice) { RockPaperScissorsService::PAPER }

      context 'when curb chooses rock' do
        let(:curb_choice) { RockPaperScissorsService::ROCK }

        it 'returns USER_WON' do
          expect(subject).to eq(described_class::USER_WON)
        end
      end

      context 'when curb chooses paper' do
        let(:curb_choice) { RockPaperScissorsService::PAPER }

        it 'returns TIE' do
          expect(subject).to eq(described_class::TIE)
        end
      end

      context 'when curb chooses scissors' do
        let(:curb_choice) { RockPaperScissorsService::SCISSORS }

        it 'returns CURB_WON' do
          expect(subject).to eq(described_class::CURB_WON)
        end
      end
    end

    context 'when player chooses scissors' do
      let(:user_choice) { RockPaperScissorsService::SCISSORS }

      context 'when curb chooses rock' do
        let(:curb_choice) { RockPaperScissorsService::ROCK }

        it 'returns CURB_WON' do
          expect(subject).to eq(described_class::CURB_WON)
        end
      end

      context 'when curb chooses paper' do
        let(:curb_choice) { RockPaperScissorsService::PAPER }

        it 'returns USER_WON' do
          expect(subject).to eq(described_class::USER_WON)
        end
      end

      context 'when curb chooses scissors' do
        let(:curb_choice) { RockPaperScissorsService::SCISSORS }

        it 'returns TIE' do
          expect(subject).to eq(described_class::TIE)
        end
      end
    end

    context "when player's choice is invalid" do
      context "(uppercase)" do
        let(:user_choice) { 'ROCK' }
        let(:curb_choice) { RockPaperScissorsService::ROCK }

        it 'returns ERROR' do
          expect(subject).to eq(described_class::ERROR)
        end
      end

      context "(other string)" do
        let(:user_choice) { 'cat' }
        let(:curb_choice) { RockPaperScissorsService::ROCK }

        it 'returns ERROR' do
          expect(subject).to eq(described_class::ERROR)
        end
      end

      context "(empty string)" do
        let(:user_choice) { '' }
        let(:curb_choice) { RockPaperScissorsService::ROCK }

        it 'returns ERROR' do
          expect(subject).to eq(described_class::ERROR)
        end
      end

      context "(number)" do
        let(:user_choice) { 5 }
        let(:curb_choice) { RockPaperScissorsService::ROCK }

        it 'returns ERROR' do
          expect(subject).to eq(described_class::ERROR)
        end
      end

      context "(nil)" do
        let(:user_choice) { nil }
        let(:curb_choice) { RockPaperScissorsService::ROCK }

        it 'returns ERROR' do
          expect(subject).to eq(described_class::ERROR)
        end
      end
    end

    context "when curb's choice is invalid" do # TODO add other cases, maybe create an example group
      let(:user_choice) { RockPaperScissorsService::ROCK }
      let(:curb_choice) { '' }

      it 'returns ERROR' do
        expect(subject).to eq(described_class::ERROR)
      end
    end
  end
end
