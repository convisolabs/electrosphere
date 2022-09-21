require 'colored'
require 'date'

module Printer
  def enable_color(flag = true)
    @color = flag
  end

  def print_title(s, level = 0)
    pad = " " * (level * 4)
    out_s = "#{pad}[*] #{s}"
    if @color
      puts out_s.bold.blue
    else
      puts out_s
    end
    @logger.info(out_s) if instance_variable_defined?("@logger")
  end

  def print_normal(s, level = 0)
    pad = " " * (level * 4)
    out_s = "#{pad}#{s}"
    puts out_s
    @logger.info(out_s) if instance_variable_defined?("@logger")
  end

  def print_success(s, level = 0)
    pad = " " * (level * 4)
    out_s = "#{pad}[SUCCESS] #{s}"
    if @color
      puts out_s.bold.green
    else
      puts out_s
    end
    @logger.info(out_s) if instance_variable_defined?("@logger")
  end

  def print_error(s, level = 0)
    pad = " " * (level * 4)
    out_s = "#{pad}[ ERROR ] #{s}"
    if @color
      puts out_s.bold.red
    else
      puts out_s
    end
    @logger.error(out_s) if instance_variable_defined?("@logger")
  end

  def print_with_label(s, label, level = 0)
    pad = " " * (level * 4)
    out_s = "#{pad}[#{label}] #{s}"
    puts out_s
    @logger.info(out_s) if instance_variable_defined?("@logger")
  end

  def print_debug(s, level = 0)
    pad = " " * (level * 4)
    now = DateTime.now.strftime('%d/%m/%Y %H:%M:%S.%3N')
    out_s = "#{pad}DEBUG|#{now}| #{s}"
    if @color
      puts out_s.bold.yellow
    else
      puts out_s
    end
    @logger.debug(out_s) if instance_variable_defined?("@logger")
  end

  def print_warning(s, level = 0)
    pad = " " * (level * 4)
    out_s = "#{pad}[WARNING] #{s}"
    if @color
      puts out_s.bold.yellow
    else
      puts out_s
    end
    @logger.info(out_s) if instance_variable_defined?("@logger")
  end

  def print_banner

      banner = <<-END

        ██████████ ████                     █████                                         █████                                 
       ░░███░░░░░█░░███                    ░░███                                         ░░███                                  
        ░███  █ ░  ░███   ██████   ██████  ███████   ████████   ██████   █████  ████████  ░███████    ██████  ████████   ██████ 
        ░██████    ░███  ███░░███ ███░░███░░░███░   ░░███░░███ ███░░███ ███░░  ░░███░░███ ░███░░███  ███░░███░░███░░███ ███░░███
        ░███░░█    ░███ ░███████ ░███ ░░░   ░███     ░███ ░░░ ░███ ░███░░█████  ░███ ░███ ░███ ░███ ░███████  ░███ ░░░ ░███████ 
        ░███ ░   █ ░███ ░███░░░  ░███  ███  ░███ ███ ░███     ░███ ░███ ░░░░███ ░███ ░███ ░███ ░███ ░███░░░   ░███     ░███░░░  
        ██████████ █████░░██████ ░░██████   ░░█████  █████    ░░██████  ██████  ░███████  ████ █████░░██████  █████    ░░██████ 
       ░░░░░░░░░░ ░░░░░  ░░░░░░   ░░░░░░     ░░░░░  ░░░░░      ░░░░░░  ░░░░░░   ░███░░░  ░░░░ ░░░░░  ░░░░░░  ░░░░░      ░░░░░░  
                                                                                ░███                                            
                                                                                █████                                           
                                                                                ░░░░░                                            
        Electrosphere is a amazing microservice for registering 
        vulnerabilities found by nuclei on Conviso Platform         
        Developed by @rd-team          
                          
      END
    pad = " " * (0 * 4)
    out_s = "#{pad}[SUCCESS] #{banner}"
    if @color
      puts banner.bold.green
    else
      puts banner
    end
    @logger.info(banner) if instance_variable_defined?("@logger")
  end

  def self.included(base)
      #base.instance_variable_set(:@color, true)
  end
end
