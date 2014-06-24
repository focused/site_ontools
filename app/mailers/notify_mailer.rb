class NotifyMailer < ActionMailer::Base
  default from: "info@ontools.ru"

  def fast_order(fast_order)
    @data = fast_order
    mail(to: "pletenetsbox@gmail.com")
  end
end
