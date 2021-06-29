# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Groupモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # テスト対象の記述を1箇所にまとめる
    subject { group.valid? }
    
       context 'nameカラム' do
      it '空欄でないこと' do
        group.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字はNG' do
        group.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字はOK' do
        group.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '50文字以下であること: 50文字はOK' do
        group.name = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '50文字以下であること: 51文字はNG' do
        group.name = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
      it '一意性があること' do
        group.name = other_group.name
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '空欄でないこと' do
        group.introduction = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        group.introduction = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        group.introduction = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
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
        expect(Group.reflect_on_association(:groups).macro).to eq :has_many
      end
    end

    context 'グループユーザーモデルとの関係' do
      it '1:Nとなっている' do
        expect(Group.reflect_on_association(:group_groups).macro).to eq :has_many
      end
    end
  end
end
