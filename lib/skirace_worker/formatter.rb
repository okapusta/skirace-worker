class Formatter
  def time_format(seconds)
    '%d m, %d s, %d ms ' %
    [60, 1].inject([seconds]) do |result, unit|
      result[0,0] = result.shift.divmod(unit)
      result
    end
  end
end