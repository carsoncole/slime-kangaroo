class StripeCharge

  def initialize(event)
    @stripe_charge = event.data.object
  end

  def process
    charge.update(charged_at: Time.zone.now) if charge
  end

  private

  def charge
    @charge ||= Order.where(amount: @stripe_charge.amount / 100.0).first! rescue nil
    # @charge ||= Order.where(stripe_charge_id: @stripe_charge.id).first! rescue nil
  end
end
