module SchedulersHelper

  def accessible?(day)
    return true if today <= day
    false
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
end

