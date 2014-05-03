class Formatter
  def time_format(seconds)
    '%d days, %d hours, %d minutes, %d seconds' %
    [60,60,24].inject([seconds]) do |result, unit|
      result[0,0] = result.shift.divmod(unit)
      result
    end
  end
end