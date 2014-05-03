class Formatter
  def time_format(seconds)
    '%d minutes, %d seconds' %
    [60,60].inject([seconds]) do |result, unit|
      result[0,0] = result.shift.divmod(unit)
      result
    end
  end
end