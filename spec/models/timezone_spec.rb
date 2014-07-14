require 'rails_helper'

describe Timezone do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :city }
    it { should validate_presence_of :gmt }
    it { should validate_presence_of :user }

    it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:user_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
