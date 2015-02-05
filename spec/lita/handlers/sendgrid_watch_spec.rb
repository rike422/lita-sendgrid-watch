require "spec_helper"

describe Lita::Handlers::SendgridWatch, lita_handler: true do
  it { is_expected.to route('sendgrid status').to(:sendgrid_status) }
  it { is_expected.to route_http(:get, "/sendgrid_status").to(:sendgrid_status) }

  let(:sg_watch) { Lita::Handlers::SendgridWatch }

#  describe '#sendgrid_status' do
#    it 'get request for sendgrid status page' do
#      send_message 'sendgrid status'
#      expect(sg_watch).to receive(:open).with Lita::Handlers::SendgridWatch::SENDGRID_STATUS_PAGE_URL
#    end
#  end
end
