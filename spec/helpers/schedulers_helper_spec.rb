require 'rails_helper'

describe SchedulersHelper do
  describe '#accessible?' do
    context 'when it is not accessible'do
      context 'when it is last_day' do
        let(:last_day_of_week) { (Time.now - 1.day).strftime("%u").to_i }

        it { expect(helper.accessible?(last_day_of_week, 1)).to be false }
      end

      context 'when it is today and hour is last' do
        let(:today) { (Time.now).strftime("%u").to_i }
        let(:last_hour) { (Time.now - 1.hour).strftime("%H").to_i }

        it { expect(helper.accessible?(today, last_hour)).to be false }
      end
    end

    context 'when it is accessible' do
      context 'when it is today and hour is coming' do
        let(:today) { Time.now.strftime("%u").to_i }
        let(:future_hour) { Time.now.strftime("%u").to_i + 1.hour }

        it { expect(helper.accessible?(today, future_hour)).to be true }
      end

      context 'when it is tomorrow or after' do
        let(:tomorrow) { Time.now.strftime("%u").to_i + 1.day }

        it { expect(helper.accessible?(tomorrow, 1)).to be true }
      end
    end
  end

  describe '#scheduled_date' do
    let(:hour) { 6 }
    let(:scheduled_day) { scheduled_datetime.strftime("%u").to_i }
    let(:date_mask) { scheduled_datetime.strftime("%d/%m/%y #{hour}") }

    context 'when it is scheduling for today' do
      let(:scheduled_datetime) { Time.now }

      it { expect(helper.scheduled_date(scheduled_day, hour)).to eq date_mask }
    end

    context 'when it is scheduling for after' do
      let(:scheduled_datetime) { Time.now + 2.days }

      it { expect(helper.scheduled_date(scheduled_day, hour)).to eq date_mask }
    end
  end
end