require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:text) }
  end

  context 'Associations' do
    it { should belong_to(:post) }
    it { should belong_to(:author) }
  end
end
