# frozen_string_literal: true

# Common configuration for models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
