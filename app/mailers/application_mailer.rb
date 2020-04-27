# frozen_string_literal: true

# Common configuration for mailers
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
