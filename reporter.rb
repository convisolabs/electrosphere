# frozen_string_literal: true

require_relative 'printer'
require_relative 'graphql_build'
require 'json'
require 'jsonl'
require 'yaml'

module Reporter
  include Printer
  include GraphqlBuild
  
  def process_json
    full_path = File.join('/workspace', @opts.nuclei_output)
    output_parsed = JSONL.parse(File.read(full_path))

    output_parsed.each do |json_line|
      report = prepare_report(json_line)
      unless report.nil?
        response = submit_report(report)
        if response[:sent] == true
          print_success(response[:message])
        else
          print_error(response[:message])
          save_unsent_report(json_line)
        end
      else
        save_unsent_report(json_line)
      end
    end

    print_warning("The unregistered findings are in the file '#{File.join(@opts.unregistered_dir, @opts.file_name)}'") if @opts.verify
  end    

  def prepare_report(json_line)
    template = find_template(json_line) 
    unless template.nil?
      {
        matcher_name: json_line["matcher-name"],
        vid: template['report']['vid'],
        description: prepare_description(json_line, template),
        evidence_temp: create_evidence(json_line)
      }
    end
  end

  def find_template(json_line)
    if File.exists?("#{@opts.dirname}/templates/#{@opts.env}/#{json_line["template-id"]}.yaml")
      template = YAML::load_file("#{@opts.dirname}/templates/#{@opts.env}/#{json_line["template-id"]}.yaml")
      unless template['nuclei-matcher-name'][json_line["matcher-name"]].nil?
        template['nuclei-matcher-name'][json_line["matcher-name"]]
      else
        print_error("The template '#{json_line["matcher-name"]}' not found")
        nil
      end
    else
      print_error("The template '#{json_line["matcher-name"]}' not found")
      nil
    end
  end

  def prepare_description(json_line, template)
    template['report']['description'].gsub('{{host}}', json_line["host"])
  end

  def create_evidence(raw_scanner_info)
    tempfile = Tempfile.new(['evidence_', '.txt'])
    tempfile.write(raw_scanner_info['response'])
    tempfile
  end

  def save_unsent_report(json_line)
    Dir.mkdir(@opts.unregistered_dir) unless Dir.exist?(@opts.unregistered_dir)
    File.write(File.join(@opts.unregistered_dir, @opts.file_name), "#{json_line.to_json}#{$/}", mode: 'a')
    @opts.verify = true
  end
end