
class CASino::ProxyGrantingTicket < CASino::ApplicationRecord
  include CASino::ModelConcern::Ticket

  self.ticket_prefix = 'PGT'.freeze

  before_validation :ensure_iou_present

  validates :ticket, uniqueness: true
  validates :iou, uniqueness: true

  belongs_to :granter, polymorphic: true, optional: true
  has_many :proxy_tickets, dependent: :destroy

  private
  def ensure_iou_present
    self.iou ||= create_random_ticket_string('PGTIOU')
  end
end
