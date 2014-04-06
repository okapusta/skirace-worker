class Components::LcdScreen
  takes :gpio, :options

  def write(string)
    lcd_string(string)   
  end

  # 0x33, 0x32 initialize
  # 0x28       matrix 5x7
  # 0x0c       disable cursor
  # 0x06       move cursor right
  # 0x01       clear display
  def lcd_clear
    [0x33, 0x32, 0x28, 0x0c, 0x06, 0x01].each do |bit|
      lcd_write_bits(bit, LOW)
    end
  end

  private

    def lcd_binary(integer)
      integer.to_s(2).rjust(8, '0')
    end

    def lcd_string(string)
      message = string.ljust(options.lcd.width)
    
      message.split(//).each do |char|
        lcd_write_bits(char.ord, true)
      end 
    end

    def lcd_write_bits(bits, mode = false)
      bits = lcd_binary(bits)
      gpio.write(options.lcd.pins.lcd_rs, mode)

      
      lcd_write_lower_bits(bits)
      lcd_write_upper_bits(bits)
      
    end

    def lcd_write_lower_bits(bits)
      lcd_reset_pins
      (0..4).each do |i| 
        if bits[i] == 1
          gpio.write(lcd_data_pins[i], HIGH)
        end
      end
      lcd_enable
    end

    def lcd_write_upper_bits(bits)
      lcd_reset_pins
      (4..8).each do |i| 
        if bits[i] == 1
          gpio.write(lcd_data_pins[i-4], HIGH)
        end
      end
      lcd_enable
    end

    def lcd_delay(microseconds)
      sleep(microseconds/1000000)
    end

    def lcd_enable
      [LOW, HIGH, LOW].each do |mode|
        gpio.write(options.lcd.pins.lcd_e, mode)
        lcd_delay(1)
      end
    end

    def lcd_reset_pins
      lcd_data_pins.each do |pin|
        gpio.write(pin, LOW)
      end
    end

    def lcd_data_pins
      %w(lcd_d7 lcd_d6 lcd_d5 lcd_d4).map do |pin|
        options.lcd.pins.send(pin)
      end
    end

end
