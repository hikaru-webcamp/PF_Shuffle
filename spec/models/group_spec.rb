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
      it '2文字以下はNG' do
        group.name =  Faker::Name.name(number: 2)
        is_expected.to eq true
      end
      it '21文字以上はNG' do
        group.name =  Faker::Name.name(number: 21)
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '空欄でないこと' do
        group.introduction = ''
        is_expected.to eq false
      end
      it '201文字以上はNG' do
        group.introduction =  Faker::Name.name(number: 201)
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
        expect(Group.reflect_on_association(:group_users).macro).to eq :has_many
      end
    end
  end
end
