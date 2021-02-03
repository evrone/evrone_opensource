require "test_helper"

class ReadmeCasesTest < ActiveSupport::TestCase
  FILES = [
    "test/fixtures/files/readmes/thoughtbot-paul-revere",
    "test/fixtures/files/readmes/maetl-calyx"
  ].freeze

  test "converts readmes successfuly" do
    Dir.mktmpdir do |dir|
      FILES.each do |file|
        file_before = Rails.root.join("#{file}--before.md")
        file_after = Rails.root.join("#{file}--after.md")
        modified_file = [dir, "/README.md"].join

        FileUtils.cp(file_before, modified_file)

        PipelineService::Improvement.call(dir)

        assert_equal File.read(file_after), File.read(modified_file)
      end
    end
  end
end
