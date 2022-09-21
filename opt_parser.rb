# frozen_string_literal: true

require 'optparse'
require 'ostruct'

module OptParser
  attr_accessor :opts

  def parse_opts(args)
    @opts = OpenStruct.new
    @opts.verbose            = false
    @opts.color              = true
    @opts.env                = 'prd'
    @opts.x_api_key          = nil
    @opts.project_id         = nil
    @opts.nuclei_output      = nil
    @opts.verify             = false
    @opts.file_name          = Time.now.strftime("output.%m%d%Y_%H%M%S.json")
    @opts.dirname            = File.absolute_path(File.dirname(__FILE__))
    @opts.unregistered_dir   = File.join(Dir.tmpdir , 'unregistered')

    opt_parser = OptionParser.new do |opts|
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
        Electrosphere is amazing microservice for registering 
        vulnerabilities found by nuclei on Conviso Platform         
        Developed by @rd-team          
                          
      END
      opts.banner = banner
      opts.separator 'Options:'
      opts.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
        @opts.verbose = v
      end

      opts.on('-n', '--[no-]color', 'Enable/disable coloring') do |v|
        @opts.color = v
      end

      opts.on( '-e', '--env=ENV', ['prd', 'hml'], 'Environment to register findings, [prd, hml] defalt prd' ) do |env|
        @opts.env = env
      end

      opts.on('-k', '--x_api_key=X_API_KEY', 'Conviso Plataform API KEY') do |x_api_key|
        @opts.x_api_key = x_api_key
      end

      opts.on('-p', '--project_id=PROJECT_ID', 'Conviso Plataform project id') do |project_id|
        @opts.project_id = project_id
      end

      opts.on('-i', '--nuclei_output=OUTPUT', 'Nuclei output in json format') do |nuclei_output|
        @opts.nuclei_output = nuclei_output
      end

      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end
    end

    opt_parser.parse!(args)
    @opts
  end
end
