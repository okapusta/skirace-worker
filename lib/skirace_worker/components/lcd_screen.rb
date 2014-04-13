class Components::LcdScreen
  takes :gpio, :options

  @@initialized = false

  def write(string)
    clear
    
    lcd_string(string)   
  end

  # 0x01       clear display
  def clear
    lcd_init unless @@initialized

    lcd_write(0x01, LOW)
  end

  private

    # 0x33, 0x32 initialize
    # 0x28       matrix 5x7
    # 0x0c       disable cursor
    # 0x06       move cursor right
    def lcd_init
      3.times do
        lcd_data_pins.first(2).each do |pin|
          gpio.write(options.lcd.pins.lcd_rs, LOW)
          gpio.write(pin, HIGH)
        end
        lcd_enable
      end 

      2.times do 
        gpio.write(options.lcd.pins.lcd_rs, LOW)
        gpio.write(lcd_data_pins[1], HIGH)

        lcd_enable
      end


      # [0x33, 0b00000011, 0x28, 0x0c, 0x06].each do |bit| 
      #   lcd_write(bit, LOW)
      # end

      @@initialized = true
    end

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
      lcd_write_bits((3..7), mode, lcd_binary(bits))
      lcd_write_bits((0..3), mode, lcd_binary(bits))
    end

    def lcd_write_bits(range, mode, bits)
      puts "Bits: #{bits}"
      puts "#{lcd_data_pins.reverse}"
      puts "Range: #{range}, mode: #{mode}"
      
      gpio.write(options.lcd.pins.lcd_rs, mode)
      lcd_reset_pins

      offset = range.include?(0) ? 0 : 4
      
      range.each do |i| 
        if bits[i].to_i == 1
          gpio.write(lcd_data_pins.reverse[i - offset], HIGH)
        end
      end
      lcd_enable
    end

    def lcd_delay(microseconds)
      sleep(microseconds/1000000.to_f)
    end

    def lcd_enable
      [LOW, HIGH, LOW].each do |mode|
        lcd_delay(10)
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
