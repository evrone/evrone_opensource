# frozen_string_literal: true

# Find new ruby projects and populate the queue
module ProjectExplorerService
  module_function

  def run
    loop do
      populate_projects

      sleep(10)
    end
  end

  def populate_projects
    # TODO
  end
end
