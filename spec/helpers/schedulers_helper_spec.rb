require 'rails_helper'

describe SchedulersHelper do
  describe '#accessible?' do
    context 'when it is not accessible' do
      let(:last_day_of_week) { (Time.now - 1.day).strftime("%u").to_i }

      it { expect(helper.accessible?(last_day_of_week)).to be false }
    end

    context 'when it is accessible' do
      context 'when it is scheduling for today' do
        let(:current_day_of_week) { Time.now.strftime("%u").to_i }

        it { expect(helper.accessible?(current_day_of_week)).to be true }
      end

      context 'when it is scheduling for after' do
        let(:after_day_of_week) { (Time.now + 1.day).strftime("%u").to_i }

        it { expect(helper.accessible?(after_day_of_week)).to be true }
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