require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#update_counter' do
  subject { Post.new(title: 'Post title', text: 'Long lorem ipsum text', author: User.first) }

    it 'should update the post likes counter' do
      subject.increment!(:likes_counter)
      expect(subject.likes_counter).to be(1)
    end
  end
end