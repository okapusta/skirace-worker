class Components::LcdScreen
  takes :gpio, :options

  def write(string)
    clear
    
    lcd_string(string)   
  end

  # 0x33, 0x32 initialize
  # 0x28       matrix 5x7
  # 0x0c       disable cursor
  # 0x06       move cursor right
  # 0x01       clear display
  def clear
    [0x33, 0x32, 0x28, 0x0c, 0x06, 0x01].each do |bit|
      lcd_write(bit, LOW)
    end
  end

  private

    def lcd_binary(integer)
      integer.to_s(2).rjust(8, '0')
    end

    def lcd_string(string)
      message = string.ljust(options.lcd.width)
      lcd_write(options.lcd.line_1)

      message.split(//).each do |char|
        if char == "\n"
          lcd_write(options.lcd.line_2)
        else
          lcd_write(char.ord, HIGH)
        end
      end 
    end

    def lcd_write(bits, mode = LOW)
      lcd_delay(10)

      bits = lcd_binary(bits)
      gpio.write(options.lcd.pins.lcd_rs, mode)

      lcd_write_bits((0..3), bits)
      lcd_write_bits((3..7), bits)
    end

    def lcd_write_bits(range, bits)
      lcd_reset_pins

      bits = bits.to_i
      
      if bits&0x10 == bits&0x10 
        gpio.write(options.lcd.lcd_d4, HIGH)
      elsif bits&0x20 == bits&0x20
        gpio.write(options.lcd.lcd_d5 HIGH)
      elsif bits&0x40 == bits&0x40
        gpio.write(options.lcd.lcd_d6 HIGH)    
      elsif bits&0x80 == bits&0x80 
        gpio.write(options.lcd.lcd_d7 HIGH)
      end
      lcd_enable
      if bits&0x01 == bits&0x01 
        gpio.write(options.lcd.lcd_d4, HIGH)
      elsif bits&0x02 == bits&0x02
        gpio.write(options.lcd.lcd_d5 HIGH)
      elsif bits&0x04 == bits&0x04
        gpio.write(options.lcd.lcd_d6 HIGH)    
      elsif bits&0x08 == bits&0x08 
        gpio.write(options.lcd.lcd_d7 HIGH)
      end
      lcd_enable
      # offset = range.include?(0) ? 0 : 4
      
      # range.each do |i| 
      #   if bits[i] == '1'
      #     gpio.write(lcd_data_pins[i - offset], HIGH)
      #   end
      # end
      # lcd_enable
    end

    def lcd_delay(microseconds)
      sleep(microseconds/1000000.to_f)
    end

    def lcd_enable
      [HIGH, LOW].each do |mode|
        lcd_delay(50)
        gpio.write(options.lcd.pins.lcd_e, mode)
      end
    end

    def lcd_reset_pins
      lcd_data_pins.each do |pin|
        gpio.write(pin, LOW)
      end
    end

    def lcd_data_pins
      %w(lcd_d4 lcd_d5 lcd_d6 lcd_d7).map do |pin|
        options.lcd.pins.send(pin)
      end
    end

end
