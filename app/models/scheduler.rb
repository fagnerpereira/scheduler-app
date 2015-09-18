class Scheduler < ActiveRecord::Base
  scope :week, -> { Scheduler.where("date >= ? and date <= ?", Time.now, Time.now + (5 - Time.now.strftime("%u").to_i).days).pluck(:date) }

  def self.disponible_days
    self.week.map do |day|
      "#{day.strftime("%u").to_i}#{day.strftime("%H").to_i}"
    end
  end
end
