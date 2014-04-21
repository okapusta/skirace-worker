class Components::LcdScreen
  takes :gpio, :options, :time_sleep

  def init
    gpio.write(options.lcd.pins.lcd_rs, LOW)

    [ 0b0011, 
      0b0011, 
      0b0011 ].each do |bits|
        lcd_write_4_bits(lcd_binary_4_bit_array(bits))
      
        lcd_delay_miliseconds(42)
    end 

    [ 0b0010, 
      0b0010,
      0b1000, 
      0b0000,
      0b1000, 
      0b0000, 
      0b0001, 
      0b0000, 
      0b0111 ].each do |bits|
        lcd_write_4_bits(lcd_binary_4_bit_array(bits))
      
        lcd_delay_miliseconds
    end

    lcd_delay_miliseconds(10)

    [ 0b0000, 0b1111, 0b0000, 0b0110 ].each do |bits|
      lcd_write_4_bits(lcd_binary_4_bit_array(bits))
    end
  end

  def write(string)
    lcd_string(string)   
  end

  # 0x01       clear display
  def clear
    gpio.write(options.lcd.pins.lcd_rs, LOW)

    [0b0000, 0b0001].each do |bits|
      lcd_write_4_bits(lcd_binary_4_bit_array(bits))
    end
  end


  private

    def lcd_write_4_bits(bits)
      bits.each_with_index do |item, index|
        if item.to_i == 1 
          gpio.write(lcd_data_pins[index], HIGH)
        else
          gpio.write(lcd_data_pins[index], LOW)
        end
      end
      lcd_enable()
    end

    def lcd_binary_4_bit_array(integer)
      integer.to_s(2).rjust(4, '0').split(//)
    end

    def lcd_binary_8_bit_array(integer)
      integer.to_s(2).rjust(8, '0').split(//)
    end

    def lcd_string(string)
      message = string.ljust(options.lcd.width)

      message.split(//).each do |char|
        if char == "\n"
          gpio.write(options.lcd.pins.lcd_rs, LOW)

          lcd_binary_8_bit_array(options.lcd.line_2).each_slice(4).each do |bits|
            lcd_write_4_bits(bits)
          end
        else
          gpio.write(options.lcd.pins.lcd_rs, HIGH)

          lcd_binary_8_bit_array(char.ord).each_slice(4).each do |bits|
            lcd_write_4_bits(bits)
          end
        end
      end 
    end

    def lcd_delay_microseconds(microseconds)
      sleep(microseconds/1000000.to_f)
    end

    def lcd_delay_miliseconds(miliseconds = 1)
      sleep(miliseconds/1000.to_f)
    end

    def lcd_delay(time = 1)
      sleep(time*time_sleep)
    end

    def lcd_enable
      [LOW, HIGH, LOW].each do |mode|
        gpio.write(options.lcd.pins.lcd_e, mode)
        lcd_delay(10)
      end
    end

    def lcd_reset_pins
      lcd_data_pins.each do |pin|
        gpio.write(pin, LOW)
      end

      lcd_enable
    end

    def lcd_data_pins
      %w(lcd_d4 lcd_d5 lcd_d6 lcd_d7).map do |pin|
        options.lcd.pins.send(pin)
      end.reverse
    end

end
