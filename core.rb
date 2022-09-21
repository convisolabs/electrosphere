require_relative 'opt_parser'
require_relative 'printer'
require_relative 'reporter'
require 'json'
require 'faraday'

class Core
  include OptParser
  include Reporter
  include Printer

  def initialize
    
  end

  def validate_opts
    if @opts.x_api_key.nil?
      print_error('x-api-key (-k) not passed')
      exit 0
    end

    if @opts.project_id.nil?
      print_error('project_id (-p) not passed')
      exit 0
    end

    if @opts.nuclei_output.nil?
      print_error('nuclei_output (-i) not passed')
      exit 0
    end

    if File.extname(@opts.nuclei_output) != '.json'
      print_error('nuclei_output is not a json file')
      exit 0
    end
  end

  def start
    validate_opts
    mount_url
    create_client
    test_connection
    print_banner
    
    starting_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    print_title('Starting vulnerability registration, wait...')

    process_json

    ending_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed_time = Time.at(ending_time - starting_time).utc.strftime('%H:%M:%S')
    
    print_success("Time elapsed: #{elapsed_time}")
  end

  private

  def mount_url
    @opts.env == 'prd' ? set_host('app') : set_host('homologa')
  end

  def set_host(env)
    @opts.host = "https://#{env}.convisoappsec.com"
  end

  def create_client
    @opts.client = Faraday.new(@opts.host) do |f|
      f.request :multipart
      f.request :url_encoded
      f.headers['x-api-key'] = @opts.x_api_key
    end
  end

  def test_connection
    response = @opts.client.post('/graphql')

    if response.status == 401
      print_error(JSON.parse(response.body)['errors'][0]['message'])
      exit 0
    end
  rescue Faraday::Error => e
    print_error(e)
    exit 0
  end

end
