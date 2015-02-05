require 'open-uri'
require 'nokogiri'

SENDGRID_STATUS_PAGE_URL = 'https://support.sendgrid.com/hc/en-us/sections/200050018-SendGrid-Status'.freeze

module Lita
  module Handlers
    class SendgridWatch < Handler
      route(/sendgrid status/i, :sendgrid_status, command:true)
      http.get "/sendgrid_status", :sendgrid_status
      def sendgrid_status(response)
        doc = Nokogiri::HTML(open(SENDGRID_STATUS_PAGE_URL))
        topics = []
        doc.css('.article-list li').each do |li|
          topic = li.content.strip
          case topic
          when maintenance? then maintenances.push topic
          when unavailable? then unavailables.push topic
          end
        end
        response.reply render_template('status_list',
        maintenances: maintenances,
        unavailables: unavailables
        )
      end

      private

      def maintenances
        @maintenances ||= []
      end

      def unavailables
        @unavailables ||= []
      end

      def maintenance?
        -> topic { topic.index(/maintenance/i) }
      end

      def unavailable?
        -> topic { topic.index(/unavailable/i) }
      end
    end
    Lita.register_handler(SendgridWatch)
  end
end
