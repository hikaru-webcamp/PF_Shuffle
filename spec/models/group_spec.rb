# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Groupモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # テスト対象の記述を1箇所にまとめる
  let!(:owner){create(:user)}
    
    context 'nameカラム' do
      it '空欄でないこと' do
        expect(build(:group,owner_id: owner.id, name: "")).to be_invalid
      end
      it '2文字以上であること: 2文字はNG' do
        expect(build(:group,owner_id: owner.id, name: Faker::Lorem.characters(number: 2) )).to be_valid
      end
      it '50文字以下であること：50文字はOK' do
        expect(build(:group,owner_id: owner.id, name: Faker::Lorem.characters(number: 50) )).to be_valid
      end
      it '50文字以下であること：51文字はNG' do
        expect(build(:group,owner_id: owner.id, name: Faker::Lorem.characters(number: 51) )).to be_invalid
      end
    end

    context 'introductionカラム' do
     it '空欄では保存されない' do
        expect(build(:group, owner_id: owner.id, introduction: "")).to be_invalid
      end
      it '200文字以下であること：200文字以上はOK' do
        expect(build(:group, owner_id: owner.id, introduction: Faker::Lorem.characters(number: 200) )).to be_valid
      end
       it '200文字以下であること：200文字以上はNG' do
        expect(build(:group, owner_id: owner.id, introduction: Faker::Lorem.characters(number: 201) )).to be_invalid
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Group.reflect_on_association(:posts).macro).to eq :has_many
      end
    end

    context 'ユーザーモデルとの関係' do
      it '1:Nとなっている' do
        expect(Group.reflect_on_association(:users).macro).to eq :has_many
      end
    end
  end
end
