class Current < ActiveSupport::CurrentAttributes
  attribute :session
  delegate :doctor, to: :session, allow_nil: true
  delegate :patient, to: :session, allow_nil: true
  delegate :user, to: :session, allow_nil: true
end
