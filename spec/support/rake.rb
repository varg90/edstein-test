require 'rake'

shared_context 'rake' do
  let(:rake) { Rake::Application.new }
  let(:task_name) { self.class.top_level_description }
  subject { Rake.application[task_name] }

  before do
    subject.reenable
  end
end
