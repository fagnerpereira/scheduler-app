require 'rails_helper'

describe Scheduler do
  describe '.disponible_days' do
    let(:day_of_week) { Time.now.strftime("%u").to_i }
    context 'when is schedule to current week' do
      let(:left_days) { 5 - day_of_week }

      before { create(:scheduler, date: Time.now + left_days.days) }

      it { expect(Scheduler.disponible_days.size).not_to be 0 }
    end

    context 'when it is schedul to next week' do
      let(:day_of_week) { Time.now.strftime("%u").to_i }

      before { create(:scheduler, date: Time.now + 7.days) }

      it { expect(Scheduler.disponible_days.size).to be 0 }
    end

    context 'when it is schedul to last week' do
      let(:day_of_week) { Time.now.strftime("%u").to_i }

      before { create(:scheduler, date: Time.now - 7.days) }

      it { expect(Scheduler.disponible_days.size).to be 0 }
    end
  end
end