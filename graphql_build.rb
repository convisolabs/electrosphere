# frozen_string_literal: true

require_relative 'printer'
require 'json'
require 'yaml'
require 'faraday'
require 'tempfile'

module GraphqlBuild
  include Printer

  def submit_report(report)
    response = create_notification(report)

    report[:evidence_temp].close
    report[:evidence_temp].unlink
    
    data = JSON.parse(response.body)

    if response.status == 200 && data['errors'].nil?
      {
        sent: true,
        message: "The notification '#{report[:matcher_name]}' was created LINK: #{mount_link(data)}"
      }
    else
      {
        sent: false,
        message: "The template '#{report[:matcher_name]}' has errors #{data['errors']}"
      }
    end
  end

  def mount_link(data)
    "#{@opts.host}/scopes/#{data['data']['createNotification']['notification']['companyId']}/projects/#{data['data']['createNotification']['notification']['projectId']}/occurrences/#{data['data']['createNotification']['notification']['id']}"
  end

  def create_notification(report)
    query = {
              "query": '''
                  mutation($input: CreateNotificationInput!) { 
                      createNotification(input: $input) { 
                          errors notification { 
                              companyId
                              projectId 
                              id 
                          }
                      }
                  }
              ''',
              "variables": {
                  "input":  { 
                    projectId: @opts.project_id.to_i, 
                    vulnerabilityTemplateId: report[:vid].to_i, 
                    description: report[:description], 
                    evidenceArchives: [nil]
                  }
              }, 
              "operationName": nil
            }  

    payload = {
      operations: query.to_json,
      map: '{"0":["variables.input.evidenceArchives.0"]}',
      '0': Faraday::UploadIO.new(report[:evidence_temp].open, "text/plain")
    }

    @opts.client.post('/graphql', payload)
  end
end
