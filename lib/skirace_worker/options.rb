class Options
  def capacitor
    struct({
      pin: 7
    })
  end

  def lcd
    struct({
        width: 16,
        line_1: 0x80,
        line_2: 0xc0,
        pins: struct({
          lcd_e: 10,  # GPIO pin 8
          lcd_rs: 11, # GPIO pin 7
          lcd_d4: 6,  # GPIO pin 25
          lcd_d5: 5,  # GPIO pin 24
          lcd_d6: 4,  # GPIO pin 23
          lcd_d7: 1   # GPIO pin 18
          })
      })
  end

  private

    def struct(hash)
      OpenStruct.new(hash)
    end
end
