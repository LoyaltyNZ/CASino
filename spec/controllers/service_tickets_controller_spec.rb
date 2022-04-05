require 'spec_helper'

describe CASino::ServiceTicketsController do
  routes { CASino::Engine.routes }

  describe 'GET "validate"' do
    let(:request_options) { {params: params} }
    let(:service_ticket) { FactoryBot.create :service_ticket }
    let(:service) { service_ticket.service }
    let(:parameters) { { service: service, ticket: service_ticket.ticket }}
    let(:params) { parameters }
    let(:username) { service_ticket.ticket_granting_ticket.user.username }
    let(:response_text_success) { "yes\n#{username}\n" }
    let(:response_text_failure) { "no\n\n" }

    render_views

    context 'with an unconsumed service ticket' do
      context 'without renew flag' do
        it 'consumes the service ticket' do
          get :validate, **request_options
          service_ticket.reload.consumed.should == true
        end

        it 'answers with the expected response text' do
          get :validate, **request_options
          response.body.should == response_text_success
        end
      end

      context 'with renew flag' do
        let(:params) { parameters.merge renew: 'true' }

        context 'with a service ticket without issued_from_credentials flag' do
          it 'consumes the service ticket' do
            get :validate, **request_options
            service_ticket.reload.consumed.should == true
          end

          it 'answers with the expected response text' do
            get :validate, **request_options
            response.body.should == response_text_failure
          end
        end

        context 'with a service ticket with issued_from_credentials flag' do
          before(:each) do
            service_ticket.update_attribute(:issued_from_credentials, true)
          end

          it 'consumes the service ticket' do
            get :validate, **request_options
            service_ticket.reload.consumed.should == true
          end

          it 'answers with the expected response text' do
            get :validate, **request_options
            response.body.should == response_text_success
          end
        end
      end
    end

    context 'with a consumed service ticket' do
      before(:each) do
        service_ticket.update_attribute(:consumed, true)
      end

      it 'answers with the expected response text' do
        get :validate, **request_options
        response.body.should == response_text_failure
      end
    end
  end

  describe 'GET service_validate' do
    let(:service_ticket) { FactoryBot.create :service_ticket }
    let(:service) { service_ticket.service }
    let(:user) { service_ticket.ticket_granting_ticket.user }
    let(:parameters) { { service: service, ticket: service_ticket.ticket } }
    let(:request_options) { { params: parameters } }

    context 'when jwt processor is not defined' do
      before do
        CASino.send(:remove_const, "UserJwtProcessor") if defined?(CASino::UserJwtProcessor)
      end

      it 'does not update the casino user' do
        expect(user.reload.extra_attributes[:jwt]).to eq(nil)
        get :service_validate, **request_options
        expect(user.reload.extra_attributes[:jwt]).to eq(nil)
      end
    end

    context 'when jwt processor is defined' do
      before do
        require 'dummy/app/processors/dummy_user_jwt_processor'
      end

      it "updates the casino user" do
        expect(user.reload.extra_attributes[:jwt]).to eq(nil)
        get :service_validate, **request_options
        expect(user.reload.extra_attributes[:jwt]).to eq("refresh!")
      end
    end
  end
end
