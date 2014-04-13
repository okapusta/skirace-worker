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

    # lcd_write(0x01, LOW)
  end

  private

    # 0x33, 0x32 initialize
    # 0x28       matrix 5x7
    # 0x0c       disable cursor
    # 0x06       move cursor right
    def lcd_init
      gpio.write(options.lcd.pins.lcd_rs, LOW)

      # init display
      3.times do
        lcd_data_pins.each do |pin|
          if lcd_data_pins.first(2).include?(pin)
            p "init pin: #{pin}"

            gpio.write(pin, HIGH)
          else
            gpio.write(pin, LOW)
          end
        end
        lcd_enable
      end 

      lcd_set_4_bit_mode()
      lcd_set_no_display_lines(2)

      lcd_display_off()
  
      # 0x33, 0b00000011, 0x28, 0x0c, 
      lcd_write(0x01, LOW)
      
      lcd_entry_mode_set

      lcd_display_setup(HIGH, HIGH, LOW)

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
      p lcd_binary(bits)
      p %w(lcd_d4 lcd_d5 lcd_d6 lcd_d7).reverse
      
      lcd_write_bits((0..3), mode, lcd_binary(bits))
      lcd_write_bits((3..7), mode, lcd_binary(bits))
    end

    def lcd_write_bits(range, mode, bits)
      gpio.write(options.lcd.pins.lcd_rs, mode)

      offset = range.include?(0) ? 0 : 4
      
      range.each do |i| 
        if bits[i].to_i == 1
          gpio.write(lcd_data_pins.reverse[i - offset], HIGH)
        else
          gpio.write(lcd_data_pins.reverse[i - offset], LOW)
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

      lcd_enable
    end

    def lcd_data_pins
      %w(lcd_d4 lcd_d5 lcd_d6 lcd_d7).map do |pin|
        options.lcd.pins.send(pin)
      end
    end

    def lcd_set_4_bit_mode
      2.times do 
        lcd_data_pins.each do |pin| 
          if lcd_data_pins[1] == pin
            gpio.write(pin, HIGH)
          else
            gpio.write(pin, LOW)
          end
        end
        
        lcd_enable
      end
    end

    def lcd_set_no_display_lines(n = 2)
      lcd_data_pins.each do |pin|
        if pin == 1
          gpio.write(pin, ( n == 2 ? HIGH : LOW ))
        else 
          gpio.write(pin, LOW)
        end
      end

      lcd_enable
    end

    def lcd_display_off
      lcd_reset_pins

      lcd_data_pins.each do |pin|
        if pin == 1
          gpio.write(pin, HIGH) 
        else
          gpio.write(pin, LOW)
        end
      end

      lcd_enable
    end

    def lcd_entry_mode_set
      lcd_reset_pins

      lcd_data_pins.each do |pin|
        if lcd_data_pins.first(3).include?(pin)
          gpio.write(pin, HIGH)
        else
          gpio.write(pin, LOW)
        end
      end
    end

    def lcd_display_setup(display, cursor, type)
      lcd_reset_pins

      gpio.write(options.lcd.pins.lcd_d7, HIGH)
      gpio.write(options.lcd.pins.lcd_d7, display)
      gpio.write(options.lcd.pins.lcd_d7, cursor)
      gpio.write(options.lcd.pins.lcd_d7, type)

      lcd_enable
    end

end
