module CASino::ControllerConcern::TicketValidator
  extend ActiveSupport::Concern
  include CASino::ServiceTicketProcessor
  include CASino::ProxyGrantingTicketProcessor

  def validate_ticket(ticket)
    validation_result = validate_ticket_for_service(ticket, params[:service], renew: params[:renew])
    if validation_result.success?
      options = { ticket: ticket }
      options[:proxy_granting_ticket] = acquire_proxy_granting_ticket(params[:pgtUrl], ticket) if params[:pgtUrl].present?

      # CASino::UserJwtProcessor is defined at the service implementing CASino
      # e.g: console_sso
      if defined?(CASino::UserJwtProcessor) && ticket.is_a?(CASino::ServiceTicket)
        casino_user = ticket.ticket_granting_ticket.user
        CASino::UserJwtProcessor.refresh_jwt!(casino_user)
      end

      build_ticket_validation_response(true, options)
    else
      build_ticket_validation_response(false,
                                       error_code: validation_result.error_code,
                                       error_message: validation_result.error_message)
    end
  end

  def build_ticket_validation_response(success, options = {})
    render xml: CASino::TicketValidationResponseBuilder.new(success, options).build
  end

  def ensure_service_ticket_parameters_present
    if params[:ticket].blank? || params[:service].blank?
      build_ticket_validation_response(false,
                                       error_code: 'INVALID_REQUEST',
                                       error_message: '"ticket" and "service" parameters are both required')
    end
  end
end
