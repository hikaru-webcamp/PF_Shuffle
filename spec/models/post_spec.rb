# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user)  { create(:user)                   }
    let!(:post) { create(:post, user_id: user.id) }

    context 'titleカラム' do
      it '空欄では保存されない' do
        post.title = ''
        expect(post).not_to be_valid
      end
      it '31文字以上はNG' do
        post.title = Faker::Lorem.characters(number: 31)
        expect(post).not_to be_valid
      end
    end

    context 'bodyカラム' do
      it '空欄では保存されない' do
        post.body = ''
        expect(post).not_to be_valid
      end
      it '501文字以上はNG' do
        post.body = Faker::Lorem.characters(number: 501)
        expect(post).not_to be_valid
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Groupモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:group).macro).to eq :belongs_to
      end
    end
    
    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:likes).macro).to eq :has_many
      end
    end

    context 'Coomentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

  end
end
