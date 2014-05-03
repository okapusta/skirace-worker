class Formatter
  def time_format(seconds)
    '%d m, %.3f s' %
    [60].inject([seconds]) do |result, unit|
      result[0,0] = result.shift.divmod(unit)
      result
    end
  end
end