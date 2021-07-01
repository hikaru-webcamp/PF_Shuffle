# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let!(:owner){create(:user)}
    let!(:group){create(:group, owner_id: owner.id)}
    let!(:user){create(:user)}
  

    context 'titleカラム' do
      it '空欄でないこと' do
        expect(build(:post,user_id: user.id, group_id: group.id, title: "")).to be_invalid
      end
      it '30文字以下であること：30文字はOK' do
        expect(build(:post,user_id: user.id, group_id: group.id, title: Faker::Lorem.characters(number: 30) )).to be_valid
      end
      it '30文字以下であること：31文字はNG' do
        expect(build(:post,user_id: user.id, group_id: group.id,  title: Faker::Lorem.characters(number: 31) )).to be_invalid
      end
    end

    context 'bodyカラム' do
      it '空欄では保存されない' do
        expect(build(:post,user_id: user.id, group_id: group.id,  body: "")).to be_invalid
      end
      it '500文字以下であること：500文字以上はOK' do
        expect(build(:post,user_id: user.id, group_id: group.id, body: Faker::Lorem.characters(number: 500) )).to be_valid
      end
      it '500文字以下であること：501文字以上はNG' do
        expect(build(:post,user_id: user.id, group_id: group.id, body: Faker::Lorem.characters(number: 501) )).to be_invalid
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
