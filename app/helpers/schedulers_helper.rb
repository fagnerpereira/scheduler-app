module SchedulersHelper

  def accessible?(day, hour)
    return true if day > today || (day == today && hour > time_now)
    return false
  end

  def scheduled_date(scheduled_day, hour)
    if today == scheduled_day
      Time.now.strftime("%d/%m/%y #{hour}")
    elsif today < scheduled_day
      (Time.now + (scheduled_day - today).days).strftime("%d/%m/%y #{hour}")
    end
  end

  private

  def today
    Time.now.strftime("%u").to_i
  end

  def time_now
    Time.now.strftime("%H").to_i
  end
end

